<#
.SYNOPSIS
    Обновление базы хешей читов для PandasDetector.
.DESCRIPTION
    Ходит в GitHub API, скачивает релизы читов, считает SHA256, добавляет в базу.
.PARAMETER ReposFile
    Путь к repos.json (по умолчанию - рядом со скриптом).
.PARAMETER BlacklistFile
    Путь к blacklist_hashes.json (по умолчанию - рядом со скриптом).
.PARAMETER MaxFileSizeMB
    Максимальный размер скачиваемого файла (по умолчанию 100 МБ).
.PARAMETER Token
    GitHub токен (если не указан - берётся из $env:GITHUB_TOKEN).
.PARAMETER DryRun
    Не сохранять изменения, только показать, что будет добавлено.
.NOTES
    Автор: xtwont
#>

[CmdletBinding()]
param(
    [string]$ReposFile = "",
    [string]$BlacklistFile = "",
    [int]$MaxFileSizeMB = 100,
    [string]$Token = $env:GITHUB_TOKEN,
    [switch]$DryRun
)

# Определяем путь к скрипту, даже если $PSScriptRoot пуст
$scriptDir = $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($scriptDir)) {
    if ($MyInvocation.MyCommand.Path) {
        $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    } elseif ($MyInvocation.MyCommand.Source) {
        $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Source
    } else {
        $scriptDir = (Get-Location).Path
    }
}

if ([string]::IsNullOrWhiteSpace($ReposFile)) {
    $ReposFile = Join-Path $scriptDir "repos.json"
}
if ([string]::IsNullOrWhiteSpace($BlacklistFile)) {
    $BlacklistFile = Join-Path $scriptDir "blacklist_hashes.json"
}

$ErrorActionPreference = 'Stop'

# === Проверки ===
if (-not (Test-Path $ReposFile)) {
    Write-Host "Файл не найден: $ReposFile" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $BlacklistFile)) {
    Write-Host "Файл не найден: $BlacklistFile. Создаю пустой..." -ForegroundColor Yellow
    @'
{
  "version": "2026-09-30",
  "updated": "2026-09-30T00:00:00Z",
  "count": 0,
  "hashes": {}
}
'@ | Out-File $BlacklistFile -Encoding UTF8
}

if (-not $Token) {
    Write-Host "GitHub токен не указан. Лимит - 60 запросов в час." -ForegroundColor Yellow
    Write-Host "Установите переменную GITHUB_TOKEN или передайте -Token." -ForegroundColor Yellow
    Write-Host ""
}

# === Загрузка конфигов ===
Write-Host "Загрузка конфигурации..." -ForegroundColor Cyan
$reposConfig = Get-Content $ReposFile -Raw | ConvertFrom-Json
$blacklistRaw = Get-Content $BlacklistFile -Raw | ConvertFrom-Json

# Преобразуем hashes в hashtable
$blacklist = @{}
foreach ($prop in $blacklistRaw.hashes.PSObject.Properties) {
    $blacklist[$prop.Name] = $prop.Value
}

Write-Host "Репозиториев: $($reposConfig.repos.Count)" -ForegroundColor Gray
Write-Host "Хешей в базе: $($blacklist.Count)" -ForegroundColor Gray
Write-Host ""

# === Временная папка ===
$tempDir = Join-Path $env:TEMP "cheat_blacklist_update_$(Get-Random)"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
Write-Host "Временная папка: $tempDir" -ForegroundColor Gray
Write-Host ""

# === Заголовки для GitHub API ===
$headers = @{
    "Accept" = "application/vnd.github+json"
    "User-Agent" = "PandasDetector-BlacklistUpdater/1.0"
}
if ($Token) {
    $headers["Authorization"] = "Bearer $Token"
}

# === Функция: скачать и посчитать хеш ===
function Get-FileHashFromUrl {
    param(
        [string]$Url,
        [string]$FileName,
        [int]$MaxSizeMB
    )
    try {
        $outPath = Join-Path $tempDir $FileName
        Invoke-WebRequest -Uri $Url -OutFile $outPath -TimeoutSec 60 -UseBasicParsing

        $fi = Get-Item -LiteralPath $outPath
        $sizeMB = [math]::Round($fi.Length / 1MB, 2)
        if ($fi.Length -gt ($MaxSizeMB * 1MB)) {
            Write-Host "    Пропуск (размер $sizeMB МБ > $MaxSizeMB МБ): $FileName" -ForegroundColor DarkYellow
            Remove-Item -LiteralPath $outPath -Force
            return $null
        }

        $hash = (Get-FileHash -LiteralPath $outPath -Algorithm SHA256).Hash
        Remove-Item -LiteralPath $outPath -Force
        return @{
            Hash = $hash
            SizeMB = $sizeMB
        }
    } catch {
        Write-Host "    Ошибка скачивания: $($_.Exception.Message)" -ForegroundColor Red
        return $null
    }
}

# === Основной цикл ===
$added = 0
$skipped = 0
$failed = 0
$repoIndex = 0
$totalRepos = $reposConfig.repos.Count

foreach ($repoInfo in $reposConfig.repos) {
    $repoIndex++
    $owner = $repoInfo.owner
    $repo = $repoInfo.repo
    $fullName = "$owner/$repo"

    Write-Host "[$repoIndex/$totalRepos] $fullName" -ForegroundColor Cyan

    $url = "https://api.github.com/repos/$owner/$repo/releases?per_page=$($repoInfo.max_releases)"
    try {
        $releases = Invoke-RestMethod -Uri $url -Headers $headers -Method Get -TimeoutSec 30
    } catch {
        Write-Host "  Ошибка запроса: $($_.Exception.Message)" -ForegroundColor Red
        $failed++
        continue
    }

    if (-not $releases -or $releases.Count -eq 0) {
        Write-Host "  Релизы не найдены" -ForegroundColor DarkYellow
        continue
    }

    Write-Host "  Релизов: $($releases.Count)" -ForegroundColor Gray

    foreach ($release in $releases) {
        foreach ($asset in $release.assets) {
            $match = $false
            foreach ($pattern in $repoInfo.file_patterns) {
                if ($asset.name -match $pattern) {
                    $match = $true
                    break
                }
            }
            if (-not $match) { continue }

            $result = Get-FileHashFromUrl -Url $asset.browser_download_url -FileName $asset.name -MaxSizeMB $MaxFileSizeMB
            if (-not $result) {
                $failed++
                continue
            }

            $hash = $result.Hash
            $displayName = "$repo $($release.tag_name)"

            if ($blacklist.ContainsKey($hash)) {
                Write-Host "    [=] $($asset.name) - уже в базе ($($blacklist[$hash].name))" -ForegroundColor DarkGray
                $skipped++
                continue
            }

            Write-Host "    [+] $($asset.name) - $hash ($($result.SizeMB) МБ)" -ForegroundColor Green
            $blacklist[$hash] = @{
                name = $displayName
                source = "https://github.com/$fullName/releases/tag/$($release.tag_name)"
                risk = $repoInfo.risk
                category = $repoInfo.category
                added = (Get-Date -Format 'yyyy-MM-dd')
            }
            $added++
        }
    }

    Start-Sleep -Milliseconds 500
}

# === Сохранение ===
Write-Host ""
Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host "  РЕЗУЛЬТАТЫ" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host "  Добавлено:    $added" -ForegroundColor Green
Write-Host "  Пропущено:    $skipped" -ForegroundColor Gray
Write-Host "  Ошибок:       $failed" -ForegroundColor Red
Write-Host "  Всего в базе: $($blacklist.Count)" -ForegroundColor White
Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray

if ($DryRun) {
    Write-Host ""
    Write-Host "Dry-run режим. Изменения не сохранены." -ForegroundColor Yellow
} else {
    $output = @{
        version = (Get-Date -Format 'yyyy-MM-dd')
        updated = (Get-Date).ToString('o')
        count = $blacklist.Count
        hashes = $blacklist
    }
    $output | ConvertTo-Json -Depth 10 | Out-File $BlacklistFile -Encoding UTF8
    Write-Host ""
    Write-Host "База сохранена: $BlacklistFile" -ForegroundColor Green
}

# === Очистка ===
Remove-Item -LiteralPath $tempDir -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "Готово." -ForegroundColor Cyan