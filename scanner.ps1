$CheatPatterns = @(
    'Vape','VapeLite','LiquidBounce','FDPClient','Rise','Tenacity','Novoline','Astolfo','ZeroDay','Exhibition',
    'DortWare','MoonX','Juul','Jigsaw','Wurst','Impact','Sigma','Sigma4','Sigma5','Phobos','Ares',
    'KAMI','KAMI_Blue','Seppuku','RusherHack','Future','Pyro','Konas','WintWare','Nursultan','Norules',
    'Akrien','DeadCode','Eternity','WEXSIDE','Rich','BleachHack','Matix','R3D','Celestial','Destroy',
    'ArchWare','NightMare','BoberWare','FLauncher','ExLoader','Celestia','Expensive','Meteor','MeteorClient',
    'Dreampool','Cortex','AimBot','FreeCam','MobHealthBar','Tweakeroo','PlayerHealthIndicators',
    'AutoAttack','InventoryTotem','Elytra','RockStarClient','MoonHack','FlugerClient','Vagaline','HardyClient',
    'ExtremeHack','Topkascroller','Arbuz','Avalon','Leontap','ZEXIS','RastyClient','Rasty','Winner',
    'DreampollClient','fragsx','KeazClient','keaz','EpfiriumClient','Epfirium','NOVA','NOVAClient','emfrium',
    'ForgeHax','Huzuni','flux','NEVERHOOK','Fecurity','PhasmaClient','Phasma','Vendex','RYNWAREClient',
    'Runware','BuzeClient','Buze','plintusvisual','PulseVisual','Deltaclient','Deltaloader',
    'Altening','Authme','AxeClient','Azurite','BaconClient','Banzem','Battlehack','Blacksploit','BlueGhost',
    'BoxHack','BranUtility','BruhMoment','BurnDown','BypassClient','Camelot','Centrum','Chattrix',
    'CheatBreaker','ClickAssistant','CortexClient','CMDCrystal','ColdClient','CombatMC','CommandBlock',
    'Cosmos','Crimson','CryptoClient','Crystal','DarkLight','Destiny','Devastation','Divinity','Dolphin',
    'DripESP','DuckWare','EarthHack','Eclipse','Ephesus','Fedora','Fencing','Ferox','FiftyTwo','Flubba',
    'Fracture','Gamma','GlowClient','Gonk','Griefing','HackedClient','HawkEye','HeavenSense','Hydrogen',
    'IceClient','Infinity','Insanity','Invictus','Jartex','Jello','Kauri','Keks','Kokuri','Komorebi',
    'Kronos','Lime','Lydia','Medusa','Midnight','MinecraftTools','Monsoon','Mythic','TrohiilClient',
    'NeverLose','Odin','Pride','ProxyClient','Quest','Redesky','Reflex','Rodia','Rubix','SaltClient',
    'ShadowWare','Skidder','Spartan','Stark','StatusHax','Synapse','ThunderHack','TownCraft','Trident',
    'Unlegit','Unnamed','Vero','Void','VuX','Vulcan','Wawa','YAWN','Yijin','Yolocaust','Yrela',
    'xray','scaffold','killaurea','nuker','vclip','hoyer','phase','Baritone','Inertia','GishCode',
    'Doomsday','Zamorozka','hotbar','stealer','Scroller','armorhotswap','locator','rcon',
    'MeteorAddon','MeteorReject','Meteorist','MeteorPlus','Meteorite',
    'Lunar','Badlion','Feather','Labymod','5zig','CosmicClient','Hyperium','PvPLounge',
    'Crystal','Dragon','Eternal','Galaxy','Genesis','Hades','Horizon','Imperial','Legacy',
    'Leviathan','Nebula','Omega','Pandora','Paradox','Phantom','Quantum','Ragnarok','Titan',
    'triggerbot','wallhack','tracers','norecoil','nospread','rapidfire',
    'bunnyhop','strafe','spinbot','killaura','reach','velocity','antikb','antiknockback',
    'autopot','autosoup','autogapple','autoeat','autorespawn','autologin','autofish','autofarm',
    'autowalk','autosneak','autojump','autosprint','autosword','autototem','crystalaura',
    'surround','selfdestruct','autodisconnect','autoreconnect','fakename','spoof','spoofer',
    'keylogger','screenlogger','backdoor','rootkit','ransomware','trojan','worm',
    'inject','loader','bypass','autoclicker','macro','exploit','crack','unban','stealth','undetect'
)

$SystemServicesToCheck = @(
    'Appinfo','Sysmain','Pcasvc','DPS'
)

$allowedExtensions = @(
    '.jar', '.exe', '.dll', '.bat', '.cmd', '.ps1', '.vbs', '.msi', 
    '.zip', '.rar', '.7z', '.json', '.cfg', '.txt', '.log', '.dat', 
    '.properties', '.yml', '.yaml', '.xml', '.class', '.java', '.py', '.js', '.lua'
)

$whitelistPatterns = @(
    'fabric', 'fabricloader', 'fabric-api', 'fabric.mod', 'fabricmod', 
    'quilt', 'quiltloader', 'forge', 'neoforge', 'optifine', 
    'sodium', 'lithium', 'phosphor', 'iris', 'sildurs',
    'complementary', 'bsl', 'seus', 'continuum', 'realistico', 
    'modernarch', 'faithful', 'vanillatweaks', 'minimap', 'journeymap', 
    'xaeros', 'jei', 'rei', 'emi', 'wthit', 'jade', 'hwyla', 
    'theoneprobe', 'top', 'ftb', 'curseforge', 'modrinth', 'multimc',
    'prism', 'polyMC', 'gdlauncher', 'atlauncher', 'technic', 
    'voidlauncher', 'tlauncher', 'java', 'javaw', 'javaws', 
    'launcher', 'mojang', 'microsoft', 'windows', 'system32', 'syswow64', 
    'program files', 'programdata', 'appdata', 'users',
    'intel', 'nvidia', 'amd', 'realtek', 'steam', 'discord', 'yandex',
    'service', 'services', 'svc', 'sensor', 'sensors', 'display', 'audio',
    'network', 'net', 'wifi', 'bluetooth', 'printer', 'print', 'scan',
    'camera', 'webcam', 'microphone', 'speaker', 'battery',
    'update', 'updater', 'install', 'installer', 'uninstall', 'setup',
    'driver', 'drivers', 'device', 'devices', 'hardware', 'software',
    'system', 'windows', 'microsoft', 'office', 'cloud', 'backup',
    'restore', 'recovery', 'security', 'defender', 'firewall', 'antivirus',
    'protection', 'monitor', 'monitoring', 'diagnostic', 'diagnostics',
    'telemetry', 'compatibility', 'assistant', 'helper', 'manager',
    'management', 'broker', 'provider', 'host', 'runtime', 'framework',
    'platform', 'controller', 'control', 'configuration', 'config',
    'registry', 'profile', 'profiles', 'account', 'accounts', 'credential',
    'credentials', 'authentication', 'authorization', 'encryption',
    'certificate', 'certificates', 'license', 'licensing',
    'activation', 'validation', 'verification', 'sync', 'synchronization',
    'sharing', 'share', 'remote', 'desktop', 'terminal', 'session',
    'sessions', 'login', 'logon', 'logoff', 'password', 'passwords',
    'token', 'tokens', 'key', 'keys', 'vault', 'wallet', 'payment',
    'payments', 'billing', 'invoice', 'invoices', 'tax', 'taxes',
    'bank', 'banking', 'finance', 'financial', 'money', 'currency',
    'exchange', 'market', 'trading', 'invest', 'investment', 'stock',
    'stocks', 'bond', 'bonds', 'fund', 'funds', 'portfolio', 'asset',
    'assets', 'liability', 'liabilities', 'equity', 'capital', 'revenue',
    'expense', 'expenses', 'profit', 'loss', 'income', 'salary', 'wage',
    'wages', 'payroll', 'deduction', 'deductions', 'benefit',
    'benefits', 'insurance', 'health', 'medical', 'dental', 'vision',
    'prescription', 'pharmacy', 'doctor', 'nurse', 'hospital', 'clinic',
    'patient', 'patients', 'appointment', 'appointments', 'schedule',
    'scheduling', 'calendar', 'reminder', 'reminders', 'notification',
    'notifications', 'alert', 'alerts', 'warning', 'warnings',
    'log', 'logs', 'logging', 'audit', 'auditing', 'trace',
    'tracing', 'debug', 'debugging', 'test', 'testing', 'qa', 'quality',
    'assurance', 'compliance', 'regulation', 'regulations', 'policy',
    'policies', 'procedure', 'procedures', 'standard', 'standards',
    'guideline', 'guidelines', 'rule', 'rules', 'law', 'laws', 'legal',
    'contract', 'contracts', 'agreement', 'agreements',
    'document', 'documents', 'file', 'files', 'folder', 'folders',
    'directory', 'directories', 'path', 'paths', 'location', 'locations',
    'address', 'addresses', 'phone', 'phones', 'email', 'emails',
    'message', 'messages', 'chat', 'chats', 'communication',
    'communications', 'contact', 'contacts', 'person', 'people',
    'user', 'users', 'group', 'groups', 'role', 'roles', 'permission',
    'permissions', 'access', 'rights', 'privilege', 'privileges',
    'admin', 'administrator', 'administrators', 'root', 'superuser',
    'owner', 'ownership', 'member', 'members', 'membership',
    'subscription', 'subscriptions', 'plan', 'plans', 'package',
    'packages', 'product', 'products', 'item', 'items', 'inventory',
    'warehouse', 'shipping', 'delivery', 'order', 'orders', 'cart',
    'checkout', 'purchase', 'purchases', 'sale', 'sales', 'transaction',
    'transactions', 'receipt', 'receipts', 'refund', 'refunds',
    'return', 'returns', 'warranty', 'support', 'customer', 'customers',
    'client', 'clients', 'vendor', 'vendors', 'supplier', 'suppliers',
    'partner', 'partners', 'employee', 'employees', 'staff', 'team',
    'department', 'departments', 'division', 'divisions', 'branch',
    'branches', 'office', 'offices', 'building', 'buildings',
    'floor', 'floors', 'room', 'rooms', 'desk', 'desks', 'chair',
    'chairs', 'computer', 'computers', 'laptop', 'laptops',
    'desktop', 'desktops', 'server', 'servers', 'router', 'routers',
    'switch', 'switches', 'modem', 'modems', 'scanner', 'scanners',
    'keyboard', 'keyboards', 'mouse', 'mice', 'screen', 'screens',
    'projector', 'projectors', 'hyper', 'vm', 'virtual', 'virtualization',
    'power', 'shell', 'explorer', 'sihost', 'taskhost', 'conhost',
    'dwm', 'csrss', 'smss', 'wininit', 'winlogon', 'lsass',
    'fontdrvhost', 'svchost', 'dllhost', 'wmiprvse'
)

$allPatterns = @()
$allPatterns += $CheatPatterns

function Is-Whitelisted {
    param([string]$InputString)
    
    if (-not $InputString) { 
        return $false 
    }
    
    $lowerInput = $InputString.ToLower()
    
    # НЕ проверяем whitelist для файлов с расширениями .jar и .exe
    # Эти файлы всегда проверяем на читы
    if ($lowerInput -match '\.jar$|\.jar\s|\.exe$|\.exe\s|\.dll$|\.dll\s') {
        return $false
    }
    
    foreach ($pattern in $whitelistPatterns) {
        if ($lowerInput -match [regex]::Escape($pattern)) {
            return $true
        }
    }
    
    return $false
}

function Get-RiskLevel {
    param([string]$InputString)
    
    if (-not $InputString) { 
        return @{ 
            Risk = 'Unknown'
            Reason = ''
            Probability = 0 
        } 
    }
    
    $lowerInput = $InputString.ToLower()
    $foundPatterns = @()
    $probability = 0
    
    if (Is-Whitelisted -InputString $lowerInput) {
        return @{ 
            Risk = 'Unknown'
            Reason = ''
            Probability = 0 
        }
    }
    
    foreach ($pattern in $CheatPatterns) {
        if ($lowerInput -match [regex]::Escape($pattern.ToLower())) {
            $foundPatterns += $pattern
            $probability += 15
        }
    }
    
    if ($foundPatterns.Count -ge 2) {
        $probability = [math]::Min(95, $probability + 50)
    }
    elseif ($foundPatterns.Count -eq 1) {
        $probability = [math]::Min(95, $probability + 65)
    }
    
    if ($foundPatterns.Count -gt 0) {
        return @{ 
            Risk = 'Critical'
            Reason = "Совпадение с $($foundPatterns -join ', ')"
            Probability = $probability 
        }
    }
    
    return @{ 
        Risk = 'Unknown'
        Reason = ''
        Probability = 0 
    }
}

function Format-LastWriteTime {
    param($LastWriteTime)
    
    if ($null -eq $LastWriteTime) { 
        return "Неизвестно" 
    }
    
    $timeDiff = (Get-Date) - $LastWriteTime
    
    if ($timeDiff.TotalMinutes -lt 1) { 
        return "только что" 
    }
    elseif ($timeDiff.TotalHours -lt 1) { 
        return "$([math]::Floor($timeDiff.TotalMinutes)) мин. назад" 
    }
    elseif ($timeDiff.TotalDays -lt 1) { 
        return "$([math]::Floor($timeDiff.TotalHours)) ч. $($timeDiff.Minutes) мин. назад" 
    }
    elseif ($timeDiff.TotalDays -lt 30) { 
        return "$([math]::Floor($timeDiff.TotalDays)) дн. $([math]::Floor($timeDiff.TotalHours % 24)) ч. назад" 
    }
    else { 
        return "$([math]::Floor($timeDiff.TotalDays / 30)) мес. $([math]::Floor($timeDiff.TotalDays % 30)) дн. назад" 
    }
}

function Show-Progress {
    param($Percent, $Message)
    
    $barLength = 40
    $filled = [math]::Round($Percent / 100 * $barLength)
    $empty = $barLength - $filled
    $bar = "[" + ("█" * $filled) + ("░" * $empty) + "]"
    
    Write-Host "`r$bar $Percent% $Message" -NoNewline -ForegroundColor Cyan
    
    if ($Percent -eq 100) { 
        Write-Host "" 
    }
}

function Test-Admin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Get-DaysSinceLastWrite {
    param($LastWriteTime)
    
    if ($null -eq $LastWriteTime) { 
        return 999 
    }
    
    $timeDiff = (Get-Date) - $LastWriteTime
    return [math]::Floor($timeDiff.TotalDays)
}

$results = @()
$htmlResults = @()
$totalSteps = 10
$currentStep = 0
$isAdmin = Test-Admin

Write-Host "`n════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host "  🐼  Minecraft Cheat Detector by 976hk  🐼" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════════`n" -ForegroundColor DarkGray

if (-not $isAdmin) {
    Write-Host "⚠️  Внимание: Скрипт запущен без прав администратора." -ForegroundColor Yellow
    Write-Host "   Некоторые проверки (службы, реестр HKLM) могут быть неполными.`n" -ForegroundColor Yellow
}

$currentStep++
Show-Progress -Percent ([math]::Round($currentStep / $totalSteps * 100)) -Message "Сканирование процессов..."

Get-Process -ErrorAction SilentlyContinue | ForEach-Object {
    $procName = $_.Name
    $procPath = $null
    
    try {
        $procPath = $_.Path
    } catch {
        $procPath = $null
    }
    
    $detection = Get-RiskLevel -InputString "$procName $procPath"
    
    if ($detection.Risk -ne 'Unknown') {
        $procInfo = $null
        
        if ($procPath) {
            $procInfo = Get-Item -Path $procPath -ErrorAction SilentlyContinue
        }
        
        $result = [PSCustomObject]@{
            'Тип' = 'Процесс'
            'Имя' = $procName
            'Путь' = if ($procPath) { $procPath } else { 'N/A' }
            'PID' = $_.Id
            'Детали' = $detection.Reason
            'Последнее изменение' = if ($procInfo) { Format-LastWriteTime $procInfo.LastWriteTime } else { 'Неизвестно' }
            'Статус' = 'Работает'
            'Риск' = $detection.Risk
            'Вероятность' = $detection.Probability
            'Дней с изменения' = if ($procInfo) { Get-DaysSinceLastWrite $procInfo.LastWriteTime } else { 999 }
            'Автор' = '976hk'
        }
        
        $results += $result
        
        if ($procPath -and $procPath -match '\.exe$|\.jar$|\.dll$') {
            $htmlResults += $result
        }
    }
}

$currentStep++
Show-Progress -Percent ([math]::Round($currentStep / $totalSteps * 100)) -Message "Сканирование файлов..."

$scanPaths = @(
    "$env:UserProfile\Downloads",
    "$env:UserProfile\Desktop",
    "$env:UserProfile\Documents",
    "$env:Temp",
    "$env:AppData\Local\Temp",
    "$env:AppData\Roaming"
)

foreach ($path in $scanPaths) {
    if (Test-Path $path) {
        Get-ChildItem -Path $path -File -Recurse -Depth 3 -ErrorAction SilentlyContinue | Where-Object {
            $_.Extension.ToLower() -in $allowedExtensions
        } | ForEach-Object {
            $detection = Get-RiskLevel -InputString "$($_.Name) $($_.FullName)"
            
            if ($detection.Risk -ne 'Unknown') {
                $result = [PSCustomObject]@{
                    'Тип' = 'Файл'
                    'Имя' = $_.Name
                    'Путь' = $_.FullName
                    'PID' = 'N/A'
                    'Детали' = $detection.Reason
                    'Последнее изменение' = Format-LastWriteTime $_.LastWriteTime
                    'Статус' = 'Найден'
                    'Риск' = $detection.Risk
                    'Вероятность' = $detection.Probability
                    'Дней с изменения' = Get-DaysSinceLastWrite $_.LastWriteTime
                    'Автор' = '976hk'
                }
                
                $results += $result
                
                if ($_.Extension.ToLower() -in @('.jar', '.exe', '.dll')) {
                    $htmlResults += $result
                }
            }
        }
    }
}

$currentStep++
Show-Progress -Percent ([math]::Round($currentStep / $totalSteps * 100)) -Message "Сканирование Minecraft..."

$minecraftPaths = @(
    "$env:AppData\.minecraft\mods",
    "$env:AppData\.minecraft\versions",
    "$env:AppData\.minecraft\config",
    "$env:AppData\.minecraft\libraries",
    "$env:AppData\.minecraft\resourcepacks",
    "$env:AppData\.minecraft\shaderpacks",
    "$env:AppData\.minecraft\saves",
    "$env:AppData\.minecraft\logs",
    "$env:AppData\.minecraft\crash-reports"
)

foreach ($mcPath in $minecraftPaths) {
    if (Test-Path $mcPath) {
        Get-ChildItem -Path $mcPath -Recurse -Depth 7 -ErrorAction SilentlyContinue | Where-Object {
            if ($_.PSIsContainer) { 
                return $true 
            }
            return $_.Extension.ToLower() -in $allowedExtensions
        } | ForEach-Object {
            $detection = Get-RiskLevel -InputString "$($_.Name) $($_.FullName)"
            
            if ($detection.Risk -ne 'Unknown') {
                $result = [PSCustomObject]@{
                    'Тип' = 'Minecraft'
                    'Имя' = $_.Name
                    'Путь' = $_.FullName
                    'PID' = 'N/A'
                    'Детали' = $detection.Reason
                    'Последнее изменение' = Format-LastWriteTime $_.LastWriteTime
                    'Статус' = 'Найден'
                    'Риск' = $detection.Risk
                    'Вероятность' = $detection.Probability
                    'Дней с изменения' = Get-DaysSinceLastWrite $_.LastWriteTime
                    'Автор' = '976hk'
                }
                
                $results += $result
                
                if ($_.Extension.ToLower() -in @('.jar', '.exe', '.cfg', '.json', '.txt')) {
                    $htmlResults += $result
                }
            }
        }
    }
}

$currentStep++
Show-Progress -Percent ([math]::Round($currentStep / $totalSteps * 100)) -Message "Сканирование DLL..."

Get-ChildItem -Path "$env:Temp", "$env:AppData\Local\Temp" -File -Filter "*.dll" -Recurse -Depth 3 -ErrorAction SilentlyContinue | ForEach-Object {
    $detection = Get-RiskLevel -InputString "$($_.Name) $($_.FullName)"
    
    if ($detection.Risk -ne 'Unknown') {
        $result = [PSCustomObject]@{
            'Тип' = 'DLL Инжект'
            'Имя' = $_.Name
            'Путь' = $_.FullName
            'PID' = 'N/A'
            'Детали' = $detection.Reason
            'Последнее изменение' = Format-LastWriteTime $_.LastWriteTime
            'Статус' = 'Найден'
            'Риск' = $detection.Risk
            'Вероятность' = $detection.Probability
            'Дней с изменения' = Get-DaysSinceLastWrite $_.LastWriteTime
            'Автор' = '976hk'
        }
        
        $results += $result
        $htmlResults += $result
    }
}

$currentStep++
Show-Progress -Percent ([math]::Round($currentStep / $totalSteps * 100)) -Message "Сканирование реестра..."

$registryPaths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders",
    "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
)

foreach ($regPath in $registryPaths) {
    if (Test-Path $regPath) {
        $regItems = Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue
        
        if ($regItems) {
            $regItems.PSObject.Properties | Where-Object {
                $_.Name -notmatch '^PS' -and $_.Value
            } | ForEach-Object {
                $detection = Get-RiskLevel -InputString "$($_.Name) $($_.Value)"
                
                if ($detection.Risk -ne 'Unknown') {
                    $result = [PSCustomObject]@{
                        'Тип' = 'Реестр'
                        'Имя' = $_.Name
                        'Путь' = $_.Value
                        'PID' = 'N/A'
                        'Детали' = $detection.Reason
                        'Последнее изменение' = 'N/A'
                        'Статус' = 'В автозагрузке'
                        'Риск' = $detection.Risk
                        'Вероятность' = $detection.Probability
                        'Дней с изменения' = 999
                        'Автор' = '976hk'
                    }
                    
                    $results += $result
                }
            }
        }
    }
}

$currentStep++
Show-Progress -Percent ([math]::Round($currentStep / $totalSteps * 100)) -Message "Сканирование служб..."

Get-Service -ErrorAction SilentlyContinue | ForEach-Object {
    $serviceName = $_.Name
    $displayName = $_.DisplayName
    
    $detection = Get-RiskLevel -InputString "$displayName $serviceName"
    
    if ($serviceName -in $SystemServicesToCheck) {
        $detection = @{ 
            Risk = 'System'
            Reason = "Системная служба Windows: $serviceName"
            Probability = 0 
        }
    }
    
    if ($detection.Risk -ne 'Unknown') {
        $servicePath = $null
        
        try {
            $serviceInfo = Get-CimInstance Win32_Service -Filter "Name='$serviceName'" -ErrorAction SilentlyContinue
            if ($serviceInfo) {
                $servicePath = $serviceInfo.PathName
            }
        } catch {
            $servicePath = $null
        }
        
        $result = [PSCustomObject]@{
            'Тип' = 'Служба'
            'Имя' = $serviceName
            'Путь' = $displayName
            'PID' = 'N/A'
            'Детали' = $detection.Reason
            'Последнее изменение' = 'N/A'
            'Статус' = $_.Status
            'Риск' = $detection.Risk
            'Вероятность' = $detection.Probability
            'Дней с изменения' = 999
            'Автор' = '976hk'
        }
        
        $results += $result
    }
}

$currentStep++
Show-Progress -Percent ([math]::Round($currentStep / $totalSteps * 100)) -Message "Сканирование сети..."

Get-NetTCPConnection -ErrorAction SilentlyContinue | Where-Object {
    $_.State -eq "Established" -and $_.OwningProcess -ne 0
} | ForEach-Object {
    $procName = $null
    $procPath = $null
    
    try {
        $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
        if ($proc) {
            $procName = $proc.Name
            try {
                $procPath = $proc.Path
            } catch {
                $procPath = $null
            }
        }
    } catch {
        $procName = $null
    }
    
    if ($procName) {
        $detection = Get-RiskLevel -InputString "$procName $procPath"
        
        if ($detection.Risk -ne 'Unknown') {
            $result = [PSCustomObject]@{
                'Тип' = 'Сеть'
                'Имя' = $procName
                'Путь' = "$($_.LocalAddress):$($_.LocalPort) -> $($_.RemoteAddress):$($_.RemotePort)"
                'PID' = $_.OwningProcess
                'Детали' = $detection.Reason
                'Последнее изменение' = 'N/A'
                'Статус' = 'Установлено'
                'Риск' = $detection.Risk
                'Вероятность' = $detection.Probability
                'Дней с изменения' = 999
                'Автор' = '976hk'
            }
            
            $results += $result
        }
    }
}

$currentStep++
Show-Progress -Percent ([math]::Round($currentStep / $totalSteps * 100)) -Message "Сканирование задач..."

Get-ScheduledTask -ErrorAction SilentlyContinue | ForEach-Object {
    $detection = Get-RiskLevel -InputString "$($_.TaskName) $($_.TaskPath)"
    
    if ($detection.Risk -ne 'Unknown') {
        $result = [PSCustomObject]@{
            'Тип' = 'Задача'
            'Имя' = $_.TaskName
            'Путь' = $_.TaskPath
            'PID' = 'N/A'
            'Детали' = $detection.Reason
            'Последнее изменение' = 'N/A'
            'Статус' = $_.State
            'Риск' = $detection.Risk
            'Вероятность' = $detection.Probability
            'Дней с изменения' = 999
            'Автор' = '976hk'
        }
        
        $results += $result
    }
}

$currentStep++
Show-Progress -Percent ([math]::Round($currentStep / $totalSteps * 100)) -Message "Сканирование хостов..."

$hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"
if (Test-Path $hostsPath) {
    $hostsContent = Get-Content $hostsPath -ErrorAction SilentlyContinue
    $suspiciousHosts = $hostsContent | Where-Object {
        $_ -match $patternRegex -and $_ -notmatch '^\s*#'
    }
    
    if ($suspiciousHosts) {
        foreach ($line in $suspiciousHosts) {
            $detection = Get-RiskLevel -InputString $line
            
            $result = [PSCustomObject]@{
                'Тип' = 'Hosts'
                'Имя' = 'hosts'
                'Путь' = $hostsPath
                'PID' = 'N/A'
                'Детали' = $detection.Reason
                'Последнее изменение' = Format-LastWriteTime (Get-Item $hostsPath).LastWriteTime
                'Статус' = 'Изменен'
                'Риск' = $detection.Risk
                'Вероятность' = $detection.Probability
                'Дней с изменения' = Get-DaysSinceLastWrite (Get-Item $hostsPath).LastWriteTime
                'Автор' = '976hk'
            }
            
            $results += $result
        }
    }
}

Show-Progress -Percent 100 -Message "Сканирование завершено!"
Write-Host ""

$criticalResults = $htmlResults | Where-Object { 
    $_.Риск -eq 'Critical' -and $_.'Дней с изменения' -le 14 
} | Sort-Object -Property 'Дней с изменения', 'Вероятность' -Descending

$highResults = $htmlResults | Where-Object { 
    $_.Риск -eq 'High' -and $_.'Дней с изменения' -le 14 
} | Sort-Object -Property 'Дней с изменения', 'Вероятность' -Descending

$suspiciousResults = $htmlResults | Where-Object { 
    $_.Риск -eq 'Suspicious' -and $_.'Дней с изменения' -le 14 
} | Sort-Object -Property 'Дней с изменения', 'Вероятность' -Descending

$oldResults = $htmlResults | Where-Object { 
    $_.'Дней с изменения' -gt 14 -and $_.Риск -ne 'System' 
} | Sort-Object -Property 'Дней с изменения' -Descending

$systemResults = $results | Where-Object { 
    $_.Риск -eq 'System' 
}

Write-Host "=== Результаты сканирования ===" -ForegroundColor Cyan
Write-Host "Всего найдено (CSV): $($results.Count)" -ForegroundColor White
Write-Host "В HTML отчёте: $($htmlResults.Count)" -ForegroundColor White
Write-Host "Свежие критические (≤14 дней): $($criticalResults.Count)" -ForegroundColor Red
Write-Host "Свежие высокого риска (≤14 дней): $($highResults.Count)" -ForegroundColor DarkRed
Write-Host "Свежие подозрительные (≤14 дней): $($suspiciousResults.Count)" -ForegroundColor Yellow
Write-Host "Старые (более 14 дней): $($oldResults.Count)" -ForegroundColor Gray
Write-Host "Системных служб: $($systemResults.Count)" -ForegroundColor DarkGray
Write-Host ""

if ($results.Count -gt 0) {
    Write-Host "`nВведите путь для сохранения (Enter для рабочего стола):" -ForegroundColor Yellow
    $OutputPath = Read-Host
    
    if ([string]::IsNullOrWhiteSpace($OutputPath)) {
        $OutputPath = [Environment]::GetFolderPath("Desktop")
    }
    
    $OutputPath = $OutputPath.Trim('"').Trim("'")
    
    if (-not (Test-Path -Path $OutputPath)) {
        try { 
            New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null 
        }
        catch { 
            $OutputPath = [Environment]::GetFolderPath("Desktop")
        }
    }
    
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $csvFile = Join-Path -Path $OutputPath -ChildPath "cheat_scan_$timestamp.csv"
    $htmlFile = Join-Path -Path $OutputPath -ChildPath "cheat_scan_$timestamp.html"
    
    try {
        $results | Export-Csv -Path $csvFile -NoTypeInformation -Delimiter ";" -Force -Encoding UTF8
        Write-Host "✅ CSV: $csvFile" -ForegroundColor Green
        
        $html = @"
<html>
<head>
<style>
body {
    background: #1a1a1a;
    color: #e0e0e0;
    font-family: 'Segoe UI', Arial, sans-serif;
    margin: 20px;
}
h1 {
    color: #00ff00;
    border-bottom: 2px solid #00ff00;
    padding-bottom: 10px;
}
h2 {
    margin-top: 30px;
    padding: 10px;
    border-radius: 5px;
}
.critical h2 {
    background: #330000;
    color: #ff0000;
    border-left: 4px solid #ff0000;
}
.high h2 {
    background: #331100;
    color: #ff6600;
    border-left: 4px solid #ff6600;
}
.suspicious h2 {
    background: #333300;
    color: #ffff00;
    border-left: 4px solid #ffff00;
}
.old h2 {
    background: #222222;
    color: #888888;
    border-left: 4px solid #888888;
}
.system h2 {
    background: #1a1a1a;
    color: #666666;
    border-left: 4px solid #666666;
}
.item {
    background: #2d2d2d;
    border-left: 4px solid #666;
    padding: 15px;
    margin: 10px 0;
    border-radius: 3px;
}
.item h3 {
    margin: 0 0 10px 0;
    color: #ffffff;
}
.path {
    color: #00ff00;
    font-family: 'Courier New', monospace;
    word-break: break-all;
}
.details {
    color: #cccccc;
    margin: 5px 0;
}
.reason {
    color: #ff9900;
    margin: 5px 0;
    font-style: italic;
}
.probability-high {
    color: #ff0000;
    font-weight: bold;
    font-size: 1.2em;
}
.probability-medium {
    color: #ff6600;
    font-weight: bold;
}
.probability-low {
    color: #ffff00;
    font-weight: bold;
}
.probability-none {
    color: #888888;
    font-weight: bold;
}
.summary {
    background: #2d2d2d;
    padding: 15px;
    border-radius: 5px;
    margin: 20px 0;
}
.summary span {
    margin-right: 20px;
    font-weight: bold;
}
.service-summary {
    background: #2d2d2d;
    padding: 15px;
    border-radius: 5px;
    margin: 10px 0;
    display: flex;
    gap: 30px;
}
.service-status {
    display: flex;
    align-items: center;
    gap: 10px;
}
.status-dot {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    display: inline-block;
}
.status-dot.running {
    background: #00ff00;
    box-shadow: 0 0 10px #00ff00;
}
.status-dot.stopped {
    background: #ff0000;
    box-shadow: 0 0 10px #ff0000;
}
.status-label {
    color: #ffffff;
    font-weight: bold;
    font-size: 1.1em;
}
.service-running {
    border-left: 4px solid #00ff00;
    background: #1a2a1a;
}
.service-stopped {
    border-left: 4px solid #ff0000;
    background: #2a1a1a;
}
</style>
</head>
<body>
<h1>🐼 Minecraft Cheat Detector Report</h1>
<p>Автор: 976hk | Дата сканирования: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</p>
<div class='summary'>
    <span style='color: #ff0000;'>Свежие критические: $($criticalResults.Count)</span>
    <span style='color: #ff6600;'>Свежие высокого риска: $($highResults.Count)</span>
    <span style='color: #ffff00;'>Свежие подозрительные: $($suspiciousResults.Count)</span>
    <span style='color: #888888;'>Старые: $($oldResults.Count)</span>
    <span style='color: #666666;'>Системные: $($systemResults.Count)</span>
    <span style='color: #ffffff;'>Всего: $($htmlResults.Count)</span>
</div>
"@
        
        if ($criticalResults.Count -gt 0) {
            $html += "<div class='critical'><h2>🔴 Свежие критические находки ($($criticalResults.Count))</h2>"
            
            foreach ($item in $criticalResults) {
                $probabilityClass = if ($item.Вероятность -ge 90) { 
                    'probability-high' 
                } elseif ($item.Вероятность -ge 70) { 
                    'probability-medium' 
                } else { 
                    'probability-low' 
                }
                
                $html += @"
<div class='item'>
<h3>$($item.Имя)</h3>
<p>Путь: <span class='path'>$($item.Путь)</span></p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Изменен: $($item.'Последнее изменение')</p>
<p class='details'>Статус: $($item.Статус)</p>
<p>Вероятность чит-клиента: <span class='$probabilityClass'>$($item.Вероятность)%</span></p>
</div>
"@
            }
            
            $html += "</div>"
        }
        
        if ($highResults.Count -gt 0) {
            $html += "<div class='high'><h2>🟠 Свежие находки высокого риска ($($highResults.Count))</h2>"
            
            foreach ($item in $highResults) {
                $probabilityClass = if ($item.Вероятность -ge 90) { 
                    'probability-high' 
                } elseif ($item.Вероятность -ge 70) { 
                    'probability-medium' 
                } else { 
                    'probability-low' 
                }
                
                $html += @"
<div class='item'>
<h3>$($item.Имя)</h3>
<p>Путь: <span class='path'>$($item.Путь)</span></p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Изменен: $($item.'Последнее изменение')</p>
<p class='details'>Статус: $($item.Статус)</p>
<p>Вероятность чит-клиента: <span class='$probabilityClass'>$($item.Вероятность)%</span></p>
</div>
"@
            }
            
            $html += "</div>"
        }
        
        if ($suspiciousResults.Count -gt 0) {
            $html += "<div class='suspicious'><h2>🟡 Свежие подозрительные находки ($($suspiciousResults.Count))</h2>"
            
            foreach ($item in $suspiciousResults) {
                $probabilityClass = if ($item.Вероятность -ge 90) { 
                    'probability-high' 
                } elseif ($item.Вероятность -ge 70) { 
                    'probability-medium' 
                } else { 
                    'probability-low' 
                }
                
                $html += @"
<div class='item'>
<h3>$($item.Имя)</h3>
<p>Путь: <span class='path'>$($item.Путь)</span></p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Изменен: $($item.'Последнее изменение')</p>
<p class='details'>Статус: $($item.Статус)</p>
<p>Вероятность чит-клиента: <span class='$probabilityClass'>$($item.Вероятность)%</span></p>
</div>
"@
            }
            
            $html += "</div>"
        }
        
        if ($oldResults.Count -gt 0) {
            $html += "<div class='old'><h2>⚪ Старые находки (более 14 дней) ($($oldResults.Count))</h2>"
            
            foreach ($item in $oldResults) {
                $probabilityClass = if ($item.Вероятность -ge 90) { 
                    'probability-high' 
                } elseif ($item.Вероятность -ge 70) { 
                    'probability-medium' 
                } elseif ($item.Вероятность -ge 40) { 
                    'probability-low' 
                } else { 
                    'probability-none' 
                }
                
                $html += @"
<div class='item'>
<h3>$($item.Имя)</h3>
<p>Путь: <span class='path'>$($item.Путь)</span></p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Изменен: $($item.'Последнее изменение')</p>
<p class='details'>Статус: $($item.Статус)</p>
<p>Вероятность чит-клиента: <span class='$probabilityClass'>$($item.Вероятность)%</span></p>
</div>
"@
            }
            
            $html += "</div>"
        }
        
        if ($systemResults.Count -gt 0) {
            $html += "<div class='system'><h2>⚙️ Системные службы ($($systemResults.Count))</h2>"
            
            $runningCount = ($systemResults | Where-Object { $_.Статус -eq 'Running' }).Count
            $stoppedCount = ($systemResults | Where-Object { $_.Статус -ne 'Running' }).Count
            
            $html += @"
<div class='service-summary'>
    <div class='service-status'>
        <span class='status-dot running'></span>
        <span class='status-label'>Запущено: $runningCount</span>
    </div>
    <div class='service-status'>
        <span class='status-dot stopped'></span>
        <span class='status-label'>Остановлено: $stoppedCount</span>
    </div>
</div>
"@
            
            foreach ($item in $systemResults) {
                $isRunning = $item.Статус -eq 'Running'
                $statusIcon = if ($isRunning) { '✅' } else { '❌' }
                $statusClass = if ($isRunning) { 'service-running' } else { 'service-stopped' }
                $statusText = switch ($item.Статус) {
                    'Running' { 'ЗАПУЩЕНА' }
                    'Stopped' { 'ОСТАНОВЛЕНА' }
                    'Paused' { 'ПРИОСТАНОВЛЕНА' }
                    default { $item.Статус }
                }
                
                $html += @"
<div class='item $statusClass'>
<h3>$statusIcon $($item.Имя)</h3>
<p>Путь: <span class='path'>$($item.Путь)</span></p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Состояние: <strong>$statusText</strong></p>
</div>
"@
            }
            
            $html += "</div>"
        }
        
        $html += "</body></html>"
        $html | Out-File -FilePath $htmlFile -Encoding UTF8
        Write-Host "✅ HTML: $htmlFile" -ForegroundColor Green
        
        if ($htmlFile -and (Test-Path $htmlFile)) {
            Start-Process $htmlFile
        }
        
    } catch {
        Write-Host "❌ Ошибка при сохранении: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
    Write-Host "✅ Читы и инжекты не обнаружены." -ForegroundColor Green
}

Write-Host "`n════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host "  Сканирование завершено" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
