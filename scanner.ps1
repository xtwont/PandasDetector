param(
    [string]$ConfigPath = "cheat_detector_config.json",
    [switch]$SkipVirusTotal,
    [switch]$NoParallel,
    [int]$ThrottleLimit = 10
)

$DefaultConfig = @{
    scan = @{
        paths = @(
            "%UserProfile%\Downloads",
            "%UserProfile%\Desktop",
            "%UserProfile%\Documents",
            "%Temp%",
            "%AppData%\Local\Temp",
            "%AppData%\Roaming"
        )
        minecraft_paths = @(
            "%AppData%\.minecraft\mods",
            "%AppData%\.minecraft\versions",
            "%AppData%\.minecraft\config",
            "%AppData%\.minecraft\libraries",
            "%AppData%\.minecraft\resourcepacks",
            "%AppData%\.minecraft\shaderpacks",
            "%AppData%\.minecraft\saves",
            "%AppData%\.minecraft\logs",
            "%AppData%\.minecraft\crash-reports"
        )
        max_depth_files = 3
        max_depth_minecraft = 7
        days_recent = 14
        parallel_threads = 10
        check_processes = $true
        check_services = $true
        check_registry = $true
        check_network = $true
        check_scheduled_tasks = $true
        check_hosts = $true
        check_dll = $true
    }
    detection = @{
        cheat_patterns = @(
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
        cheat_code_patterns = @{
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
            'Baritone' = @('baritone', 'baritone_api', 'baritoneapi', 'baritone-api', 'baritone_cache', 'baritone_cached', 'minecraft_block', 'minecraft_path', 'pathfinder', 'path_finder', 'pathfinding', 'path_finding', 'auto_miner', 'autominer', 'auto_mine', 'automine', 'auto_builder', 'autobuilder', 'auto_build', 'autobuild', 'auto_farmer', 'autofarmer', 'auto_farm', 'autofarm', 'auto_explore', 'autoexplore', 'auto_explorer', 'autoexplorer')
        }
        whitelist_patterns = @(
            'fabric', 'fabricloader', 'fabric-api', 'fabric.mod', 'fabricmod',
            'fabric-loader', 'fabric-resource-loader', 'fabric_loader',
            'fabricmc', 'fabric-mc', 'fabric.loader', 'fabric.resource',
            'fabric-language-kotlin', 'fabric-content-registries',
            'quilt', 'quiltloader', 'forge', 'neoforge', 'optifine',
            'fmlloader', 'fml_loader', 'fml-loader', 'fml.loader',
            'minecraftforge', 'minecraft_forge', 'forge-', 'forge_',
            'net.minecraftforge', 'net.minecraftforge.fml',
            'net.minecraftforge.fmlloader', 'net.minecraftforge.forge',
            'net.minecraftforge.versions', 'net.minecraftforge.coremods',
            'net.minecraftforge.eventbus', 'net.minecraftforge.registries',
            'net.minecraftforge.network', 'net.minecraftforge.common',
            'net.minecraftforge.client', 'net.minecraftforge.server',
            'net.minecraftforge.api', 'net.minecraftforge.items',
            'net.minecraftforge.fluids', 'net.minecraftforge.energy',
            'net.minecraftforge.capabilities', 'net.minecraftforge.entity',
            'net.minecraftforge.block', 'net.minecraftforge.item',
            'net.minecraftforge.world', 'net.minecraftforge.biome',
            'net.minecraftforge.dimension', 'net.minecraftforge.chunk',
            'net.minecraftforge.particle', 'net.minecraftforge.sound',
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
            'update', 'updater', 'driver', 'drivers', 'device', 'devices', 'hardware', 'software',
            'microsoft', 'office', 'cloud', 'backup', 'restore', 'recovery', 'security', 'defender',
            'firewall', 'antivirus', 'protection', 'monitor', 'monitoring', 'diagnostic', 'diagnostics',
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
            'customskinloader', 'skinloader', 'customskin',
            'net.fabricmc', 'net.fabric', 'fabricmc.net', 'fabric.net',
            'processedmods', '.fabric', 'fabric-loader', 'fabric-resource',
            'fabric-language', 'fabric-content', 'fabric-registry',
            'fabric-rendering', 'fabric-renderer', 'fabric-networking',
            'fabric-screen', 'fabric-screen-handler', 'fabric-transfer',
            'fabric-object-builder', 'fabric-block-view', 'fabric-model',
            'fabric-texture', 'fabric-lifecycle', 'fabric-registries',
            'fabric-command', 'fabric-entity', 'fabric-item', 'fabric-block',
            'fabric-loot', 'fabric-recipe', 'fabric-resource-conditions',
            'fabric-data-generation', 'fabric-data-gen', 'fabric-datagen',
            'fabric-biome', 'fabric-dimension', 'fabric-world', 'fabric-chunk',
            'fabric-particle', 'fabric-sound', 'fabric-client', 'fabric-server',
            'fabric-message', 'fabric-packet', 'fabric-protocol', 'fabric-api-base',
            'fabric-api-lookup', 'fabric-api-impl', 'fabric-api-module',
            'fabric-impl', 'fabric-mixin', 'fabric-access', 'fabric-invoker',
            'net.minecraftforge', 'minecraftforge', 'fmlloader', 'fml',
            'forge-1.20', 'forge-1.19', 'forge-1.18', 'forge-1.17',
            'forge-1.16', 'forge-1.15', 'forge-1.14', 'forge-1.13',
            'forge-1.12', 'forge-1.11', 'forge-1.10', 'forge-1.9',
            'forge-1.8', 'forge-1.7', 'forge-1.6', 'forge-1.5'
        )
        system_process_patterns = @(
            'system', 'idle', 'registry', 'smss', 'csrss', 'wininit', 'winlogon',
            'services', 'lsass', 'fontdrvhost', 'svchost', 'dllhost', 'wmiprvse',
            'sihost', 'taskhostw', 'conhost', 'explorer', 'dwm', 'shell',
            'runtimebroker', 'searchindexer', 'searchui', 'startmenuexperiencehost',
            'textinputhost', 'applicationframehost', 'shellexperiencehost',
            'securityhealthservice', 'securityhealthsystray', 'msmpeng',
            'nissrv', 'defender', 'antimalware', 'mpcmdrun'
        )
        exact_patterns = @(
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
            '^pulsevisual$', '^deltaclient$', '^deltaloader$', '^altening$', '^authme$',
            '^baritone$', '^baritoneapi$', '^baritone-api$', '^baritone_api$'
        )
        jar_suspicious_patterns = @(
            'mixins', 'mixin', 'transformers', 'transformer', 'asm', 'bytecode',
            'reflection', 'reflect', 'hook', 'hooks',
            'native', 'jni', 'unsafe', 'classloader', 'loadclass',
            'socket', 'network', 'http', 'https', 'url', 'download',
            'upload', 'registry', 'system', 'windows', 'linux', 'macos',
            'keyboard', 'mouse', 'input', 'output', 'stream',
            'thread', 'threads', 'concurrent', 'async', 'await',
            'packet', 'packets', 'client', 'server', 'proxy', 'vpn',
            'encrypt', 'decrypt', 'encode', 'decode', 'hash', 'checksum',
            'compress', 'decompress', 'zip', 'unzip', 'archive', 'extract',
            'config', 'configure', 'setting', 'settings', 'option', 'options',
            'mode', 'modes', 'state', 'states', 'status', 'statuses',
            'enable', 'disable', 'toggle', 'switch', 'flip', 'change',
            'start', 'stop', 'pause', 'resume', 'restart', 'reboot',
            'open', 'close', 'connect', 'disconnect', 'bind', 'unbind',
            'send', 'receive', 'transmit', 'transfer', 'copy', 'move',
            'create', 'destroy', 'init', 'initiate', 'terminate', 'kill'
        )
    }
    virustotal = @{
        api_key = ""
        check_files = $true
        check_processes = $false
        max_requests_per_minute = 4
        cache_file = "vt_cache.json"
        cache_hours = 24
    }
    output = @{
        save_csv = $true
        save_html = $true
        save_json = $false
        output_path = "%Desktop%"
        filename_prefix = "cheat_scan"
        open_html_after_scan = $true
    }
    logging = @{
        enabled = $true
        log_file = "scan_log.txt"
        log_level = "INFO"
        log_errors = $true
        log_warnings = $true
        log_info = $true
        log_debug = $false
    }
}

$config = $DefaultConfig

if (Test-Path $ConfigPath) {
    try {
        $userConfig = Get-Content $ConfigPath -Raw | ConvertFrom-Json -ErrorAction Stop
        
        foreach ($section in $userConfig.PSObject.Properties) {
            if ($config.$($section.Name)) {
                foreach ($prop in $section.Value.PSObject.Properties) {
                    $config.$($section.Name).$($prop.Name) = $prop.Value
                }
            }
        }
        Write-Host "✅ Конфигурация загружена: $ConfigPath" -ForegroundColor Green
    } catch {
        Write-Host "⚠️ Ошибка загрузки конфигурации, используются значения по умолчанию" -ForegroundColor Yellow
    }
} else {
    try {
        $DefaultConfig | ConvertTo-Json -Depth 10 | Out-File -FilePath $ConfigPath -Encoding UTF8
        Write-Host "📝 Создан файл конфигурации: $ConfigPath" -ForegroundColor Gray
    } catch {
        Write-Host "⚠️ Не удалось создать файл конфигурации" -ForegroundColor Yellow
    }
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.Security

$script:TotalFilesScanned = 0
$script:CurrentFileBeingScanned = ""
$script:CurrentScanType = ""
$script:CurrentStep = 0
$script:TotalSteps = 12
$script:VirusTotalRequests = 0
$script:VirusTotalLastRequestTime = Get-Date
$script:VirusTotalCache = @{}
$script:LogFile = $config.logging.log_file

if (Test-Path $config.virustotal.cache_file) {
    try {
        $script:VirusTotalCache = Get-Content $config.virustotal.cache_file -Raw | ConvertFrom-Json -ErrorAction Stop
        Write-Host "📦 Кэш VirusTotal загружен: $($script:VirusTotalCache.Count) записей" -ForegroundColor Gray
    } catch {
        $script:VirusTotalCache = @{}
    }
}

function Write-Log {
    param(
        [string]$Message,
        [ValidateSet('DEBUG', 'INFO', 'WARNING', 'ERROR')]
        [string]$Level = 'INFO'
    )
    
    if (-not $config.logging.enabled) { return }
    
    $levels = @{
        'DEBUG' = 0
        'INFO' = 1
        'WARNING' = 2
        'ERROR' = 3
    }
    
    $configLevel = switch ($config.logging.log_level) {
        'DEBUG' { 0 }
        'INFO' { 1 }
        'WARNING' { 2 }
        'ERROR' { 3 }
        default { 1 }
    }
    
    if ($levels[$Level] -lt $configLevel) { return }
    
    switch ($Level) {
        'ERROR' { if (-not $config.logging.log_errors) { return } }
        'WARNING' { if (-not $config.logging.log_warnings) { return } }
        'INFO' { if (-not $config.logging.log_info) { return } }
        'DEBUG' { if (-not $config.logging.log_debug) { return } }
    }
    
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $logMessage = "[$timestamp] [$Level] $Message"
    
    switch ($Level) {
        'DEBUG' { Write-Host $logMessage -ForegroundColor Gray }
        'INFO' { Write-Host $logMessage -ForegroundColor White }
        'WARNING' { Write-Host $logMessage -ForegroundColor Yellow }
        'ERROR' { Write-Host $logMessage -ForegroundColor Red }
    }
    
    try {
        Add-Content -Path $script:LogFile -Value $logMessage -Encoding UTF8
    } catch {
    }
}

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
        Write-Log "Ошибка проверки подписи: $FilePath - $($_.Exception.Message)" -Level 'ERROR'
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
        Write-Log "Ошибка получения хеша: $FilePath - $($_.Exception.Message)" -Level 'ERROR'
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
                
                if ($entry.Name -like '*.class' -or $entry.Name -like '*.java' -or 
                    $entry.Name -like '*.txt' -or $entry.Name -like '*.json' -or 
                    $entry.Name -like '*.cfg' -or $entry.Name -like '*.xml' -or
                    $entry.Name -like '*.properties' -or $entry.Name -like '*.yml') {
                    try {
                        $stream = $entry.Open()
                        $reader = New-Object System.IO.StreamReader($stream)
                        $content = $reader.ReadToEnd()
                        $reader.Close()
                        $stream.Close()
                        
                        $lowerContent = $content.ToLower()
                        
                        foreach ($cheatName in $config.detection.cheat_code_patterns.Keys) {
                            $patterns = $config.detection.cheat_code_patterns[$cheatName]
                            $matchCount = 0
                            
                            foreach ($pattern in $patterns) {
                                if ($lowerContent -match [regex]::Escape($pattern.ToLower())) {
                                    $matchCount++
                                }
                            }
                            
                            if ($matchCount -ge 2) {
                                $foundCheats += "Совпадение с читом '$cheatName' ($matchCount паттернов)"
                            }
                        }
                        
                        $suspiciousCount = 0
                        foreach ($pattern in $config.detection.jar_suspicious_patterns) {
                            if ($lowerContent -match [regex]::Escape($pattern)) {
                                $suspiciousCount++
                            }
                        }
                        
                        if ($suspiciousCount -ge 15) {
                            $foundCheats += "Подозрительный код ($suspiciousCount паттернов)"
                        }
                    } catch {
                        Write-Log "Ошибка чтения JAR entry: $($entry.FullName)" -Level 'DEBUG'
                    }
                }
            }
        } finally {
            $zip.Dispose()
        }
        
        return $foundCheats | Select-Object -Unique
    } catch {
        Write-Log "Ошибка анализа JAR: $FilePath - $($_.Exception.Message)" -Level 'ERROR'
        return @()
    }
}

function Check-VirusTotal {
    param([string]$FilePath)
    
    try {
        if ($SkipVirusTotal) { return $null }
        if (-not (Test-Path $FilePath)) { return $null }
        if (-not $config.virustotal.check_files) { return $null }
        
        $hash = Get-FileHashSHA256 -FilePath $FilePath
        if (-not $hash) { return $null }
        
        if ($script:VirusTotalCache.ContainsKey($hash)) {
            $cached = $script:VirusTotalCache[$hash]
            $lastChecked = [DateTime]$cached.last_checked
            $hoursSinceCheck = ((Get-Date) - $lastChecked).TotalHours
            
            if ($hoursSinceCheck -lt $config.virustotal.cache_hours) {
                Write-Log "Кэш VirusTotal: $hash (проверено $hoursSinceCheck ч. назад)" -Level 'DEBUG'
                return [PSCustomObject]@{
                    Malicious = $cached.malicious
                    Suspicious = $cached.suspicious
                    Undetected = $cached.undetected
                    Harmless = $cached.harmless
                    Total = $cached.malicious + $cached.suspicious + $cached.undetected + $cached.harmless
                }
            }
        }
        
        $apiKey = $config.virustotal.api_key
        if ([string]::IsNullOrWhiteSpace($apiKey)) {
            $apiKey = $env:VIRUSTOTAL_API_KEY
        }
        
        if ([string]::IsNullOrWhiteSpace($apiKey)) { return $null }
        
        $timeSinceLastRequest = ((Get-Date) - $script:VirusTotalLastRequestTime).TotalSeconds
        if ($script:VirusTotalRequests -ge $config.virustotal.max_requests_per_minute) {
            $waitTime = 60 - $timeSinceLastRequest
            if ($waitTime -gt 0) {
                Write-Log "Ожидание лимита VirusTotal: $waitTime сек" -Level 'INFO'
                Start-Sleep -Seconds $waitTime
                $script:VirusTotalRequests = 0
                $script:VirusTotalLastRequestTime = Get-Date
            }
        }
        
        $headers = @{
            'x-apikey' = $apiKey
        }
        
        $response = Invoke-RestMethod -Uri "https://www.virustotal.com/api/v3/files/$hash" -Headers $headers -Method Get -ErrorAction SilentlyContinue
        
        $script:VirusTotalRequests++
        $script:VirusTotalLastRequestTime = Get-Date
        
        if ($response -and $response.data -and $response.data.attributes) {
            $stats = $response.data.attributes.last_analysis_stats
            
            $result = [PSCustomObject]@{
                Malicious = $stats.malicious
                Suspicious = $stats.suspicious
                Undetected = $stats.undetected
                Harmless = $stats.harmless
                Total = $stats.malicious + $stats.suspicious + $stats.undetected + $stats.harmless
            }
            
            $script:VirusTotalCache[$hash] = @{
                hash = $hash
                malicious = $result.Malicious
                suspicious = $result.Suspicious
                undetected = $result.Undetected
                harmless = $result.Harmless
                last_checked = (Get-Date).ToString('yyyy-MM-ddTHH:mm:ss')
            }
            
            try {
                $script:VirusTotalCache | ConvertTo-Json -Depth 10 | Out-File -FilePath $config.virustotal.cache_file -Encoding UTF8
            } catch {
                Write-Log "Ошибка сохранения кэша VirusTotal" -Level 'WARNING'
            }
            
            return $result
        }
        
        return $null
    } catch {
        Write-Log "Ошибка VirusTotal: $($_.Exception.Message)" -Level 'ERROR'
        return $null
    }
}

function Is-Whitelisted {
    param([string]$InputString, [string]$FilePath = "")
    
    if (-not $InputString) { return $false }
    
    $lowerInput = $InputString.ToLower()
    $lowerPath = $FilePath.ToLower()
    
    if ($lowerPath -match '\\\.minecraft\\versions\\.*\\\.fabric\\') {
        return $true
    }
    
    if ($lowerPath -match '\\\.minecraft\\libraries\\net\\fabricmc\\') {
        return $true
    }
    
    if ($lowerPath -match '\\\.minecraft\\libraries\\net\\minecraftforge\\') {
        return $true
    }
    
    if ($lowerPath -match '\\\.minecraft\\libraries\\net\\minecraftforge\\fmlloader\\') {
        return $true
    }
    
    if ($lowerPath -match '\\\.minecraft\\libraries\\.*\\fabric') {
        return $true
    }
    
    if ($lowerPath -match '\\\.minecraft\\libraries\\.*\\forge') {
        return $true
    }
    
    if ($lowerPath -match '\\\.minecraft\\libraries\\.*\\minecraftforge') {
        return $true
    }
    
    if ($lowerPath -match '\\\.minecraft\\mods\\.*fabric') {
        return $true
    }
    
    if ($lowerPath -match '\\\.minecraft\\mods\\.*forge') {
        return $true
    }
    
    if ($lowerInput -match '\.jar$|\.jar\s|\.exe$|\.exe\s|\.dll$|\.dll\s') {
        return $false
    }
    
    if ($lowerPath -match '\\windows\\|\\system32\\|\\syswow64\\|\\program files\\|\\program files \(x86\)\\|\\programdata\\|\\appdata\\local\\temp\\|\\appdata\\local\\microsoft\\|\\appdata\\roaming\\microsoft\\') {
        return $true
    }
    
    foreach ($pattern in $config.detection.whitelist_patterns) {
        if ($lowerInput -match [regex]::Escape($pattern)) {
            return $true
        }
    }
    
    return $false
}

function Is-SystemProcess {
    param([string]$ProcessName)
    
    if (-not $ProcessName) { return $false }
    
    $lowerName = $ProcessName.ToLower()
    
    foreach ($pattern in $config.detection.system_process_patterns) {
        if ($lowerName -match [regex]::Escape($pattern)) {
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
    
    foreach ($pattern in $config.detection.exact_patterns) {
        if ($lowerInput -match $pattern) {
            $patternName = $pattern.TrimStart('^').TrimEnd('$')
            if ($patternName -notin $foundPatterns) {
                $foundPatterns += $patternName
                $probability += 45
                $isExactMatch = $true
            }
        }
    }
    
    if (-not $isExactMatch) {
        foreach ($pattern in $config.detection.cheat_patterns) {
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
        $riskLevel = 'Critical'
        if ($probability -lt 60) { $riskLevel = 'High' }
        if ($probability -lt 40) { $riskLevel = 'Suspicious' }
        
        return @{ 
            Risk = $riskLevel
            Reason = "Совпадение с $($foundPatterns -join ', ')"
            Probability = [math]::Max(30, [math]::Min(98, $probability))
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
    
    if ($null -eq $LastWriteTime) { return "Неизвестно" }
    
    $timeDiff = (Get-Date) - $LastWriteTime
    
    if ($timeDiff.TotalMinutes -lt 1) { return "только что" }
    elseif ($timeDiff.TotalHours -lt 1) { return "$([math]::Floor($timeDiff.TotalMinutes)) мин. назад" }
    elseif ($timeDiff.TotalDays -lt 1) { return "$([math]::Floor($timeDiff.TotalHours)) ч. $($timeDiff.Minutes) мин. назад" }
    elseif ($timeDiff.TotalDays -lt 30) { return "$([math]::Floor($timeDiff.TotalDays)) дн. $([math]::Floor($timeDiff.TotalHours % 24)) ч. назад" }
    else { return "$([math]::Floor($timeDiff.TotalDays / 30)) мес. $([math]::Floor($timeDiff.TotalDays % 30)) дн. назад" }
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
    
    if ($null -eq $LastWriteTime) { return 999 }
    
    $timeDiff = (Get-Date) - $LastWriteTime
    return [math]::Floor($timeDiff.TotalDays)
}

function Get-AllowedExtensions {
    return @(
        '.jar', '.exe', '.dll', '.bat', '.cmd', '.ps1', '.vbs', '.msi', 
        '.zip', '.rar', '.7z', '.json', '.cfg', '.txt', '.log', '.dat', 
        '.properties', '.yml', '.yaml', '.xml', '.class', '.java', '.py', '.js', '.lua'
    )
}

function Scan-FileWithDetails {
    param(
        [string]$FilePath,
        [string]$ScanType
    )
    
    $file = Get-Item -Path $FilePath -ErrorAction SilentlyContinue
    if (-not $file) { return $null }
    
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
        
        return [PSCustomObject]@{
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
    }
    
    return $null
}

function Scan-DirectoryWithProgress {
    param(
        [string]$Path,
        [string]$ScanType,
        [int]$MaxDepth
    )
    
    if (-not (Test-Path $Path)) { return @() }
    
    $items = @()
    $files = @()
    $allowedExtensions = Get-AllowedExtensions
    
    try {
        $files = Get-ChildItem -Path $Path -File -Recurse -Depth $MaxDepth -ErrorAction SilentlyContinue | Where-Object {
            $_.Extension.ToLower() -in $allowedExtensions
        }
    } catch {
        $files = @()
    }
    
    foreach ($file in $files) {
        $result = Scan-FileWithDetails -FilePath $file.FullName -ScanType $ScanType
        if ($result) {
            $items += $result
        }
    }
    
    return $items
}

$results = @()
$processResults = @()
$injectResults = @()
$serviceResults = @()
$isAdmin = Test-Admin

Write-Host "`n════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host "  🐼  Minecraft Cheat Detector v2.0 by 976hk  🐼" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════════`n" -ForegroundColor DarkGray

if (-not $isAdmin) {
    Write-Host "⚠️  Внимание: Скрипт запущен без прав администратора." -ForegroundColor Yellow
    Write-Host "   Некоторые проверки (службы, реестр HKLM) могут быть неполными.`n" -ForegroundColor Yellow
}

if ([string]::IsNullOrWhiteSpace($env:VIRUSTOTAL_API_KEY) -and [string]::IsNullOrWhiteSpace($config.virustotal.api_key)) {
    Write-Host "ℹ️  Для проверки VirusTotal установите API ключ:" -ForegroundColor Gray
    Write-Host "   `$env:VIRUSTOTAL_API_KEY = 'ваш_ключ'`n" -ForegroundColor Gray
}

$script:CurrentStep = 1
$script:CurrentScanType = "Сканирование процессов"
Update-ProgressDisplay

$allProcesses = Get-Process -ErrorAction SilentlyContinue
$processCount = $allProcesses.Count
$useWhitelistForProcesses = $processCount -gt 50

foreach ($proc in $allProcesses) {
    $procName = $proc.Name
    $procPath = $null
    
    try {
        $procPath = $proc.Path
    } catch {
        $procPath = $null
    }
    
    $script:CurrentFileBeingScanned = $procName
    Update-ProgressDisplay
    
    $isSystemProc = Is-SystemProcess -ProcessName $procName
    
    if ($useWhitelistForProcesses -and $isSystemProc) {
        continue
    }
    
    $signatureValid = $null
    $fileHash = $null
    $vtResults = $null
    
    if ($procPath -and (Test-Path $procPath)) {
        $signatureValid = Test-Signature -FilePath $procPath
        $fileHash = Get-FileHashSHA256 -FilePath $procPath
        if ($config.virustotal.check_processes) {
            $vtResults = Check-VirusTotal -FilePath $procPath
        }
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
        'PID' = $proc.Id
        'Детали' = if ($isSystemProc) { "Системный процесс" } else { "Запущенный процесс" }
        'Последнее изменение' = 'N/A'
        'Статус' = 'Работает'
        'Риск' = 'Info'
        'Вероятность' = 0
        'Дней с изменения' = 999
        'Подпись' = $signatureInfo
        'SHA256' = $hashInfo
        'VirusTotal' = $vtInfo
        'Автор' = '976hk'
    }
    
    $results += $result
    $processResults += $result
}

$script:CurrentStep = 2
$script:CurrentScanType = "Сканирование файлов"
Update-ProgressDisplay

$scanPaths = $config.scan.paths | ForEach-Object {
    [Environment]::ExpandEnvironmentVariables($_)
}

foreach ($path in $scanPaths) {
    $scannedItems = Scan-DirectoryWithProgress -Path $path -ScanType "файлов" -MaxDepth $config.scan.max_depth_files
    
    foreach ($item in $scannedItems) {
        $results += $item
    }
}

$script:CurrentStep = 3
$script:CurrentScanType = "Сканирование Minecraft"
Update-ProgressDisplay

$minecraftPaths = $config.scan.minecraft_paths | ForEach-Object {
    [Environment]::ExpandEnvironmentVariables($_)
}

foreach ($mcPath in $minecraftPaths) {
    $scannedItems = Scan-DirectoryWithProgress -Path $mcPath -ScanType "Minecraft" -MaxDepth $config.scan.max_depth_minecraft
    
    foreach ($item in $scannedItems) {
        $results += $item
    }
}

$script:CurrentStep = 4
$script:CurrentScanType = "Сканирование DLL"
Update-ProgressDisplay

if ($config.scan.check_dll) {
    $dllPaths = @("$env:Temp", "$env:AppData\Local\Temp")
    
    foreach ($dllPath in $dllPaths) {
        if (Test-Path $dllPath) {
            $dllFiles = Get-ChildItem -Path $dllPath -File -Filter "*.dll" -Recurse -Depth 3 -ErrorAction SilentlyContinue
            
            foreach ($dllFile in $dllFiles) {
                $script:TotalFilesScanned++
                $script:CurrentFileBeingScanned = $dllFile.Name
                
                Update-ProgressDisplay
                
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
                    'Детали' = "DLL файл в Temp"
                    'Последнее изменение' = Format-LastWriteTime $dllFile.LastWriteTime
                    'Статус' = 'Найден'
                    'Риск' = 'Info'
                    'Вероятность' = 0
                    'Дней с изменения' = Get-DaysSinceLastWrite $dllFile.LastWriteTime
                    'Подпись' = $signatureInfo
                    'SHA256' = $hashInfo
                    'VirusTotal' = $vtInfo
                    'Автор' = '976hk'
                }
                
                $results += $result
                $injectResults += $result
            }
        }
    }
}

$script:CurrentStep = 5
$script:CurrentScanType = "Сканирование реестра"
Update-ProgressDisplay

if ($config.scan.check_registry) {
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
}

$script:CurrentStep = 6
$script:CurrentScanType = "Сканирование служб"
Update-ProgressDisplay

if ($config.scan.check_services) {
    Get-Service -ErrorAction SilentlyContinue | Where-Object {
        $_.Name -ne 'RpcLocator'
    } | ForEach-Object {
        $serviceName = $_.Name
        $displayName = $_.DisplayName
        
        $detection = Get-RiskLevel -InputString "$displayName $serviceName"
        
        if ($serviceName -in @('Appinfo','Sysmain','Pcasvc','DPS')) {
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
            $serviceResults += $result
        }
    }
}

$script:CurrentStep = 7
$script:CurrentScanType = "Сканирование сети"
Update-ProgressDisplay

if ($config.scan.check_network) {
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
}

$script:CurrentStep = 8
$script:CurrentScanType = "Сканирование задач"
Update-ProgressDisplay

if ($config.scan.check_scheduled_tasks) {
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
}

$script:CurrentStep = 9
$script:CurrentScanType = "Сканирование хостов"
Update-ProgressDisplay

if ($config.scan.check_hosts) {
    $hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"
    if (Test-Path $hostsPath) {
        $hostsContent = Get-Content $hostsPath -ErrorAction SilentlyContinue
        $suspiciousHosts = $hostsContent | Where-Object {
            $_ -match [regex]::Escape($config.detection.cheat_patterns[0]) -and $_ -notmatch '^\s*#'
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
}

$script:CurrentStep = 12
$script:CurrentScanType = "Сканирование завершено"
$script:CurrentFileBeingScanned = ""
Update-ProgressDisplay
Write-Host ""

$fileResults = $results | Where-Object { $_.Тип -notin @('Процесс', 'Служба', 'DLL Инжект') }

$criticalResults = $fileResults | Where-Object { 
    $_.Риск -eq 'Critical' -and $_.'Дней с изменения' -le $config.scan.days_recent 
} | Sort-Object -Property 'Дней с изменения', 'Вероятность' -Descending

$highResults = $fileResults | Where-Object { 
    $_.Риск -eq 'High' -and $_.'Дней с изменения' -le $config.scan.days_recent 
} | Sort-Object -Property 'Дней с изменения', 'Вероятность' -Descending

$suspiciousResults = $fileResults | Where-Object { 
    $_.Риск -eq 'Suspicious' -and $_.'Дней с изменения' -le $config.scan.days_recent 
} | Sort-Object -Property 'Дней с изменения', 'Вероятность' -Descending

$oldResults = $fileResults | Where-Object { 
    $_.'Дней с изменения' -gt $config.scan.days_recent -and $_.Риск -ne 'System' 
} | Sort-Object -Property 'Дней с изменения' -Descending

$systemResults = $serviceResults | Where-Object { 
    $_.Риск -eq 'System' 
}

Write-Host "=== Результаты сканирования ===" -ForegroundColor Cyan
Write-Host "Всего просканировано файлов: $($script:TotalFilesScanned)" -ForegroundColor White
Write-Host "Всего найдено: $($results.Count)" -ForegroundColor White
Write-Host "Свежие критические (≤$($config.scan.days_recent) дней): $($criticalResults.Count)" -ForegroundColor Red
Write-Host "Свежие высокого риска (≤$($config.scan.days_recent) дней): $($highResults.Count)" -ForegroundColor DarkRed
Write-Host "Свежие подозрительные (≤$($config.scan.days_recent) дней): $($suspiciousResults.Count)" -ForegroundColor Yellow
Write-Host "Старые (более $($config.scan.days_recent) дней): $($oldResults.Count)" -ForegroundColor Gray
Write-Host "Системных служб: $($systemResults.Count)" -ForegroundColor DarkGray
Write-Host "Запущенных процессов: $($processResults.Count)" -ForegroundColor Magenta
Write-Host "DLL инжектов: $($injectResults.Count)" -ForegroundColor DarkMagenta
Write-Host ""

if ($results.Count -gt 0) {
    Write-Host "`nВведите путь для сохранения (Enter для рабочего стола):" -ForegroundColor Yellow
    $OutputPath = Read-Host
    
    if ([string]::IsNullOrWhiteSpace($OutputPath)) {
        $OutputPath = [Environment]::ExpandEnvironmentVariables($config.output.output_path)
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
    $csvFile = Join-Path -Path $OutputPath -ChildPath "$($config.output.filename_prefix)_$timestamp.csv"
    $htmlFile = Join-Path -Path $OutputPath -ChildPath "$($config.output.filename_prefix)_$timestamp.html"
    $jsonFile = Join-Path -Path $OutputPath -ChildPath "$($config.output.filename_prefix)_$timestamp.json"
    
    try {
        if ($config.output.save_csv) {
            $results | Export-Csv -Path $csvFile -NoTypeInformation -Delimiter ";" -Force -Encoding UTF8
            Write-Host "✅ CSV: $csvFile" -ForegroundColor Green
        }
        
        if ($config.output.save_json) {
            $results | ConvertTo-Json -Depth 10 | Out-File -FilePath $jsonFile -Encoding UTF8
            Write-Host "✅ JSON: $jsonFile" -ForegroundColor Green
        }
        
        if ($config.output.save_html) {
            $html = @"
<html>
<head>
<style>
body {
    background: #1a1a1a;
    color: #e0e0e0;
    font-family: 'Segoe UI', Arial, sans-serif;
    margin: 20px;
    font-size: 1.3em;
}
h1 {
    color: #00ff00;
    border-bottom: 2px solid #00ff00;
    padding-bottom: 10px;
    font-size: 2em;
}
.summary {
    background: #2d2d2d;
    padding: 20px;
    border-radius: 5px;
    margin: 20px 0;
    font-size: 1.2em;
}
.summary-row {
    display: flex;
    flex-wrap: wrap;
    gap: 25px;
    margin-bottom: 15px;
}
.summary-item {
    color: #e0e0e0;
    font-weight: bold;
}
.collapsible {
    background: #2d2d2d;
    color: #e0e0e0;
    cursor: pointer;
    padding: 20px;
    width: 100%;
    border: none;
    text-align: left;
    outline: none;
    font-size: 1.3em;
    border-left: 4px solid #666;
    border-radius: 3px;
    margin: 8px 0;
    transition: 0.3s;
}
.collapsible:hover {
    background: #3d3d3d;
}
.collapsible.active {
    background: #3d3d3d;
}
.collapsible:after {
    content: '\25BC';
    float: right;
    font-size: 16px;
    color: #888;
}
.collapsible.active:after {
    content: '\25B2';
}
.collapsible-content {
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.3s ease-out;
    background: #1a1a1a;
    border-radius: 0 0 3px 3px;
}
.collapsible-content.show {
    max-height: 10000px;
}
.item {
    background: #2d2d2d;
    border-left: 4px solid #666;
    padding: 15px;
    margin: 8px 0;
    border-radius: 3px;
}
.item h3 {
    margin: 0 0 8px 0;
    color: #ffffff;
    font-size: 1.2em;
}
.path {
    color: #00ff00;
    font-family: 'Courier New', monospace;
    word-break: break-all;
    font-size: 1.1em;
}
.details {
    color: #cccccc;
    margin: 5px 0;
    font-size: 1em;
}
.reason {
    color: #ff9900;
    margin: 5px 0;
    font-style: italic;
    font-size: 1em;
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
.tech-info {
    background: #1a1a1a;
    padding: 8px 12px;
    margin: 5px 0;
    border-radius: 3px;
    font-size: 1em;
    color: #888;
}
.signed {
    color: #00ff00;
}
.unsigned {
    color: #ff0000;
}
.service-running {
    border-left: 4px solid #00ff00;
    background: #1a2a1a;
}
.service-stopped {
    border-left: 4px solid #ff0000;
    background: #2a1a1a;
}
.process-item {
    border-left: 4px solid #cc66ff;
    background: #1a0a2a;
}
.inject-item {
    border-left: 4px solid #ff00ff;
    background: #1a002a;
}
.critical-item {
    border-left: 4px solid #ff0000;
    background: #2a0a0a;
}
.high-item {
    border-left: 4px solid #ff6600;
    background: #2a1a0a;
}
.suspicious-item {
    border-left: 4px solid #ffff00;
    background: #2a2a0a;
}
.old-item {
    border-left: 4px solid #888888;
    background: #1a1a1a;
}
</style>
<script>
function toggleCollapsible(element) {
    element.classList.toggle('active');
    var content = element.nextElementSibling;
    if (content.style.maxHeight && content.style.maxHeight !== '0px') {
        content.style.maxHeight = '0px';
        content.classList.remove('show');
    } else {
        content.style.maxHeight = content.scrollHeight + 'px';
        content.classList.add('show');
    }
}
</script>
</head>
<body>
<h1>🐼 Minecraft Cheat Detector Report</h1>
<p>Автор: 976hk | Дата сканирования: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</p>
<div class='summary'>
    <div class='summary-row'>
        <span class='summary-item' style='color: #666666;'>⚙️ Службы: $($serviceResults.Count)</span>
        <span class='summary-item' style='color: #cc66ff;'>🚀 Процессы: $($processResults.Count)</span>
        <span class='summary-item' style='color: #ff00ff;'>💉 Инжекты: $($injectResults.Count)</span>
        <span class='summary-item' style='color: #ffffff;'>📊 Всего просканировано: $($script:TotalFilesScanned)</span>
    </div>
    <div class='summary-row'>
        <span class='summary-item' style='color: #ff0000;'>🔴 Свежие критические: $($criticalResults.Count)</span>
        <span class='summary-item' style='color: #ff6600;'>🟠 Высокого риска: $($highResults.Count)</span>
        <span class='summary-item' style='color: #ffff00;'>🟡 Подозрительные: $($suspiciousResults.Count)</span>
        <span class='summary-item' style='color: #888888;'>⚪ Старые: $($oldResults.Count)</span>
    </div>
</div>
"@
            
            if ($serviceResults.Count -gt 0) {
                $runningCount = ($serviceResults | Where-Object { $_.Статус -eq 'Running' }).Count
                $stoppedCount = ($serviceResults | Where-Object { $_.Статус -ne 'Running' }).Count
                
                $html += @"
<button class="collapsible" onclick="toggleCollapsible(this)">⚙️ Службы ($($serviceResults.Count)) — Запущено: $runningCount, Остановлено: $stoppedCount</button>
<div class="collapsible-content">
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
<p class='path'>$($item.Путь)</p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Состояние: <strong>$statusText</strong></p>
</div>
"@
                }
                
                $html += "</div>"
            }
            
            if ($injectResults.Count -gt 0) {
                $html += @"
<button class="collapsible" onclick="toggleCollapsible(this)">💉 DLL Инжекты ($($injectResults.Count))</button>
<div class="collapsible-content">
"@
                
                foreach ($item in $injectResults) {
                    $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                    
                    $html += @"
<div class='item inject-item'>
<h3>$($item.Имя)</h3>
<p class='path'>$($item.Путь)</p>
<p class='details'>Изменен: $($item.'Последнее изменение')</p>
<div class='tech-info'>
    Подпись: <span class='$signatureClass'>$($item.Подпись)</span> | SHA256: $($item.SHA256) | VirusTotal: $($item.VirusTotal)
</div>
</div>
"@
                }
                
                $html += "</div>"
            }
            
            if ($criticalResults.Count -gt 0) {
                $html += @"
<button class="collapsible" onclick="toggleCollapsible(this)">🔴 Свежие критические находки ($($criticalResults.Count))</button>
<div class="collapsible-content">
"@
                
                foreach ($item in $criticalResults) {
                    $probabilityClass = if ($item.Вероятность -ge 90) { 'probability-high' } elseif ($item.Вероятность -ge 70) { 'probability-medium' } else { 'probability-low' }
                    $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                    
                    $html += @"
<div class='item critical-item'>
<h3>$($item.Имя)</h3>
<p class='path'>$($item.Путь)</p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Вероятность: <span class='$probabilityClass'>$($item.Вероятность)%</span> | Изменен: $($item.'Последнее изменение')</p>
<div class='tech-info'>
    Подпись: <span class='$signatureClass'>$($item.Подпись)</span> | SHA256: $($item.SHA256) | VirusTotal: $($item.VirusTotal)
</div>
</div>
"@
                }
                
                $html += "</div>"
            }
            
            if ($highResults.Count -gt 0) {
                $html += @"
<button class="collapsible" onclick="toggleCollapsible(this)">🟠 Свежие находки высокого риска ($($highResults.Count))</button>
<div class="collapsible-content">
"@
                
                foreach ($item in $highResults) {
                    $probabilityClass = if ($item.Вероятность -ge 90) { 'probability-high' } elseif ($item.Вероятность -ge 70) { 'probability-medium' } else { 'probability-low' }
                    $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                    
                    $html += @"
<div class='item high-item'>
<h3>$($item.Имя)</h3>
<p class='path'>$($item.Путь)</p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Вероятность: <span class='$probabilityClass'>$($item.Вероятность)%</span> | Изменен: $($item.'Последнее изменение')</p>
<div class='tech-info'>
    Подпись: <span class='$signatureClass'>$($item.Подпись)</span> | SHA256: $($item.SHA256) | VirusTotal: $($item.VirusTotal)
</div>
</div>
"@
                }
                
                $html += "</div>"
            }
            
            if ($suspiciousResults.Count -gt 0) {
                $html += @"
<button class="collapsible" onclick="toggleCollapsible(this)">🟡 Свежие подозрительные находки ($($suspiciousResults.Count))</button>
<div class="collapsible-content">
"@
                
                foreach ($item in $suspiciousResults) {
                    $probabilityClass = if ($item.Вероятность -ge 90) { 'probability-high' } elseif ($item.Вероятность -ge 70) { 'probability-medium' } else { 'probability-low' }
                    $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                    
                    $html += @"
<div class='item suspicious-item'>
<h3>$($item.Имя)</h3>
<p class='path'>$($item.Путь)</p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Вероятность: <span class='$probabilityClass'>$($item.Вероятность)%</span> | Изменен: $($item.'Последнее изменение')</p>
<div class='tech-info'>
    Подпись: <span class='$signatureClass'>$($item.Подпись)</span> | SHA256: $($item.SHA256) | VirusTotal: $($item.VirusTotal)
</div>
</div>
"@
                }
                
                $html += "</div>"
            }
            
            if ($oldResults.Count -gt 0) {
                $html += @"
<button class="collapsible" onclick="toggleCollapsible(this)">⚪ Старые находки ($($oldResults.Count))</button>
<div class="collapsible-content">
"@
                
                foreach ($item in $oldResults) {
                    $probabilityClass = if ($item.Вероятность -ge 90) { 'probability-high' } elseif ($item.Вероятность -ge 70) { 'probability-medium' } elseif ($item.Вероятность -ge 40) { 'probability-low' } else { 'probability-none' }
                    $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                    
                    $html += @"
<div class='item old-item'>
<h3>$($item.Имя)</h3>
<p class='path'>$($item.Путь)</p>
<p class='reason'>$($item.Детали)</p>
<p class='details'>Вероятность: <span class='$probabilityClass'>$($item.Вероятность)%</span> | Изменен: $($item.'Последнее изменение')</p>
<div class='tech-info'>
    Подпись: <span class='$signatureClass'>$($item.Подпись)</span> | SHA256: $($item.SHA256) | VirusTotal: $($item.VirusTotal)
</div>
</div>
"@
                }
                
                $html += "</div>"
            }
            
            if ($processResults.Count -gt 0) {
                $html += @"
<button class="collapsible" onclick="toggleCollapsible(this)">🚀 Запущенные процессы ($($processResults.Count))</button>
<div class="collapsible-content">
"@
                
                foreach ($item in $processResults) {
                    $signatureClass = if ($item.Подпись -eq 'Подписано') { 'signed' } else { 'unsigned' }
                    
                    $html += @"
<div class='item process-item'>
<h3>$($item.Имя) (PID: $($item.PID))</h3>
<p class='path'>$($item.Путь)</p>
<p class='details'>$($item.Детали) | Статус: $($item.Статус)</p>
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
            
            if ($config.output.open_html_after_scan -and $htmlFile -and (Test-Path $htmlFile)) {
                Start-Process $htmlFile
            }
        }
        
    } catch {
        Write-Host "❌ Ошибка при сохранении: $($_.Exception.Message)" -ForegroundColor Red
        Write-Log "Ошибка при сохранении результатов: $($_.Exception.Message)" -Level 'ERROR'
    }
} else {
    Write-Host "✅ Читы и инжекты не обнаружены." -ForegroundColor Green
}

if ($script:VirusTotalCache.Count -gt 0) {
    try {
        $script:VirusTotalCache | ConvertTo-Json -Depth 10 | Out-File -FilePath $config.virustotal.cache_file -Encoding UTF8
    } catch {
        Write-Log "Ошибка сохранения кэша VirusTotal" -Level 'WARNING'
    }
}

Write-Log "Сканирование завершено. Всего найдено: $($results.Count)" -Level 'INFO'

Write-Host "`n════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host "  Сканирование завершено" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
