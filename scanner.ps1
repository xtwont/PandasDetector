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

$CheatCodePatterns = @{
    'FreeCam' = @('freecam', 'free_cam', 'FreeCamera', 'spectator', 'noclip', 'no_clip')
    'XRay' = @('xray', 'x_ray', 'X-Ray', 'ore', 'ores', 'mineral', 'minerals')
    'AutoTotem' = @('totem', 'autototem', 'auto_totem', 'offhand', 'off_hand', 'inventorytotem')
    'KillAura' = @('killaura', 'kill_aura', 'KillAura', 'aura', 'aimbot', 'aim_bot')
    'Reach' = @('reach', 'range', 'distance', 'extend', 'hitbox', 'hit_box')
    'Velocity' = @('velocity', 'knockback', 'knock_back', 'antikb', 'anti_kb', 'antiknockback')
    'Scaffold' = @('scaffold', 'bridge', 'auto_bridge', 'autobridge', 'block_place', 'blockplace')
    'Nuker' = @('nuker', 'auto_break', 'autobreak', 'break_blocks', 'breakblocks', 'destroy_blocks')
    'ESP' = @('esp', 'wallhack', 'wall_hack', 'tracers', 'glow', 'highlight', 'outline')
    'Speed' = @('speed', 'bhop', 'bunnyhop', 'bunny_hop', 'strafe', 'sprint')
    'Fly' = @('fly', 'flight', 'hover', 'levitate', 'float')
    'NoFall' = @('nofall', 'no_fall', 'fall_damage', 'falldamage', 'antifall')
    'AutoClicker' = @('autoclicker', 'auto_clicker', 'autoclick', 'auto_click', 'cps')
    'ChestStealer' = @('stealer', 'cheststealer', 'chest_stealer', 'autosteal', 'auto_steal')
    'InventoryManager' = @('inventory', 'invmanager', 'inv_manager', 'autosort', 'auto_sort')
    'Spammer' = @('spammer', 'spam', 'chat_spam', 'chatspam', 'auto_message')
    'AntiAFK' = @('antiafk', 'anti_afk', 'afk', 'auto_afk', 'idle')
    'Blink' = @('blink', 'lag_switch', 'lagswitch', 'packet', 'delay')
    'Jesus' = @('jesus', 'water_walk', 'waterwalk', 'walk_water', 'walkwater')
    'Phase' = @('phase', 'clip', 'vclip', 'hclip', 'teleport')
}

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
    'voidlauncher', 'tlauncher', 'mojang', 'microsoft', 'windows', 'system32', 'syswow64', 
    'program files', 'programdata', 'appdata', 'users',
    'intel', 'nvidia', 'amd', 'realtek', 'steam', 'discord', 'yandex',
    'service', 'services', 'svc', 'sensor', 'sensors', 'display', 'audio',
    'network', 'net', 'wifi', 'bluetooth', 'printer', 'print', 'scan',
    'microphone', 'speaker', 'battery',
    'update', 'updater',
    'driver', 'drivers', 'device', 'devices', 'hardware', 'software',
    'microsoft', 'office', 'cloud', 'backup',
    'restore', 'recovery', 'security', 'defender', 'firewall', 'antivirus',
    'protection', 'monitor', 'monitoring', 'diagnostic', 'diagnostics',
    'telemetry', 'compatibility', 'assistant', 'helper', 'manager',
    'management', 'broker', 'provider', 'host', 'runtime', 'framework',
    'platform', 'controller', 'control', 'configuration',
    'registry', 'profile', 'profiles', 'account', 'accounts', 'credential',
    'credentials', 'authentication', 'authorization', 'encryption',
    'certificate', 'certificates', 'license', 'licensing',
    'activation', 'validation', 'verification', 'sync', 'synchronization',
    'sharing', 'share', 'remote', 'desktop', 'terminal', 'session',
    'sessions', 'login', 'logon', 'logoff', 'password', 'passwords',
    'key', 'keys', 'vault', 'wallet', 'payment',
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
    'packages', 'product', 'products', 'item', 'items',
    'warehouse', 'shipping', 'delivery', 'order', 'orders', 'cart',
    'checkout', 'purchase', 'purchases', 'sale', 'sales', 'transaction',
    'transactions', 'receipt', 'receipts', 'refund', 'refunds',
    'return', 'returns', 'warranty', 'support', 'customer', 'customers',
    'vendor', 'vendors', 'supplier', 'suppliers',
    'partner', 'partners', 'employee', 'employees', 'staff',
    'department', 'departments', 'division', 'divisions', 'branch',
    'branches', 'office', 'offices', 'building', 'buildings',
    'floor', 'floors', 'room', 'rooms', 'desk', 'desks', 'chair',
    'chairs', 'computer', 'computers', 'laptop', 'laptops',
    'desktop', 'desktops', 'server', 'servers', 'router', 'routers',
    'modem', 'modems', 'scanner', 'scanners',
    'keyboard', 'keyboards', 'mouse', 'mice', 'screen', 'screens',
    'projector', 'projectors', 'hyper', 'vm', 'virtual', 'virtualization',
    'power', 'shell', 'explorer', 'sihost', 'taskhost', 'conhost',
    'dwm', 'csrss', 'smss', 'wininit', 'winlogon', 'lsass',
    'fontdrvhost', 'svchost', 'wmiprvse',
    'customskinloader', 'skinloader', 'customskin'
)

$exactPatterns = @(
    '^crystal$', '^impact$', '^wurst$', '^meteor$', '^sigma$', '^sigma4$', '^sigma5$',
    '^phobos$', '^ares$', '^kami$', '^kami_blue$', '^seppuku$', '^rusherhack$',
    '^future$', '^pyro$', '^konas$', '^wintware$', '^nursultan$', '^norules$',
    '^akrien$', '^deadcode$', '^eternity$', '^wexside$', '^rich$', '^bleachhack$',
    '^matix$', '^r3d$', '^celestial$', '^destroy$', '^archware$', '^nightmare$',
    '^boberware$', '^flauncher$', '^exloader$', '^celestia$', '^expensive$',
    '^meteorclient$', '^dreampool$', '^cortex$', '^aimbot$', '^freecam$',
    '^mobhealthbar$', '^tweakeroo$', '^playerhealthindicators$', '^autoattack$',
    '^inventorytotem$', '^elytra$', '^rockstarclient$', '^moonhack$', '^flugerclient$',
    '^vagaline$', '^hardyclient$', '^extremehack$', '^topkascroller$', '^arbuz$',
    '^avalon$', '^leontap$', '^zexis$', '^rastyclient$', '^rasty$', '^winner$',
    '^dreampollclient$', '^fragsx$', '^keazclient$', '^keaz$', '^epfiriumclient$',
    '^epfirium$', '^nova$', '^novaclient$', '^emfrium$', '^forgehax$', '^huzuni$',
    '^flux$', '^neverhook$', '^fecurity$', '^phasmaclient$', '^phasma$', '^vendex$',
    '^rynwareclient$', '^runware$', '^buzeclient$', '^buze$', '^plintusvisual$',
    '^pulsevisual$', '^deltaclient$', '^deltaloader$', '^altening$', '^authme$'
)

$allPatterns = @()
$allPatterns += $CheatPatterns

Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.Security

$script:TotalFilesScanned = 0
$script:CurrentFileBeingScanned = ""
$script:CurrentScanType = ""
$script:CurrentStep = 0
$script:TotalSteps = 12

function Test-Signature {
    param([string]$FilePath)
    
    try {
        if (-not (Test-Path $FilePath)) { return $false }
        $signature = Get-AuthenticodeSignature -FilePath $FilePath -ErrorAction SilentlyContinue
        if ($signature) {
            return $signature.Status -eq 'Valid'
        }
        return $false
    } catch {
        return $false
    }
}

function Get-FileHashSHA256 {
    param([string]$FilePath)
    
    try {
        if (-not (Test-Path $FilePath)) { return $null }
        $hash = Get-FileHash -Path $FilePath -Algorithm SHA256 -ErrorAction SilentlyContinue
        if ($hash) {
            return $hash.Hash
        }
        return $null
    } catch {
        return $null
    }
}

function Test-JarContent {
    param([string]$FilePath)
    
    try {
        if (-not (Test-Path $FilePath)) { return @() }
        if ([System.IO.Path]::GetExtension($FilePath).ToLower() -ne '.jar') { return @() }
        
        $foundCheats = @()
        $zip = [System.IO.Compression.ZipFile]::OpenRead($FilePath)
        
        try {
            foreach ($entry in $zip.Entries) {
                $entryName = $entry.FullName.ToLower()
                
                $detection = Get-RiskLevel -InputString $entryName -FilePath $entryName
                if ($detection.Risk -ne 'Unknown') {
                    $foundCheats += $detection.Reason
                }
                
                if ($entry.Name -like '*.class' -or $entry.Name -like '*.java' -or $entry.Name -like '*.txt' -or $entry.Name -like '*.json' -or $entry.Name -like '*.cfg') {
                    try {
                        $stream = $entry.Open()
                        $reader = New-Object System.IO.StreamReader($stream)
                        $content = $reader.ReadToEnd()
                        $reader.Close()
                        $stream.Close()
                        
                        $lowerContent = $content.ToLower()
                        
                        foreach ($cheatName in $CheatCodePatterns.Keys) {
                            $patterns = $CheatCodePatterns[$cheatName]
                            $matchCount = 0
                            
                            foreach ($pattern in $patterns) {
                                if ($lowerContent -match [regex]::Escape($pattern.ToLower())) {
                                    $matchCount++
                                }
                            }
                            
                            if ($matchCount -ge 2) {
                                $foundCheats += "Совпадение с читом '$cheatName'"
                            }
                        }
                    } catch {
                    }
                }
            }
        } finally {
            $zip.Dispose()
        }
        
        return $foundCheats | Select-Object -Unique
    } catch {
        return @()
    }
}

function Check-VirusTotal {
    param([string]$FilePath)
    
    try {
        if (-not (Test-Path $FilePath)) { return $null }
        
        $hash = Get-FileHashSHA256 -FilePath $FilePath
        if (-not $hash) { return $null }
        
        $apiKey = $env:VIRUSTOTAL_API_KEY
        if ([string]::IsNullOrWhiteSpace($apiKey)) { return $null }
        
        $headers = @{
            'x-apikey' = $apiKey
        }
        
        $response = Invoke-RestMethod -Uri "https://www.virustotal.com/api/v3/files/$hash" -Headers $headers -Method Get -ErrorAction SilentlyContinue
        
        if ($response -and $response.data -and $response.data.attributes) {
            $stats = $response.data.attributes.last_analysis_stats
            return [PSCustomObject]@{
                Malicious = $stats.malicious
                Suspicious = $stats.suspicious
                Undetected = $stats.undetected
                Harmless = $stats.harmless
                Total = $stats.malicious + $stats.suspicious + $stats.undetected + $stats.harmless
            }
        }
        
        return $null
    } catch {
        return $null
    }
}

function Is-Whitelisted {
    param([string]$InputString, [string]$FilePath = "")
    
    if (-not $InputString) { 
        return $false 
    }
    
    $lowerInput = $InputString.ToLower()
    $lowerPath = $FilePath.ToLower()
    
    if ($lowerInput -match '\.jar$|\.jar\s|\.exe$|\.exe\s|\.dll$|\.dll\s') {
        return $false
    }
    
    if ($lowerPath -match '\\windows\\|\\system32\\|\\syswow64\\|\\program files\\|\\program files \(x86\)\\|\\programdata\\|\\appdata\\local\\temp\\|\\appdata\\local\\microsoft\\|\\appdata\\roaming\\microsoft\\') {
        return $true
    }
    
    foreach ($pattern in $whitelistPatterns) {
        if ($lowerInput -match [regex]::Escape($pattern)) {
            return $true
        }
    }
    
    return $false
}

function Get-RiskLevel {
    param([string]$InputString, [string]$FilePath = "")
    
    if (-not $InputString) { 
        return @{ 
            Risk = 'Unknown'
            Reason = ''
            Probability = 0 
        } 
    }
    
    $lowerInput = $InputString.ToLower()
    $lowerPath = $FilePath.ToLower()
    $foundPatterns = @()
    $probability = 0
    
    if (Is-Whitelisted -InputString $lowerInput -FilePath $lowerPath) {
        return @{ 
            Risk = 'Unknown'
            Reason = ''
            Probability = 0 
        }
    }
    
    $isExactMatch = $false
    $exactMatchCount = 0
    
    foreach ($pattern in $exactPatterns) {
        if ($lowerInput -match $pattern) {
            $patternName = $pattern.TrimStart('^').TrimEnd('$')
            if ($patternName -notin $foundPatterns) {
                $foundPatterns += $patternName
                $probability += 45
                $exactMatchCount++
                $isExactMatch = $true
            }
        }
    }
    
    if (-not $isExactMatch) {
        foreach ($pattern in $CheatPatterns) {
            if ($lowerInput -match [regex]::Escape($pattern.ToLower())) {
                if ($pattern -notin $foundPatterns) {
                    $foundPatterns += $pattern
                    $probability += 15
                }
            }
        }
    }
    
    $probability = [math]::Min(98, $probability + ($foundPatterns.Count * 7))
    
    $hash = 0
    foreach ($char in $lowerInput.ToCharArray()) {
        $hash = ($hash * 31 + [int]$char) % 1000
    }
    
    $probability = [math]::Min(98, $probability + ($hash % 20))
    
    if ($foundPatterns.Count -gt 0) {
        return @{ 
            Risk = 'Critical'
            Reason = "Совпадение с $($foundPatterns -join ', ')"
            Probability = [math]::Max(45, [math]::Min(98, $probability))
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

function Update-ProgressDisplay {
    $percent = [math]::Round(($script:CurrentStep / $script:TotalSteps) * 100)
    
    $barLength = 40
    $filled = [math]::Round($percent / 100 * $barLength)
    $empty = $barLength - $filled
    $bar = "[" + ("█" * $filled) + ("░" * $empty) + "]"
    
    $fileInfo = ""
    if ($script:CurrentFileBeingScanned) {
        $fileInfo = " | $($script:CurrentFileBeingScanned)"
    }
    
    Write-Host "`r$bar $percent% $($script:CurrentScanType) [Просканировано: $($script:TotalFilesScanned)]$fileInfo" -NoNewline -ForegroundColor Cyan
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

function Scan-DirectoryWithProgress {
    param(
        [string]$Path,
        [string]$ScanType,
        [int]$MaxDepth,
        [int]$CurrentIndex,
        [int]$TotalItems
    )
    
    if (-not (Test-Path $Path)) { return @() }
    
    $items = @()
    $files = @()
    
    try {
        $files = Get-ChildItem -Path $Path -File -Recurse -Depth $MaxDepth -ErrorAction SilentlyContinue | Where-Object {
            $_.Extension.ToLower() -in $allowedExtensions
        }
    } catch {
        $files = @()
    }
    
    foreach ($file in $files) {
        $script:TotalFilesScanned++
        $script:CurrentFileBeingScanned = $file.Name
        
        Update-ProgressDisplay
        
        $detection = Get-RiskLevel -InputString "$($file.Name) $($file.FullName)" -FilePath $file.FullName
        
        if ($detection.Risk -ne 'Unknown') {
            $jarFindings = @()
            $signatureValid = $null
            $fileHash = $null
            $vtResults = $null
            
            if ($file.Extension.ToLower() -eq '.jar') {
                $jarFindings = Test-JarContent -FilePath $file.FullName
            }
            
            if ($file.Extension.ToLower() -in @('.jar', '.exe', '.dll')) {
                $signatureValid = Test-Signature -FilePath $file.FullName
                $fileHash = Get-FileHashSHA256 -FilePath $file.FullName
                $vtResults = Check-VirusTotal -FilePath $file.FullName
            }
            
            $combinedReason = $detection.Reason
            if ($jarFindings.Count -gt 0) {
                $uniqueJarFindings = $jarFindings | Select-Object -Unique
                $shortJarFindings = ($uniqueJarFindings | Select-Object -First 3) -join '; '
                if ($uniqueJarFindings.Count -gt 3) {
                    $shortJarFindings += " и ещё $($uniqueJarFindings.Count - 3) совпадений"
                }
                $combinedReason += " | JAR: $shortJarFindings"
            }
            
            $signatureInfo = if ($null -ne $signatureValid) {
                if ($signatureValid) { "Подписано" } else { "Не подписано" }
            } else { "N/A" }
            
            $hashInfo = if ($fileHash) { $fileHash.Substring(0, 16) + "..." } else { "N/A" }
            
            $vtInfo = if ($vtResults) {
                "Mal:$($vtResults.Malicious) Susp:$($vtResults.Suspicious) Harm:$($vtResults.Harmless)"
            } else { "N/A" }
            
            $result = [PSCustomObject]@{
                'Тип' = $ScanType
                'Имя' = $file.Name
                'Путь' = $file.FullName
                'PID' = 'N/A'
                'Детали' = $combinedReason
                'Последнее изменение' = Format-LastWriteTime $file.LastWriteTime
                'Статус' = 'Найден'
                'Риск' = $detection.Risk
                'Вероятность' = $detection.Probability
                'Дней с изменения' = Get-DaysSinceLastWrite $file.LastWriteTime
                'Подпись' = $signatureInfo
                'SHA256' = $hashInfo
                'VirusTotal' = $vtInfo
                'Автор' = '976hk'
            }
            
            $items += $result
        }
    }
    
    return $items
}

$results = @()
$htmlResults = @()
$isAdmin = Test-Admin

Write-Host "`n════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host "  🐼  Minecraft Cheat Detector by 976hk  🐼" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════════`n" -ForegroundColor DarkGray

if (-not $isAdmin) {
    Write-Host "⚠️  Внимание: Скрипт запущен без прав администратора." -ForegroundColor Yellow
    Write-Host "   Некоторые проверки (службы, реестр HKLM) могут быть неполными.`n" -ForegroundColor Yellow
}

if ([string]::IsNullOrWhiteSpace($env:VIRUSTOTAL_API_KEY)) {
    Write-Host "ℹ️  Для проверки VirusTotal установите API ключ:" -ForegroundColor Gray
    Write-Host "   `$env:VIRUSTOTAL_API_KEY = 'ваш_ключ'`n" -ForegroundColor Gray
}

$script:CurrentStep = 1
$script:CurrentScanType = "Сканирование процессов"
Update-ProgressDisplay

Get-Process -ErrorAction SilentlyContinue | ForEach-Object {
    $procName = $_.Name
    $procPath = $null
    
    try {
        $procPath = $_.Path
    } catch {
        $procPath = $null
    }
    
    $script:CurrentFileBeingScanned = $procName
    Update-ProgressDisplay
    
    $detection = Get-RiskLevel -InputString "$procName $procPath" -FilePath $procPath
    
    if ($detection.Risk -ne 'Unknown') {
        $procInfo = $null
        
        if ($procPath) {
            $procInfo = Get-Item -Path $procPath -ErrorAction SilentlyContinue
        }
        
        $signatureValid = $null
        $fileHash = $null
        $vtResults = $null
        
        if ($procPath -and (Test-Path $procPath)) {
            $signatureValid = Test-Signature -FilePath $procPath
            $fileHash = Get-FileHashSHA256 -FilePath $procPath
            $vtResults = Check-VirusTotal -FilePath $procPath
        }
        
        $signatureInfo = if ($null -ne $signatureValid) {
            if ($signatureValid) { "Подписано" } else { "Не подписано" }
        } else { "N/A" }
        
        $hashInfo = if ($fileHash) { $fileHash.Substring(0, 16) + "..." } else { "N/A" }
        
        $vtInfo = if ($vtResults) {
            "Mal:$($vtResults.Malicious) Susp:$($vtResults.Suspicious) Harm:$($vtResults.Harmless)"
        } else { "N/A" }
        
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
            'Подпись' = $signatureInfo
            'SHA256' = $hashInfo
            'VirusTotal' = $vtInfo
            'Автор' = '976hk'
        }
        
        $results += $result
        
        if ($procPath -and $procPath -match '\.exe$|\.jar$|\.dll$') {
            $htmlResults += $result
        }
    }
}

$script:CurrentStep = 2
$script:CurrentScanType = "Сканирование файлов"
Update-ProgressDisplay

$scanPaths = @(
    "$env:UserProfile\Downloads",
    "$env:UserProfile\Desktop",
    "$env:UserProfile\Documents",
    "$env:Temp",
    "$env:AppData\Local\Temp",
    "$env:AppData\Roaming"
)

$pathIndex = 0
foreach ($path in $scanPaths) {
    $pathIndex++
    $scannedItems = Scan-DirectoryWithProgress -Path $path -ScanType "файлов" -MaxDepth 3 -CurrentIndex $pathIndex -TotalItems $scanPaths.Count
    
    foreach ($item in $scannedItems) {
        $results += $item
        
        if ($item.Путь -match '\.jar$|\.exe$|\.dll$') {
            $htmlResults += $item
        }
    }
}

$script:CurrentStep = 3
$script:CurrentScanType = "Сканирование Minecraft"
Update-ProgressDisplay

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

$mcPathIndex = 0
foreach ($mcPath in $minecraftPaths) {
    $mcPathIndex++
    $scannedItems = Scan-DirectoryWithProgress -Path $mcPath -ScanType "Minecraft" -MaxDepth 7 -CurrentIndex $mcPathIndex -TotalItems $minecraftPaths.Count
    
    foreach ($item in $scannedItems) {
        $results += $item
        
        if ($item.Путь -match '\.jar$|\.exe$|\.cfg$|\.json$|\.txt$') {
            $htmlResults += $item
        }
    }
}

$script:CurrentStep = 4
$script:CurrentScanType = "Сканирование DLL"
Update-ProgressDisplay

$dllPaths = @("$env:Temp", "$env:AppData\Local\Temp")

foreach ($dllPath in $dllPaths) {
    if (Test-Path $dllPath) {
        $dllFiles = Get-ChildItem -Path $dllPath -File -Filter "*.dll" -Recurse -Depth 3 -ErrorAction SilentlyContinue
        
        foreach ($dllFile in $dllFiles) {
            $script:TotalFilesScanned++
            $script:CurrentFileBeingScanned = $dllFile.Name
            
            Update-ProgressDisplay
            
            $detection = Get-RiskLevel -InputString "$($dllFile.Name) $($dllFile.FullName)" -FilePath $dllFile.FullName
            
            if ($detection.Risk -ne 'Unknown') {
                $signatureValid = Test-Signature -FilePath $dllFile.FullName
                $fileHash = Get-FileHashSHA256 -FilePath $dllFile.FullName
                $vtResults = Check-VirusTotal -FilePath $dllFile.FullName
                
                $signatureInfo = if ($null -ne $signatureValid) {
                    if ($signatureValid) { "Подписано" } else { "Не подписано" }
                } else { "N/A" }
                
                $hashInfo = if ($fileHash) { $fileHash.Substring(0, 16) + "..." } else { "N/A" }
                
                $vtInfo = if ($vtResults) {
                    "Mal:$($vtResults.Malicious) Susp:$($vtResults.Suspicious) Harm:$($vtResults.Harmless)"
                } else { "N/A" }
                
                $result = [PSCustomObject]@{
                    'Тип' = 'DLL Инжект'
                    'Имя' = $dllFile.Name
                    'Путь' = $dllFile.FullName
                    'PID' = 'N/A'
                    'Детали' = $detection.Reason
                    'Последнее изменение' = Format-LastWriteTime $dllFile.LastWriteTime
                    'Статус' = 'Найден'
                    'Риск' = $detection.Risk
                    'Вероятность' = $detection.Probability
                    'Дней с изменения' = Get-DaysSinceLastWrite $dllFile.LastWriteTime
                    'Подпись' = $signatureInfo
                    'SHA256' = $hashInfo
                    'VirusTotal' = $vtInfo
                    'Автор' = '976hk'
                }
                
                $results += $result
                $htmlResults += $result
            }
        }
    }
}

$script:CurrentStep = 5
$script:CurrentScanType = "Сканирование реестра"
Update-ProgressDisplay

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
                $detection = Get-RiskLevel -InputString "$($_.Name) $($_.Value)" -FilePath $_.Value
                
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
                        'Подпись' = 'N/A'
                        'SHA256' = 'N/A'
                        'VirusTotal' = 'N/A'
                        'Автор' = '976hk'
                    }
                    
                    $results += $result
                }
            }
        }
    }
}

$script:CurrentStep = 6
$script:CurrentScanType = "Сканирование служб"
Update-ProgressDisplay

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
            'Подпись' = 'N/A'
            'SHA256' = 'N/A'
            'VirusTotal' = 'N/A'
            'Автор' = '976hk'
        }
        
        $results += $result
    }
}

$script:CurrentStep = 7
$script:CurrentScanType = "Сканирование сети"
Update-ProgressDisplay

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
        $detection = Get-RiskLevel -InputString "$procName $procPath" -FilePath $procPath
        
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
                'Подпись' = 'N/A'
                'SHA256' = 'N/A'
                'VirusTotal' = 'N/A'
                'Автор' = '976hk'
            }
            
            $results += $result
        }
    }
}

$script:CurrentStep = 8
$script:CurrentScanType = "Сканирование задач"
Update-ProgressDisplay

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
            'Подпись' = 'N/A'
            'SHA256' = 'N/A'
            'VirusTotal' = 'N/A'
            'Автор' = '976hk'
        }
        
        $results += $result
    }
}

$script:CurrentStep = 9
$script:CurrentScanType = "Сканирование хостов"
Update-ProgressDisplay

$hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"
if (Test-Path $hostsPath) {
    $hostsContent = Get-Content $hostsPath -ErrorAction SilentlyContinue
    $suspiciousHosts = $hostsContent | Where-Object {
        $_ -match [regex]::Escape($CheatPatterns[0]) -and $_ -notmatch '^\s*#'
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
                'Подпись' = 'N/A'
                'SHA256' = 'N/A'
                'VirusTotal' = 'N/A'
                'Автор' = '976hk'
            }
            
            $results += $result
        }
    }
}

$script:CurrentStep = 12
$script:CurrentScanType = "Сканирование завершено"
$script:CurrentFileBeingScanned = ""
Update-ProgressDisplay
Write-Host ""

$processResults = $results | Where-Object { $_.Тип -eq 'Процесс' }
$serviceResults = $results | Where-Object { $_.Тип -eq 'Служба' }
$fileResults = $results | Where-Object { $_.Тип -notin @('Процесс', 'Служба') }

$criticalResults = $fileResults | Where-Object { 
    $_.Риск -eq 'Critical' -and $_.'Дней с изменения' -le 14 
} | Sort-Object -Property 'Дней с изменения', 'Вероятность' -Descending

$highResults = $fileResults | Where-Object { 
    $_.Риск -eq 'High' -and $_.'Дней с изменения' -le 14 
} | Sort-Object -Property 'Дней с изменения', 'Вероятность' -Descending

$suspiciousResults = $fileResults | Where-Object { 
    $_.Риск -eq 'Suspicious' -and $_.'Дней с изменения' -le 14 
} | Sort-Object -Property 'Дней с изменения', 'Вероятность' -Descending

$oldResults = $fileResults | Where-Object { 
    $_.'Дней с изменения' -gt 14 -and $_.Риск -ne 'System' 
} | Sort-Object -Property 'Дней с изменения' -Descending

$systemResults = $serviceResults | Where-Object { 
    $_.Риск -eq 'System' 
}

Write-Host "=== Результаты сканирования ===" -ForegroundColor Cyan
Write-Host "Всего просканировано файлов: $($script:TotalFilesScanned)" -ForegroundColor White
Write-Host "Всего найдено (CSV): $($results.Count)" -ForegroundColor White
Write-Host "Свежие критические (≤14 дней): $($criticalResults.Count)" -ForegroundColor Red
Write-Host "Свежие высокого риска (≤14 дней): $($highResults.Count)" -ForegroundColor DarkRed
Write-Host "Свежие подозрительные (≤14 дней): $($suspiciousResults.Count)" -ForegroundColor Yellow
Write-Host "Старые (более 14 дней): $($oldResults.Count)" -ForegroundColor Gray
Write-Host "Системных служб: $($systemResults.Count)" -ForegroundColor DarkGray
Write-Host "Запущенных процессов: $($processResults.Count)" -ForegroundColor Magenta
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
.services h2 {
    background: #1a1a1a;
    color: #666666;
    border-left: 4px solid #666666;
}
.processes h2 {
    background: #1a0033;
    color: #cc66ff;
    border-left: 4px solid #cc66ff;
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
.tech-info {
    background: #1a1a1a;
    padding: 5px 10px;
    margin: 5px 0;
    border-radius: 3px;
    font-size: 0.9em;
    color: #888;
}
.signed {
    color: #00ff00;
}
.unsigned {
    color: #ff0000;
}
.process-item {
    border-left: 4px solid #cc66ff;
    background: #1a0a2a;
}
</style>
</head>
<body>
<h1>🐼 Minecraft Cheat Detector Report</h1>
<p>Автор: 976hk | Дата сканирования: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</p>
<div class='summary'>
    <span style='color: #666666;'>Службы: $($serviceResults.Count)</span>
    <span style='color: #cc66ff;'>Процессы: $($processResults.Count)</span>
    <span style='color: #ff0000;'>Свежие критические: $($criticalResults.Count)</span>
    <span style='color: #ff6600;'>Свежие высокого риска: $($highResults.Count)</span>
    <span style='color: #ffff00;'>Свежие подозрительные: $($suspiciousResults.Count)</span>
    <span style='color: #888888;'>Старые: $($oldResults.Count)</span>
    <span style='color: #ffffff;'>Всего просканировано: $($script:TotalFilesScanned)</span>
</div>
"@
        
        if ($serviceResults.Count -gt 0) {
            $html += "<div class='services'><h2>⚙️ Службы ($($serviceResults.Count))</h2>"
            
            $runningCount = ($serviceResults | Where-Object { $_.Статус -eq 'Running' }).Count
            $stoppedCount = ($serviceResults | Where-Object { $_.Статус -ne 'Running' }).Count
            
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
            
            foreach ($item in $serviceResults) {
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
                
                $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                
                $html += @"
<div class='item'>
<h3>$($item.Имя)</h3>
<p>Тип: $($item.Тип) | Путь: <span class='path'>$($item.Путь)</span></p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Изменен: $($item.'Последнее изменение')</p>
<p class='details'>Статус: $($item.Статус)</p>
<p>Вероятность чит-клиента: <span class='$probabilityClass'>$($item.Вероятность)%</span></p>
<div class='tech-info'>
    Подпись: <span class='$signatureClass'>$($item.Подпись)</span> | SHA256: $($item.SHA256) | VirusTotal: $($item.VirusTotal)
</div>
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
                
                $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                
                $html += @"
<div class='item'>
<h3>$($item.Имя)</h3>
<p>Тип: $($item.Тип) | Путь: <span class='path'>$($item.Путь)</span></p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Изменен: $($item.'Последнее изменение')</p>
<p class='details'>Статус: $($item.Статус)</p>
<p>Вероятность чит-клиента: <span class='$probabilityClass'>$($item.Вероятность)%</span></p>
<div class='tech-info'>
    Подпись: <span class='$signatureClass'>$($item.Подпись)</span> | SHA256: $($item.SHA256) | VirusTotal: $($item.VirusTotal)
</div>
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
                
                $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                
                $html += @"
<div class='item'>
<h3>$($item.Имя)</h3>
<p>Тип: $($item.Тип) | Путь: <span class='path'>$($item.Путь)</span></p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Изменен: $($item.'Последнее изменение')</p>
<p class='details'>Статус: $($item.Статус)</p>
<p>Вероятность чит-клиента: <span class='$probabilityClass'>$($item.Вероятность)%</span></p>
<div class='tech-info'>
    Подпись: <span class='$signatureClass'>$($item.Подпись)</span> | SHA256: $($item.SHA256) | VirusTotal: $($item.VirusTotal)
</div>
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
                
                $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                
                $html += @"
<div class='item'>
<h3>$($item.Имя)</h3>
<p>Тип: $($item.Тип) | Путь: <span class='path'>$($item.Путь)</span></p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Изменен: $($item.'Последнее изменение')</p>
<p class='details'>Статус: $($item.Статус)</p>
<p>Вероятность чит-клиента: <span class='$probabilityClass'>$($item.Вероятность)%</span></p>
<div class='tech-info'>
    Подпись: <span class='$signatureClass'>$($item.Подпись)</span> | SHA256: $($item.SHA256) | VirusTotal: $($item.VirusTotal)
</div>
</div>
"@
            }
            
            $html += "</div>"
        }
        
        if ($processResults.Count -gt 0) {
            $html += "<div class='processes'><h2>🚀 Запущенные процессы ($($processResults.Count))</h2>"
            
            foreach ($item in $processResults) {
                $probabilityClass = if ($item.Вероятность -ge 90) { 
                    'probability-high' 
                } elseif ($item.Вероятность -ge 70) { 
                    'probability-medium' 
                } elseif ($item.Вероятность -ge 40) { 
                    'probability-low' 
                } else { 
                    'probability-none' 
                }
                
                $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                
                $html += @"
<div class='item process-item'>
<h3>$($item.Имя) (PID: $($item.PID))</h3>
<p>Путь: <span class='path'>$($item.Путь)</span></p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Изменен: $($item.'Последнее изменение')</p>
<p class='details'>Статус: $($item.Статус)</p>
<p>Вероятность чит-клиента: <span class='$probabilityClass'>$($item.Вероятность)%</span></p>
<div class='tech-info'>
    Подпись: <span class='$signatureClass'>$($item.Подпись)</span> | SHA256: $($item.SHA256) | VirusTotal: $($item.VirusTotal)
</div>
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
