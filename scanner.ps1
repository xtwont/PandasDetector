<#
.SYNOPSIS
    Minecraft Cheat Detector v4.0
.DESCRIPTION
    Сканер читов + поисковик по логам лаунчеров.
.PARAMETER ConfigPath
    Путь к JSON-конфигу.
.PARAMETER SkipVirusTotal
    Не обращаться к VirusTotal API.
.PARAMETER SkipModrinth
    Не проверять моды через Modrinth API.
.PARAMETER NoParallel
    Отключить параллельное сканирование.
.PARAMETER ThrottleLimit
    Максимум параллельных задач.
.PARAMETER Mode
    scan или search. Если не указан — интерактивный выбор.
.PARAMETER Query
    Строка для поиска (для Mode=search).
.NOTES
    Автор: 976hk
    Аватар: xtwont
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$ConfigPath = "cheat_detector_config.json",
    [switch]$SkipVirusTotal,
    [switch]$SkipModrinth,
    [switch]$NoParallel,
    [int]$ThrottleLimit = 10,
    [ValidateSet('scan','search','')]
    [string]$Mode = '',
    [string]$Query = ''
)

$ErrorActionPreference = 'SilentlyContinue'

$LegitMods = @(
    'sodium','lithium','phosphor','rubidium','embeddium','iris','oculus',
    'optifine','shaders','canary','ferritecore','memoryleakfix','modernfix',
    'immediatelyfast','entityculling','betterfpsdist','starlight','krypton',
    'dynamic-fps','fps-reducer','fastanim','no-telemetry','moreculling',
    'cull-less-leaves','cullleaves','fastload','fastboot','smoothboot',
    'lazydfu','dashloader','ferrite-core','chlorine','hydrogen','helium',
    'magnesium','radium','exordium','enhancedblockentities',
    'ebe','particle-fix','particlefix','fadeless','nocull','no-cull',
    'fastquit','fastip','fastseed','fastsuite','fastbench','fastworkbench',
    'fastfurnace','fastbenchmark','clumps','surfminecraft','smoothswapping',
    'notenoughanimations','not-enough-animations','eating-animation',
    'animatica','cem','entity-texture-features','etf','entity-model-features',
    'emf','fresh-animations','qualitysounds','sound-physics-remastered',
    'presence-footsteps','auditory','ambientsounds','extrasounds','moresounds',
    'mob-sounds','dynamicsounds','dripsounds','soundreloader',
    'cloth-config','clothconfig','architectury','architectury-api',
    'fabric-api','fabricapi','fabric-','forge','neoforge','fabric-loader','fabricloader',
    'quilt','quiltloader','mixin','sponge-mixin','spongemixin','mixinextras',
    'mixin-extras','asm','asm-commons','asm-tree','asm-analysis','asm-util',
    'asmcommons','asmtree','log4j','log4j-api','log4j-core',
    'log4j-slf4j','slf4j','slf4j-api','gson','guava','failureaccess','netty',
    'netty-all','netty-buffer','netty-codec','netty-common','netty-handler',
    'netty-resolver','netty-transport','lwjgl','lwjgl-glfw','lwjgl-jemalloc',
    'lwjgl-openal','lwjgl-opengl','lwjgl-stb','lwjgl-tinyfd','lwjgl-freetype',
    'lwjgl-vma','lwjgl-vulkan','joml','fastutil','jna','jna-platform','oshi',
    'oshi-core','icu4j','commons-codec','commons-io','commons-logging',
    'commons-compress','commons-lang3','httpclient','httpcore','jackson',
    'jackson-core','jackson-databind','jackson-annotations','authlib',
    'brigadier','datafixerupper','logging','patchy','jtracy','javabridge',
    'text2speech','jorbis','jopt-simple','antlr4-runtime','accessors-smart',
    'json-smart','maven-artifact','mergetool','forgespi','fmlcore','fmlloader',
    'fmlearlydisplay','javafmllanguage','lowcodelanguage','mclanguage',
    'bootstraplauncher','modlauncher','securejarhandler','accesstransformers',
    'eventbus','coremods','unsafe','JarJarFileSystems','JarJarMetadata',
    'JarJarSelector','typetools','lz4-java','nashorn-core','jline-reader',
    'jline-terminal','jspecify','jcip-annotations','content-type','lang-tag',
    'nimbus-jose-jwt','oauth2-oidc-sdk','msal4j','azure-json','night-config',
    'core-3','toml-3','jbr','jcef','cef','chromium',
    'annotations','checker-qual','error-prone','j2objc','jsr305','animal-sniffer',
    'listenablefuture','failure-access','proto-google-common-protos',
    'grpc','grpc-api','grpc-core','grpc-netty','grpc-protobuf','grpc-stub',
    'opencensus','guava-gwt','netty-tcnative','bouncycastle','bcprov','bcpkix',
    'bcutil','eddsa','jose4j','jwt','nimbus','jakarta','javax','activation',
    'jaxb','istack','stax','woodstox','woodstox-core','aalto','xstream',
    'xmlpull','kxml2','maven','plexus','wagon','aether','sisu',
    'commons-cli','commons-collections','commons-collections4','commons-math3',
    'commons-net','commons-text','commons-validator','commons-exec','commons-daemon',
    'commons-beanutils','commons-configuration','commons-dbcp','commons-dbutils',
    'commons-fileupload','commons-jexl','commons-pool','commons-pool2',
    'commons-vfs','commons-chain','commons-digester','commons-discovery',
    'commons-el','commons-email','commons-i18n','commons-jci','commons-jcs',
    'commons-jelly','commons-jexl3','commons-launcher','commons-logging-api',
    'commons-modeler','commons-naming','commons-ognl','commons-scxml',
    'commons-transaction','commons-upload','commonnetworking','com_twelvemonkeys',
    'xaerominimap','xaeroworldmap','xaerolib','journeymap','minimap',
    'coordinates','coordfinder','whereami','compass','navigator',
    'jei','rei','emi','jade','wthit','hwyla','the-one-probe',
    'justenoughresources','justenoughbreeding','jep','jech','roughlyenoughitems',
    'roughly-enough-items','emi-loot','emi-enchanting','emi-trades','emi-ores',
    'emiachievements','jei-integration','jei-integrations',
    'geckolib','citadel','curios','patchouli','placebo','balm','bookshelf',
    'cupboard','blueprint','clayworks','moonlight','iceberg','prism-lib',
    'puzzleslib','knightlib','valhelsia-core','valhelsiacore','kubejs',
    'rhino','insanelib','lionfishapi','majrusz-library','player-animation-lib',
    'playeranimator','player-animator','structure-gel','terrablender',
    'yungsapi','caelus','alexsdelight','mantle','tinkers','auudio','konkrete',
    'melody','yet-another-config-lib','yacl','rrls','mossylib','mru',
    'arclight','probe','probejs','almostunified','configured',
    'controlling','searchables','betteradvancements','betterthirdperson',
    'drippy','drippyloadingscreen','melody-forge','konkrete_forge','melody_forge',
    'fancymenu','forge-config-api-port','config-api-port','forgeconfigapiport',
    'catalogue','defaultoptions','modmenu','mod-menu','better-modlist',
    'bettermodlist','catalogue-forge',
    'worldedit','worldguard','replaymod','replay','voicechat','plasmovoice',
    'simple-voice-chat','appleskin','betterf3','bhmenu','inventoryhud',
    'inventory-particles','inventoryparticles','pickupnotifier','comforts',
    'carryon','constructionwand','elevatorid','framedblocks','sophisticatedbackpacks',
    'sophisticatedcore','storagedrawers','toms-storage','toms_storage','lootr',
    'trashcans','transmog','woodworks','quark','zeta','autoreglib',
    'darkerdepths','ecologics','combatroll','corpse',
    'craterlib','ctov','choice-theorems','letmedespawn','leavesbegone',
    'fastpaintings','fastasyncworldsave','simple-rpc','chunky','chunky-pregenerator',
    'spark','observable','lagremover','lag-remover',
    'clearlag','clearlagg','laggoggles','lag-goggles','tickprofiler',
    'tick-profiler','visualvm','mat','eclipse-mat',
    'heap-dump','heapdump','sampler','jfr','flight-recorder',
    'jcmd','jconsole','jvisualvm','jmc','mission-control',
    'alexsmobs','aquamirae','aether','deep-aether','deeperdarker','aether-redux',
    'aether-lost-content','ars-nouveau','ars-additions','ars-elemental',
    'ars_elemental','apotheosis','apothic-curios','apotheotic-additions','aquaculture','atmospheric',
    'blue-skies','bygonenether','caverns-and-chasms','celestisynth',
    'collection-of-singiro','connectivity','crafttweaker','delightful',
    'dungeons-and-taverns','dungeons-arise','dungeons-arise-seven-seas',
    'dungeons_arise','dungeonsarise','dungeons-enhanced','dungeons_enhanced','dungeons-plus',
    'easy-villagers','eccentrictome','doespotatotick','farmersrespite',
    'endless-biomes','endrem','enemyexpansion','enigmatic-legacy','enigmatic-addons',
    'explorify','explorers-compass','fantasyfurniture','farmers-delight',
    'farmers-respite','forbidden-arcanus','galosphere','gateways-to-eternity',
    'gateways_to_eternity','goblintraders','hexerei','humancompanions','human-companions','infernal-mobs','infernalmobs','iron-chest',
    'ironchest','iron-furnaces','ironfurnaces','irons-spellbooks','item-production-lib','item-stages','iterpg',
    'knightquest','legendary-tooltips','letsdo-bakery','letsdo-vinery',
    'l-enders-cataclysm','max-health-fix','mcsa','meetyourfight','memory-settings',
    'memorysettings','minecolonies','more-villagers','mowzies-mobs','mowziesmobs',
    'multipiston','mutant-monsters','lootintegrations',
    'mythic-mounts','necronomicon','nethers-delight','nethersdelight','nerb','night-config-fixes',
    'oh-the-biomes-youll-go','origins','origins-classes','origins-accessibilities',
    'passive-skill-tree','progressive-bosses','progressivebosses','raided','recipe-essentials','recipeessentials',
    'redirector','refurbished-furniture','relics','repurposed-structures',
    'rings-of-ascension','rings_of_ascension','savage-and-ravage','servercore','simplyswords',
    'smallships','sons-of-sins','stalwart-dungeons','storage-drawers','structory',
    'structory-towers','structure-essentials','structureessentials','structurize','stylecolonies',
    'supplementaries','takes-a-pillage','terrablender','terralith','toms-storage',
    'towns-and-towers','towntalk','toomanyglyphs','twigs','twilightforest',
    'undead-unleashed','unusual-end','upgraded-netherite','upgraded-netherite-items',
    'upgradednetherite','upgradednetherite_items','upgradednetherite-ultimate','upgradednetherite_ultimate','waystones','whisperwoods','yungs-api',
    'yungs-better-dungeons','yungs-better-strongholds','yungs-better-mineshafts',
    'yungs-better-nether-fortresses','yungs-better-desert-temples',
    'yungs-better-jungle-temples','yungs-better-ocean-monuments',
    'yungs-better-end-island','yungs-better-witch-huts','yungs-better-beacons',
    'better-end-island','better-nether-fortresses','better-ocean-monuments',
    'better-desert-temples','better-jungle-temples','better-strongholds',
    'better-mineshafts','better-dungeons','better-witch-huts','better-beacons',
    'brutalbosses','solapplepie','cisco_mod','ciscounbound','xtwontarmor','tl_skin_cape',
    'iceandfire','botania','thaumcraft','bloodmagic','astralsorcery',
    'appliedenergistics2','ae2','refinedstorage','mekanism','thermal','thermalexpansion',
    'thermalfoundation','thermal-dynamics','industrialforegoing',
    'industrial-foregoing','immersiveengineering','immersive-engineering','create',
    'createaddition','createmetallurgy','createenchantmentindustry','createminecraft',
    'farmersdelight','croptopia','pamhc2crops','pamhc2food','pamhc2trees',
    'pamhc2foodextended','pams-harvestcraft','harvestcraft','cookingforblockheads',
    'cooking-for-blockheads','spiceoflife','spice-of-life','diet','solcarrot',
    'sol-carrot','nutrition','nutritionalbalance','apple-skin',
    'mobends','mo-bends','betteranimalsplus','better-animals-plus',
    'animania','creaturecomfort','creature-comfort','exoticbirds',
    'exotic-birds','untamedwilds','untamed-wilds','alexs-mobs',
    'mowzies-mobs','twilight-forest','the-twilight-forest','the-aether',
    'aether-legacy','deeper-darker','darker-depths','the-undergarden',
    'rats','rats-mod','mysticalagriculture','mystical-agriculture',
    'mysticalagradditions','mystical-customization','mystical-world',
    'productivebees','productive-bees','forestry','gendustry',
    'careerbees','career-bees','extrabees','extra-bees',
    'magicbees','magic-bees','binnie','binnies-mods','binnie-mods',
    'extra-trees','extratrees','extra-utilities','extrautilities',
    'extrautils2','extra-utils-2','openblocks','open-blocks','openmods',
    'openmodslib','open-modslib','opencomputers','open-computers',
    'computercraft','computer-craft','cc-tweaked','cctweaked',
    'oc2r','opencomputers2','open-computers-2',
    'lunar','badlion','feather','labymod','5zig','cosmicclient','cosmic-client',
    'hyperium','pvplounge','pvp-lounge','tlauncher','multimc',
    'prism','polymc','gdlauncher','atlauncher','technic','voidlauncher',
    'curseforge','modrinth','prismlauncher','prism-launcher',
    'multimc5','poly-mc','techniclauncher','technic-launcher',
    'ftb','feed-the-beast','ftb-app','ftbapp','curseforge-app','overwolf',
    'guilded','client','client-slim','client-srg','client-extra','client-intermediary',
    'server','server-slim','server-srg','server-extra','server-intermediary',
    'forge-client','forge-universal','fabric-loader','quilt-loader',
    'neoforge-client','neoforge-universal','-fabric-','-forge-','-quilt-',
    'voicechat','rnnoise','simplevoicechat'
)

$SuspiciousMods = @{
    'inventory_automation' = @(
        'inventoryprofilesnext','inventoryprofiles','invtweaks','invmove',
        'inventorysorter','cheststealer','autosteal','autodrop','autoreplenish',
        'autotool','autoswap','offhand','offhandcrash','inventory-tweaks',
        'inventory-tweaks-reforged','invtweaks-reforged','itemscroller',
        'item-scroller','mouse-tweaks','mousetweaks','inventoryessentials',
        'inventory-essentials','inventorymanager','inventory-manager',
        'autotoolbox','quickstack','quick-stack','quicksort','quick-sort',
        'stacksizes','stacksizeprovider'
    )
    'combat_automation' = @(
        'autototem','auto-totem','autototempro','spmautototem','purpir-autototem',
        'fast-autototem','shadoweds-legit-smart-auto-totem','autotriggerbot',
        'triggerbot','killaura','aimbot','autoclicker','auto-clicker','criticals',
        'autocrystal','crystalaura','bedaura','anchoraura','surround','autotrap',
        'self-trap','autoweb','autoarmor','autopearl','autopot','autogap','autoeat',
        'autosoup','autocrit','auto-crit','autocrits','autoclick','auto-click',
        'auto-block','autoblock','autoshield','autoshieldui'
    )
    'movement_hacks' = @(
        'freecam','free-cam','noclip','no-clip','fly','flight','elytrafly',
        'elytraboost','boatfly','packetfly','vecfly','speed','bhop','bunnyhop',
        'strafe','phase','hclip','vclip','clip','teleport','clicktp','tp-mine',
        'tpmine','jesus','waterwalk','step','highjump','longjump','sprint',
        'noslow','noslowdown','antiafk','autosneak','autojump','autosprint',
        'autowalk','autofish','autofarm','autofishing','auto-walk','auto-jump',
        'auto-sprint','auto-sneak','auto-farm','auto-fish'
    )
    'visual_hacks' = @(
        'xray','x-ray','xray-ce','advanced-xray','xray-orevision',
        'rexrayandsupertools','wallhack','esp','tracers','nametags','chams',
        'storageesp','playeresp','mobesp','itemesp','chestesp',
        'fullbright','norender','antiblind','lightoverlay','holeesp','breakesp',
        'tunnelesp','free-camera','xray-mod','xraymod','xray-fabric','xray-forge',
        'xray-ultimate','xray-reforged','xraylite','xray-lite',
        'xray-basic','xray-advanced','xray-pro','xray-free',
        'xray-premium','xray-community','xray-legit','xray-hack'
    )
    'world_hacks' = @(
        'nuker','autobuild','scaffold','autobridge','fastplace','forceplace',
        'fastbreak','instamine','speedmine','autofish','autofarm','autobreed',
        'autoshear','autosmelt','autotill','veinminer','excavate','tunnel',
        'packetmine','spammer','antiaim','antipacketkick','antivanish','ghosthand',
        'reach','infreach','infinite-reach','nofall','antihunger','anticactus',
        'nofalldamage','nofalldmg','antifalldamage','antifall',
        'autominer','autobuilder','autofarmer','autofishing',
        'autobreak','autoplace','auto-place','auto-break',
        'auto-build','auto-bridge','auto-craft','autocraft','autocrafting'
    )
    'cheat_clients' = @(
        'meteor-client','meteorclient','meteor','wurst','wurst-client','impact',
        'future','konas','pyro','phobos','ares','kami','seppuku','rusherhack',
        'bleachhack','huzuni','sigma','vape','vape-lite','liquidbounce',
        'fdpclient','rise','tenacity','novoline','astolfo','exhibition',
        'dortware','moonx','jigsaw','forgehax','cheatutils','mmogs-cheat-menu',
        'deforceutils','monkeyclient','payload','fusion','fusion-plus',
        'meteor-addon','meteoraddon','meteor-addons','meteorrejects','meteorreject',
        'meteorist','meteorplus','meteorite','meteor-satellite','meteor-satellite-addon',
        'bleach-hack','impact-client','wurstclient',
        'sigma-client','sigmaclient','future-client','futureclient','konas-client',
        'konasclient','pyro-client','pyroclient','phobos-client','phobosclient',
        'ares-client','aresclient','kami-client','kamiclient','seppuku-client',
        'seppukuclient','rusherhack-client','rusherhackclient','wwe-client',
        'wweclient','novoline-client','novolineclient','astolfo-client',
        'astolfoclient','exhibition-client','exhibitionclient','dortware-client',
        'dortwareclient','moonx-client','moonxclient','jigsaw-client',
        'jigsawclient','forgehax-client','forgehaxclient','fdp-client',
        'liquidbounce-client','liquidbounceclient',
        'fdp-client-plus','vape-client','vapeclient','vape-v4','vapev4',
        'vapelite','vape-v2','vapev2','vape-v3','vapev3'
    )
    'utility_masquerading' = @(
        'cheatutils','deforceutils','monkeyclient','payload','wurst','meteor',
        'impact','future','konas','pyro','phobos','ares','bleachhack','huzuni',
        'sigma','vape','liquidbounce','fdpclient','rise','tenacity','novoline',
        'astolfo','exhibition','dortware','moonx','jigsaw','forgehax','rusherhack',
        'kami','seppuku','inventoryprofilesnext','inventoryprofiles','invtweaks',
        'inventorysorter','itemscroller','item-scroller','mousetweaks',
        'mouse-tweaks','autototem','auto-totem','autotriggerbot','autoclicker',
        'auto-clicker','killaura','aimbot','freecam','xray','x-ray','noclip',
        'nuker','scaffold','bhop','nofall','reach','wallhack','esp','tracers'
    )
}

$CheatCodePatterns = @{
    'KillAura'          = @('\bkillaura\b','\bkill_aura\b','\bKillAura\b','\baimbot\b')
    'AutoTotem'         = @('\bautototem\b','\bauto_totem\b','\bAutoTotem\b','\bautototempro\b')
    'TriggerBot'        = @('\btriggerbot\b','\bauto_triggerbot\b','\bAutoTriggerBot\b')
    'XRay'              = @('\bxray\b','\bx_ray\b','\bX-Ray\b','\bxray-ce\b','\badvanced-xray\b')
    'FreeCam'           = @('\bfreecam\b','\bfree_cam\b','\bFreeCamera\b','\bfree-camera\b')
    'Nuker'             = @('\bnuker\b','\bauto_break\b','\bautobreak\b','\bdestroy_blocks\b')
    'Scaffold'          = @('\bscaffold\b','\bautobridge\b','\bauto_bridge\b','\bblock_place\b')
    'Fly'               = @('\bflyhack\b','\bfly_hack\b','\bfly-hack\b','\belytrafly\b','\bboatfly\b','\bpacketfly\b')
    'Speed'             = @('\bbhop\b','\bbunnyhop\b','\bbunny_hop\b','\bspeedhack\b','\bspeed_hack\b')
    'NoFall'            = @('\bnofall\b','\bno_fall\b','\bantifall\b','\bantifalldamage\b')
    'AutoClicker'       = @('\bautoclicker\b','\bauto_clicker\b','\bautoclick\b','\bauto_click\b')
    'ChestStealer'      = @('\bcheststealer\b','\bchest_stealer\b','\bautosteal\b','\bauto_steal\b')
    'AntiAFK'           = @('\bantiafk\b','\banti_afk\b','\bauto_afk\b')
    'Blink'             = @('\bblink\b','\blag_switch\b','\blagswitch\b','\bpacket_flush\b')
    'Jesus'             = @('\bjesus\b','\bwater_walk\b','\bwaterwalk\b','\bwalk_water\b')
    'Phase'             = @('\bphase_hack\b','\bphasehack\b','\bvclip\b','\bhclip\b')
    'Reach'             = @('\breachhack\b','\breach_hack\b','\binfreach\b','\binfinite-reach\b')
    'WallHack'          = @('\bwallhack\b','\bwall_hack\b','\btracers\b','\bchams\b')
    'Velocity'          = @('\bantiknockback\b','\bantikb\b','\bvelocityhack\b','\bantivelocity\b')
    'Noclip'            = @('\bnoclip\b','\bno_clip\b','\bnoclipping\b')
    'InventoryProfiles' = @('\binventoryprofilesnext\b','\binventoryprofiles\b','\binvtweaks\b','\binvmove\b')
    'AutoArmor'         = @('\bautoarmor\b','\bauto_armor\b','\bautoequip\b','\bauto_equip\b')
    'AutoPot'           = @('\bautopot\b','\bauto_pot\b','\bautogap\b','\bauto_gap\b','\bautosoup\b')
    'AutoCrystal'       = @('\bautocrystal\b','\bauto_crystal\b','\bcrystalaura\b','\bcrystal_aura\b')
    'AntiHunger'        = @('\bantihunger\b','\banti_hunger\b','\bnohunger\b','\bno_hunger\b')
    'FullBright'        = @('\bfullbright\b','\bfull_bright\b','\bnofog\b','\bno_fog\b')
    'AutoBuild'         = @('\bautobuild\b','\bauto_build\b','\bautobridge\b','\bauto_bridge\b')
    'AutoFish'          = @('\bautofish\b','\bauto_fish\b','\bautofishing\b','\bauto_fishing\b')
    'AutoSmelt'         = @('\bautosmelt\b','\bauto_smelt\b')
    'VeinMiner'         = @('\bveinminer\b','\bvein_miner\b','\bveinmining\b','\bvein_mining\b')
    'InstaMine'         = @('\binstamine\b','\binsta_mine\b','\bspeedmine\b','\bspeed_mine\b')
    'AutoPlace'         = @('\bautoplace\b','\bauto_place\b','\bfastplace\b','\bfast_place\b')
    'AutoCraft'         = @('\bautocraft\b','\bauto_craft\b','\bautocrafting\b','\bauto_crafting\b')
    'AntiVoid'          = @('\bantivoid\b','\banti_void\b','\bvoidprotect\b','\bvoid_protect\b')
    'PacketFly'         = @('\bpacketfly\b','\bpacket_fly\b','\bpacket-fly\b')
    'NoSlowDown'        = @('\bnoslow\b','\bnoslowdown\b','\bno_slow\b','\bno_slowdown\b')
    'Sprint'            = @('\bautosprint\b','\bauto_sprint\b','\bsprint_hack\b','\bsprinthack\b')
    'Spammer'           = @('\bspammer\b','\bchatspam\b','\bchat_spam\b','\bautomessage\b','\bauto_message\b')
    'AntiAim'           = @('\bantiaim\b','\banti_aim\b','\bspinbot\b','\bspin_bot\b')
    'AutoReconnect'     = @('\bautoreconnect\b','\bauto_reconnect\b','\bautodisconnect\b')
    'FakeName'          = @('\bfakename\b','\bfake_name\b','\bfakelag\b','\bfake_lag\b')
    'SelfTrap'          = @('\bselftrap\b','\bself_trap\b','\bautotrap\b','\bauto_trap\b')
    'Burrow'            = @('\bburrow\b','\bburrower\b','\bautoburrow\b','\bauto_burrow\b')
    'AutoPearl'         = @('\bautopearl\b','\bauto_pearl\b','\bautothrow\b','\bauto_throw\b')
    'AutoWeb'           = @('\bautoweb\b','\bauto_web\b','\bautocobweb\b','\bauto_cobweb\b')
    'Surround'          = @('\bsurround\b','\bsurroundhack\b','\bsurround_hack\b')
}

$script:LegitRegex = [System.Collections.Generic.List[string]]::new()
foreach ($p in $LegitMods) { $script:LegitRegex.Add([regex]::Escape($p.ToLower())) }

$script:SuspiciousRegex = @{}
foreach ($category in $SuspiciousMods.Keys) {
    $script:SuspiciousRegex[$category] = [System.Collections.Generic.List[string]]::new()
    foreach ($p in $SuspiciousMods[$category]) {
        $script:SuspiciousRegex[$category].Add([regex]::Escape($p.ToLower()))
    }
}

$DefaultConfig = @{
    scan = @{
        paths = @(
            "%UserProfile%\Downloads",
            "%UserProfile%\Desktop",
            "%UserProfile%\Documents",
            "%Temp%",
            "%AppData%\Local\Temp"
        )
        minecraft_paths = @(
            "%AppData%\.minecraft\mods",
            "%AppData%\.minecraft\versions",
            "%AppData%\.minecraft\config",
            "%AppData%\.minecraft\libraries",
            "%AppData%\.minecraft\logs",
            "%AppData%\.minecraft\crash-reports"
        )
        launcher_log_paths = @(
            "%AppData%\.minecraft\logs",
            "%AppData%\.tlauncher\legacy\Minecraft\game\logs",
            "%AppData%\.tlauncher",
            "%AppData%\..\Local\Packages\Microsoft.4297127D64EC6_8wekyb3d8bbwe\LocalCache\Local\game\logs",
            "%AppData%\..\Local\Packages\Microsoft.4297127D64EC6_8wekyb3d8bbwe\LocalCache\Local\logs",
            "%AppData%\.lunarclient\logs",
            "%UserProfile%\.lunarclient\logs",
            "%AppData%\.lunarclient\offline\multiver\logs",
            "%AppData%\BadlionCraft\logs",
            "%AppData%\..\.minecraft\logs",
            "%AppData%\com.modrinth.theseus\profiles",
            "%AppData%\PrismLauncher\instances",
            "%AppData%\PrismLauncher\logs",
            "%AppData%\MultiMC\instances",
            "%AppData%\MultiMC\logs",
            "%AppData%\gdlauncher_carbon\data\instances",
            "%AppData%\gdlauncher_carbon\logs",
            "%AppData%\ATLauncher\instances",
            "%AppData%\ATLauncher\logs",
            "%AppData%\com.technicplatform.technic\logs",
            "%AppData%\.technic\logs",
            "%AppData%\CurseForge\logs",
            "%AppData%\Overwolf\Log",
            "%AppData%\feather\logs",
            "%AppData%\Feather\logs",
            "%UserProfile%\curseforge\minecraft\Install\logs",
            "%UserProfile%\curseforge\minecraft\Instances",
            "%UserProfile%\AppData\Roaming\.minecraft\logs"
        )
        max_depth_files = 3
        max_depth_minecraft = 5
        max_depth_logs = 4
        days_recent = 14
        days_medium = 30
        days_old = 90
        parallel_threads = 10
        check_processes = $true
        check_services = $true
        check_registry = $true
        check_network = $true
        check_dll = $true
        check_jar_content = $true
        check_modrinth = $true
        check_prefetch = $true
        check_amcache = $true
        check_bam = $true
        check_log_clearing = $true
        check_defender = $true
        check_hosts = $true
        check_configs = $true
        check_jvm_args = $true
        check_latest_log = $true
        check_options_txt = $true
        check_manifest = $true
        check_hs_err = $true
        check_screenshots = $true
        check_replays = $true
        check_crash_reports = $true
        check_stats = $true
        check_servers_dat = $true
        check_profiles = $true
        check_cyrillic_configs = $true
        prefetch_days = 30
        amcache_days = 30
        max_file_size_mb = 200
        min_file_size_kb = 1
        log_scan_days = 14
    }
    modrinth = @{
        enabled = $true
        check_mods = $true
        user_agent = "CheatDetector/4.0 (976hk)"
        cache_file = "modrinth_cache.json"
        cache_hours = 168
        max_retries = 3
        request_timeout = 8
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
    }
}

$config = $DefaultConfig
if (Test-Path $ConfigPath) {
    try {
        $userConfig = Get-Content $ConfigPath -Raw | ConvertFrom-Json -ErrorAction Stop
        foreach ($section in $userConfig.PSObject.Properties) {
            if ($config.ContainsKey($section.Name)) {
                foreach ($prop in $section.Value.PSObject.Properties) {
                    $config[$section.Name][$prop.Name] = $prop.Value
                }
            }
        }
        Write-Host "Конфигурация загружена: $ConfigPath" -ForegroundColor Green
    } catch {
        Write-Host "Ошибка загрузки конфига, используется дефолтный" -ForegroundColor Yellow
    }
} else {
    try {
        $DefaultConfig | ConvertTo-Json -Depth 10 | Out-File -FilePath $ConfigPath -Encoding UTF8
        Write-Host "Создан конфиг по умолчанию: $ConfigPath" -ForegroundColor Gray
    } catch {
        Write-Host "Не удалось создать конфиг" -ForegroundColor Yellow
    }
}

Add-Type -AssemblyName System.IO.Compression.FileSystem -ErrorAction SilentlyContinue
Add-Type -AssemblyName System.Web -ErrorAction SilentlyContinue

$PSVersion = $PSVersionTable.PSVersion.Major
$SupportsDepth = $PSVersion -ge 6

$script:TotalFilesScanned = 0
$script:FilesSkipped = 0
$script:FilesHashed = 0
$script:CurrentFileBeingScanned = ""
$script:CurrentScanType = ""
$script:CurrentStep = 0
$script:TotalSteps = 26
$script:FileMetaCache = @{}
$script:JarContentCache = @{}
$script:ModrinthBySha1 = @{}
$script:Results = [System.Collections.Generic.List[object]]::new()
$script:ProcessResults = [System.Collections.Generic.List[object]]::new()
$script:JavaProcessResults = [System.Collections.Generic.List[object]]::new()
$script:JvmArgResults = [System.Collections.Generic.List[object]]::new()
$script:InjectResults = [System.Collections.Generic.List[object]]::new()
$script:ServiceResults = [System.Collections.Generic.List[object]]::new()
$script:UnknownModResults = [System.Collections.Generic.List[object]]::new()
$script:VerifiedModResults = [System.Collections.Generic.List[object]]::new()
$script:SuspiciousModResults = [System.Collections.Generic.List[object]]::new()
$script:PrefetchResults = [System.Collections.Generic.List[object]]::new()
$script:AmcacheResults = [System.Collections.Generic.List[object]]::new()
$script:BamResults = [System.Collections.Generic.List[object]]::new()
$script:LogClearingResults = [System.Collections.Generic.List[object]]::new()
$script:DefenderResults = [System.Collections.Generic.List[object]]::new()
$script:HostsResults = [System.Collections.Generic.List[object]]::new()
$script:ConfigTraceResults = [System.Collections.Generic.List[object]]::new()
$script:LatestLogResults = [System.Collections.Generic.List[object]]::new()
$script:OptionsTxtResults = [System.Collections.Generic.List[object]]::new()
$script:ManifestResults = [System.Collections.Generic.List[object]]::new()
$script:HsErrResults = [System.Collections.Generic.List[object]]::new()
$script:ScreenshotResults = [System.Collections.Generic.List[object]]::new()
$script:ReplayResults = [System.Collections.Generic.List[object]]::new()
$script:CrashReportResults = [System.Collections.Generic.List[object]]::new()
$script:StatsResults = [System.Collections.Generic.List[object]]::new()
$script:ServersDatResults = [System.Collections.Generic.List[object]]::new()
$script:ProfilesResults = [System.Collections.Generic.List[object]]::new()
$script:CyrillicConfigResults = [System.Collections.Generic.List[object]]::new()
$script:LogSearchResults = [System.Collections.Generic.List[object]]::new()
$script:LogFile = $config.logging.log_file

$script:HashableExtensions = @('.jar','.exe','.dll','.msi','.bat','.cmd','.ps1','.vbs')
$script:MaxFileSize = $config.scan.max_file_size_mb * 1MB
$script:MinFileSize = $config.scan.min_file_size_kb * 1KB

$script:CriticalServices = @('EventLog','PcaSvc','AppInfo','SysMain','DeviceAssociationService')

$allowedExtensions = @(
    '.jar','.exe','.dll','.bat','.cmd','.ps1','.vbs','.msi','.zip','.rar','.7z',
    '.json','.cfg','.txt','.log','.dat','.properties','.yml','.yaml','.xml',
    '.class','.java','.py','.js','.lua','.toml','.nbt','.mcpr','.png','.gz'
)
$script:AllowedExtensions = $allowedExtensions

if (Test-Path $config.modrinth.cache_file) {
    try {
        $cacheRaw = Get-Content $config.modrinth.cache_file -Raw | ConvertFrom-Json -ErrorAction Stop
        $now = Get-Date
        $ttl = [double]$config.modrinth.cache_hours
        foreach ($prop in $cacheRaw.PSObject.Properties) {
            $entry = $prop.Value
            $cachedAt = $null
            try { $cachedAt = [DateTime]::Parse($entry.CachedAt) } catch {}
            if ($cachedAt -and ($now - $cachedAt).TotalHours -gt $ttl) { continue }
            $script:ModrinthBySha1[$prop.Name] = @{
                Verified  = [bool]$entry.Verified
                ModName   = $entry.ModName
                ProjectId = $entry.ProjectId
                Reason    = $entry.Reason
                Sha1      = $prop.Name
                CachedAt  = $entry.CachedAt
            }
        }
        Write-Host "Кэш Modrinth загружен: $($script:ModrinthBySha1.Count) записей" -ForegroundColor Gray
    } catch {}
}

$script:Whitelist = @{
    MinecraftLoaders = @(
        'fabric','fabricloader','fabric-loader','fabric_loader','fabricmc',
        'fabric-api','fabric.mod','fabricmod','fabric-language-kotlin',
        'fabric-content-registries','fabric-resource-loader',
        'quilt','quiltloader','forge','neoforge','optifine',
        'fmlloader','fml_loader','fml-loader','fml.loader',
        'minecraftforge','minecraft_forge','forge-','forge_',
        'net.minecraftforge','net.minecraftforge.fml','net.fabricmc','net.fabric',
        'customskinloader','skinloader','customskin','processedmods','.fabric',
        'fabric-rendering','fabric-renderer','fabric-networking','fabric-screen',
        'fabric-screen-handler','fabric-transfer','fabric-object-builder',
        'fabric-block-view','fabric-model','fabric-texture','fabric-lifecycle',
        'fabric-registries','fabric-command','fabric-entity','fabric-item',
        'fabric-block','fabric-loot','fabric-recipe','fabric-resource-conditions',
        'fabric-data-generation','fabric-data-gen','fabric-datagen','fabric-biome',
        'fabric-dimension','fabric-world','fabric-chunk','fabric-particle',
        'fabric-sound','fabric-client','fabric-server','fabric-message',
        'fabric-packet','fabric-protocol','fabric-api-base','fabric-api-lookup',
        'fabric-api-impl','fabric-api-module','fabric-impl','fabric-mixin',
        'fabric-access','fabric-invoker'
    )
    AllowedMods = @(
        'sodium','lithium','phosphor','iris','sildurs','complementary','bsl',
        'seus','continuum','realistico','modernarch','faithful','vanillatweaks',
        'minimap','journeymap','xaeros','jei','rei','emi','wthit','jade','hwyla',
        'theoneprobe','ftb','curseforge','modrinth','multimc','prism','polymc',
        'gdlauncher','atlauncher','technic','voidlauncher','tlauncher',
        'voicechat','plasmovoice','simplevoicechat','rnnoise'
    )
    SystemProcesses = @(
        'system','idle','registry','smss','csrss','wininit','winlogon','services',
        'lsass','fontdrvhost','svchost','dllhost','wmiprvse','sihost','taskhostw',
        'conhost','explorer','dwm','shell','runtimebroker','searchindexer',
        'searchui','startmenuexperiencehost','textinputhost','applicationframehost',
        'shellexperiencehost','securityhealthservice','securityhealthsystray',
        'msmpeng','nissrv','defender','antimalware','mpcmdrun','audiodg',
        'spoolsv','taskmgr','cmd','powershell','pwsh','lsaiso','ngciso',
        'secure system','memory compression','mpdefendercore','mpdefendercoreservice',
        'wudfhost','dashost','sppsvc','wmiapsrv','wmiregistrar',
        'hkclipsvc','msedge','msedgewebview2','obs64','rvcontrolsvc',
        'rvrvpngui','service_update'
    )
    SystemPaths = @(
        '\windows\','\system32\','\syswow64\','\program files\','\programdata\',
        '\appdata\local\microsoft\','\appdata\roaming\microsoft\',
        '\windowsapps\','\microsoft\windows\','\common files\',
        '\appdata\local\faceit\','\program files (x86)\controlcenter\',
        '\program files (x86)\microsoft\edge\','\program files (x86)\microsoft\edgewebview\',
        '\program files (x86)\steam\','\program files (x86)\yandex\',
        '\program files (x86)\radmin vpn\','\appdata\local\programs\yandexmusic\'
    )
    TrustedVendors = @(
        'intel','nvidia','amd','realtek','steam','discord','yandex','microsoft',
        'mojang','oracle','openjdk','adoptium','microsoft corporation','google',
        'faceit','controlcenter','msi','asus','radmin','obs','overwolf'
    )
    SystemDlls = @(
        'kernel32','user32','gdi32','advapi32','shell32','ole32','oleaut32',
        'comctl32','comdlg32','ws2_32','wsock32','winmm','wininet','winhttp',
        'winspool','winscard','crypt32','cryptui','bcrypt','ncrypt','secur32',
        'schannel','msvcp','msvcr','msvcrt','vcruntime','ucrtbase','api-ms-win',
        'ext-ms-win','ntdll','rpcrt4','shlwapi','version','userenv','dwmapi',
        'd3d9','d3d10','d3d11','d3d12','dxgi','dinput8','xinput','dsound',
        'dmusic','opengl32','glu32','glew32','glfw3','vulkan-1','openal32',
        'opencl','cuda','cudart','nvapi','nvcuda','ati','amdxc','igfx','igd',
        'rtk','rtkhdaud','gameoverlayrenderer','overlay','obs','java','jvm',
        'jli','nio','zip','verify','attach','instrument','management',
        'libcrypto','libssl','libcurl','zlib','libpng','libjpeg','libtiff',
        'libwebp','libxml2','sqlite3','python','node','v8','electron','boost',
        'qt','wxwidgets','gtk','sdl','sfml','mediafoundation','mf','mfplat',
        'windows.ui','windowsapp','onnxruntime','tensorflow','pytorch','torch',
        'opencv','cv2','numpy','scipy','pandas','webview2','cef','libcef',
        'chrome_elf'
    )
}

$script:KnownLogKeywords = @(
    'meteor','wurst','impact','konas','pyro','phobos','ares','kami',
    'seppuku','rusherhack','bleachhack','huzuni','sigma','vape',
    'liquidbounce','fdpclient','novoline','astolfo','exhibition',
    'cheatutils','forgehax','killaura','aimbot','autototem','xray',
    'freecam','nuker','scaffold','bhop','antikb','triggerbot',
    'javaagent','agentlib','agentpath','-xbootclasspath','baritone',
    'future-client','futureclient','rise','tenacity','dortware','moonx','jigsaw'
)

function Write-Log {
    param([string]$Message, [string]$Level = 'INFO')
    if (-not $config.logging.enabled) { return }
    if ($Level -eq 'DEBUG' -and $config.logging.log_level -ne 'DEBUG') { return }
    $ts = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    try { Add-Content -Path $script:LogFile -Value "[$ts] [$Level] $Message" -Encoding UTF8 } catch {}
}

function Get-FileMeta {
    param([string]$FilePath)
    if ($script:FileMetaCache.ContainsKey($FilePath)) {
        return $script:FileMetaCache[$FilePath]
    }
    try {
        $fi = Get-Item -LiteralPath $FilePath -ErrorAction Stop
        $meta = @{
            Size     = $fi.Length
            Modified = $fi.LastWriteTimeUtc.Ticks
            Hash     = $null
            Sha1     = $null
        }
        $script:FileMetaCache[$FilePath] = $meta
        return $meta
    } catch { return $null }
}

function Get-FileHashCached {
    param([string]$FilePath, [ValidateSet('SHA1','SHA256')][string]$Algorithm = 'SHA256')
    $meta = Get-FileMeta -FilePath $FilePath
    if (-not $meta) { return $null }
    if ($Algorithm -eq 'SHA1' -and $meta.Sha1) { return $meta.Sha1 }
    if ($Algorithm -eq 'SHA256' -and $meta.Hash) { return $meta.Hash }
    try {
        $hash = (Get-FileHash -LiteralPath $FilePath -Algorithm $Algorithm -ErrorAction SilentlyContinue).Hash
        if ($hash) {
            if ($Algorithm -eq 'SHA1') { $meta.Sha1 = $hash } else { $meta.Hash = $hash }
            $script:FilesHashed++
        }
        return $hash
    } catch { return $null }
}

function Test-FileSignature {
    param([string]$FilePath)
    try {
        if (-not (Test-Path -LiteralPath $FilePath)) { return $null }
        $sig = Get-AuthenticodeSignature -LiteralPath $FilePath -ErrorAction SilentlyContinue
        if ($sig) { return $sig.Status -eq 'Valid' }
        return $null
    } catch { return $null }
}

function Test-Admin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $p  = New-Object Security.Principal.WindowsPrincipal($id)
    return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Format-LastWriteTime {
    param($LastWriteTime)
    if ($null -eq $LastWriteTime) { return "Неизвестно" }
    $diff = (Get-Date) - $LastWriteTime
    if ($diff.TotalMinutes -lt 1)  { return "только что" }
    if ($diff.TotalHours   -lt 1)  { return "$([math]::Floor($diff.TotalMinutes)) мин. назад" }
    if ($diff.TotalDays    -lt 1)  { return "$([math]::Floor($diff.TotalHours)) ч. назад" }
    if ($diff.TotalDays    -lt 30) { return "$([math]::Floor($diff.TotalDays)) дн. назад" }
    return "$([math]::Floor($diff.TotalDays / 30)) мес. назад"
}

function Format-DateShort {
    param($Date)
    if ($null -eq $Date) { return 'N/A' }
    return ([DateTime]$Date).ToString('dd.MM.yy HH:mm')
}

function Get-DaysSinceLastWrite {
    param($LastWriteTime)
    if ($null -eq $LastWriteTime) { return 999 }
    return [math]::Floor(((Get-Date) - $LastWriteTime).TotalDays)
}

function Get-DateColor {
    param([int]$Days)
    if ($Days -le $config.scan.days_recent) { return 'red' }
    if ($Days -le $config.scan.days_medium) { return 'orange' }
    if ($Days -le $config.scan.days_old)    { return 'yellow' }
    return 'gray'
}

function Get-DateNote {
    param([int]$Days)
    if ($Days -le $config.scan.days_recent) { return 'Свежий след — мог использоваться недавно' }
    if ($Days -le $config.scan.days_medium) { return 'Относительно свежий след' }
    if ($Days -le $config.scan.days_old)    { return 'Средней давности' }
    return 'Старый след — возможно, уже не используется'
}

function Test-ShouldScanFile {
    param($File)
    if ($File.Length -gt $script:MaxFileSize) { return $false }
    if ($File.Length -lt $script:MinFileSize) { return $false }
    if ($File.Extension.ToLower() -notin $script:AllowedExtensions) { return $false }
    return $true
}

function ConvertTo-NormalizedText {
    param([string]$Text)
    if ($null -eq $Text) { return '' }
    $t = $Text
    $t = $t -replace [char]0xFEFF, ''
    $t = $t -replace [char]0x00A0, ' '
    $t = $t -replace [char]0x202F, ' '
    $t = $t -replace [char]0x2007, ' '
    $t = $t -replace [char]0x2009, ' '
    $t = $t -replace [char]0x200A, ' '
    $t = $t -replace [char]0x200B, ''
    $t = $t -replace "`t", ' '
    $t = $t -replace '\s+', ' '
    return $t.Trim()
}

function ConvertTo-FuzzyTokens {
    param([string]$Text)
    $norm = ConvertTo-NormalizedText -Text $Text
    if ([string]::IsNullOrWhiteSpace($norm)) { return @() }
    $tokens = $norm.ToLower() -split '[^a-zа-я0-9_]+' | Where-Object { $_.Length -ge 3 }
    return @($tokens)
}

function Read-LogFileUtf8 {
    param([string]$Path)
    try {
        return [System.IO.File]::ReadAllLines($Path, [System.Text.Encoding]::UTF8)
    } catch {
        try { return Get-Content -LiteralPath $Path -ErrorAction SilentlyContinue -Encoding UTF8 }
        catch { return @() }
    }
}

function ConvertFrom-PrefetchFile {
    param([string]$FilePath)
    try {
        $bytes = [System.IO.File]::ReadAllBytes($FilePath)
        if ($bytes.Length -lt 200) { return $null }
        if (-not ($bytes[0] -eq 0x53 -and $bytes[1] -eq 0x43 -and $bytes[2] -eq 0x43 -and $bytes[3] -eq 0x41)) {
            return $null
        }
        $nameEnd = 16
        for ($i = 16; $i -lt 300; $i += 2) {
            if ($bytes[$i] -eq 0 -and $bytes[$i+1] -eq 0) { $nameEnd = $i; break }
        }
        $nameBytes = $bytes[16..($nameEnd-1)]
        $exeName = [System.Text.Encoding]::Unicode.GetString($nameBytes).TrimEnd([char]0)
        if ([string]::IsNullOrWhiteSpace($exeName)) { return $null }

        $lastRunTime = $null
        try {
            $filetime = [System.BitConverter]::ToInt64($bytes, 0x80)
            if ($filetime -gt 0) { $lastRunTime = [DateTime]::FromFileTime($filetime) }
        } catch {}

        return [PSCustomObject]@{
            ExeName  = $exeName
            LastRun  = $lastRunTime
            FilePath = $FilePath
        }
    } catch { return $null }
}

function Test-ModPath {
    param([string]$FilePath)
    if ([string]::IsNullOrWhiteSpace($FilePath)) { return $false }
    $lower = $FilePath.ToLower()
    if ($lower -match '\\libraries\\') { return $false }
    if ($lower -match '\\versions\\[^\\]+\\[^\\]+\.jar$') { return $false }
    if ($lower -match '\\versions\\[^\\]+\\\.fabric\\remappedjars\\') { return $false }
    if ($lower -match '\\versions\\[^\\]+\\mods\\') { return $true }
    if ($lower -match '\\versions\\[^\\]+\\\.fabric\\processedmods\\') { return $true }
    if ($lower -match '\\mods\\') { return $true }
    return $false
}

function Test-LegitMod {
    param([string]$FileName)
    if ([string]::IsNullOrWhiteSpace($FileName)) { return $false }
    $lower = $FileName.ToLower()
    foreach ($pat in $script:LegitRegex) {
        if ($lower -match $pat) { return $true }
    }
    return $false
}

function Test-SuspiciousMod {
    param([string]$FileName)
    if ([string]::IsNullOrWhiteSpace($FileName)) { return $null }
    $lower = $FileName.ToLower()
    foreach ($category in $script:SuspiciousRegex.Keys) {
        foreach ($pat in $script:SuspiciousRegex[$category]) {
            if ($lower -match $pat) {
                return @{ Category = $category; Pattern = $pat }
            }
        }
    }
    return $null
}

function Test-Whitelisted {
    param(
        [string]$InputString,
        [string]$FilePath = "",
        [ValidateSet('Any','Dll','Process','Path')]
        [string]$Mode = 'Any'
    )
    if ([string]::IsNullOrWhiteSpace($InputString)) { return $false }
    $lower = $InputString.ToLower()
    $lowerPath = if ($FilePath) { $FilePath.ToLower() } else { "" }

    foreach ($p in $script:Whitelist.MinecraftLoaders) {
        if ($lower.Contains($p)) { return $true }
    }
    foreach ($p in $script:Whitelist.AllowedMods) {
        if ($lower.Contains($p)) { return $true }
    }
    if ($lowerPath) {
        foreach ($p in $script:Whitelist.SystemPaths) {
            if ($lowerPath.Contains($p)) { return $true }
        }
    }
    if ($Mode -in @('Any','Process')) {
        foreach ($p in $script:Whitelist.SystemProcesses) {
            if ($lower -eq $p) { return $true }
        }
    }
    foreach ($p in $script:Whitelist.TrustedVendors) {
        if ($lower.Contains($p)) { return $true }
    }
    if ($Mode -in @('Any','Dll') -and $lower -match '\.dll') {
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($lower)
        foreach ($p in $script:Whitelist.SystemDlls) {
            if ($baseName -eq $p) { return $true }
        }
    }
    return $false
}

function Get-RiskLevel {
    param([string]$InputString, [string]$FilePath = "")
    if ([string]::IsNullOrWhiteSpace($InputString)) {
        return @{ Risk = 'Clean'; Reason = ''; Probability = 0 }
    }
    if (Test-Whitelisted -InputString $InputString -FilePath $FilePath) {
        return @{ Risk = 'Clean'; Reason = ''; Probability = 0 }
    }
    $lower = $InputString.ToLower()
    $found = [System.Collections.Generic.List[string]]::new()
    foreach ($p in $CheatCodePatterns.Keys) {
        foreach ($pat in $CheatCodePatterns[$p]) {
            if ($lower -match $pat) {
                if (-not $found.Contains($p)) { $found.Add($p) }
                break
            }
        }
    }
    if ($found.Count -eq 0) {
        return @{ Risk = 'Clean'; Reason = ''; Probability = 0 }
    }
    $prob = [math]::Min(98, 25 + ($found.Count * 18))
    $risk = 'Critical'
    if ($prob -lt 60) { $risk = 'High' }
    if ($prob -lt 40) { $risk = 'Suspicious' }
    return @{
        Risk = $risk
        Reason = "Возможное совпадение: $($found -join ', ')"
        Probability = $prob
    }
}

function Get-ModrinthBySha1 {
    param([string]$Sha1)
    if ($SkipModrinth) { return $null }
    if (-not $config.modrinth.enabled) { return $null }
    if (-not $config.modrinth.check_mods) { return $null }
    if ([string]::IsNullOrWhiteSpace($Sha1)) { return $null }
    if ($script:ModrinthBySha1.ContainsKey($Sha1)) {
        return $script:ModrinthBySha1[$Sha1]
    }
    $url = "https://api.modrinth.com/v2/version_file/$Sha1"
    $headers = @{ 'User-Agent' = $config.modrinth.user_agent }
    $maxRetries = [int]$config.modrinth.max_retries
    $timeout = [int]$config.modrinth.request_timeout
    for ($attempt = 1; $attempt -le $maxRetries; $attempt++) {
        try {
            $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get -TimeoutSec $timeout -ErrorAction Stop
            $result = @{
                Verified  = $true
                ModName   = if ($response.name) { $response.name } else { 'Unknown' }
                ProjectId = $response.project_id
                Reason    = "Modrinth: $($response.project_id)"
                Sha1      = $Sha1
                CachedAt  = (Get-Date).ToString('o')
            }
            $script:ModrinthBySha1[$Sha1] = $result
            return $result
        } catch {
            $code = $null
            try { $code = $_.Exception.Response.StatusCode.value__ } catch {}
            if ($code -eq 404) {
                $result = @{
                    Verified  = $false
                    ModName   = 'Unknown'
                    ProjectId = $null
                    Reason    = 'Не найден на Modrinth'
                    Sha1      = $Sha1
                    CachedAt  = (Get-Date).ToString('o')
                }
                $script:ModrinthBySha1[$Sha1] = $result
                return $result
            }
            if ($code -eq 429) {
                Start-Sleep -Seconds (2 * $attempt)
                continue
            }
            if ($attempt -eq $maxRetries) { return $null }
            Start-Sleep -Milliseconds 500
        }
    }
    return $null
}

function Save-ModrinthCache {
    try {
        $script:ModrinthBySha1 | ConvertTo-Json -Depth 5 | Out-File -FilePath $config.modrinth.cache_file -Encoding UTF8
    } catch {}
}

function Test-JarContent {
    param([string]$FilePath)
    if ($script:JarContentCache.ContainsKey($FilePath)) {
        return $script:JarContentCache[$FilePath]
    }
    try {
        if (-not (Test-Path -LiteralPath $FilePath)) { return @() }
        if ([System.IO.Path]::GetExtension($FilePath).ToLower() -ne '.jar') { return @() }
        $foundCheats = [System.Collections.Generic.List[string]]::new()
        $zip = [System.IO.Compression.ZipFile]::OpenRead($FilePath)
        try {
            $classEntries = $zip.Entries | Where-Object { $_.Name -match '\.class$' }
            $limit = 500
            $idx = 0
            foreach ($entry in $classEntries) {
                if ($idx -ge $limit) { break }
                $idx++
                try {
                    $stream = $entry.Open()
                    $buffer = New-Object System.IO.MemoryStream
                    $stream.CopyTo($buffer)
                    $stream.Close()
                    $bytes = $buffer.ToArray()
                    $buffer.Close()
                    $content = [System.Text.Encoding]::ASCII.GetString($bytes).ToLower()
                    foreach ($cheatName in $CheatCodePatterns.Keys) {
                        $patterns = $CheatCodePatterns[$cheatName]
                        $hits = 0
                        foreach ($pat in $patterns) {
                            if ($content -match $pat) { $hits++ }
                        }
                        if ($hits -ge 2) {
                            $msg = "Возможное совпадение: $cheatName"
                            if (-not $foundCheats.Contains($msg)) { $foundCheats.Add($msg) }
                        }
                    }
                } catch {}
            }
        } finally { $zip.Dispose() }
        $result = @($foundCheats)
        $script:JarContentCache[$FilePath] = $result
        return $result
    } catch { return @() }
}

function Test-JarManifest {
    param([string]$FilePath)
    try {
        if (-not (Test-Path -LiteralPath $FilePath)) { return $null }
        if ([System.IO.Path]::GetExtension($FilePath).ToLower() -ne '.jar') { return $null }
        $zip = [System.IO.Compression.ZipFile]::OpenRead($FilePath)
        try {
            $manifestEntry = $zip.Entries | Where-Object { $_.FullName -eq 'fabric.mod.json' -or $_.FullName -eq 'META-INF/mods.toml' -or $_.FullName -eq 'META-INF/neoforge.mods.toml' } | Select-Object -First 1
            if (-not $manifestEntry) { return $null }
            $stream = $manifestEntry.Open()
            $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::UTF8)
            $content = $reader.ReadToEnd()
            $reader.Close(); $stream.Close()
            return @{ Type = $manifestEntry.FullName; Content = $content }
        } finally { $zip.Dispose() }
    } catch { return $null }
}

function Get-LauncherLogFiles {
    param([int]$DaysLimit = 14)
    $result = [System.Collections.Generic.List[object]]::new()
    $cutoff = (Get-Date).AddDays(-$DaysLimit)
    $seen = @{}
    foreach ($rawPath in $config.scan.launcher_log_paths) {
        $path = [Environment]::ExpandEnvironmentVariables($rawPath)
        if ([string]::IsNullOrWhiteSpace($path)) { continue }
        if (-not (Test-Path -LiteralPath $path)) { continue }
        try {
            $item = Get-Item -LiteralPath $path -ErrorAction SilentlyContinue
            if ($item -and -not $item.PSIsContainer) {
                if ($item.LastWriteTime -ge $cutoff) {
                    $key = $item.FullName.ToLower()
                    if (-not $seen.ContainsKey($key)) {
                        $seen[$key] = $true
                        $result.Add($item)
                    }
                }
                continue
            }
            $files = Get-ChildItem -LiteralPath $path -File -Recurse -Include '*.log','*.txt','*.log.gz','latest.log','debug.log','*.log.1','*.log.2' -ErrorAction SilentlyContinue
            foreach ($f in $files) {
                if ($f.LastWriteTime -lt $cutoff) { continue }
                $key = $f.FullName.ToLower()
                if ($seen.ContainsKey($key)) { continue }
                $seen[$key] = $true
                $result.Add($f)
            }
        } catch {}
    }
    return $result
}

function Update-ProgressDisplay {
    $percent = [math]::Round(($script:CurrentStep / $script:TotalSteps) * 100)
    $barLen = 40
    $filled = [math]::Round($percent / 100 * $barLen)
    $bar = "[" + ("█" * $filled) + ("░" * ($barLen - $filled)) + "]"
    $info = if ($script:CurrentFileBeingScanned) { " | $($script:CurrentFileBeingScanned)" } else { "" }
    Write-Host "`r$bar $percent% $($script:CurrentScanType) [Файлов: $($script:TotalFilesScanned) | Хешей: $($script:FilesHashed) | Скип: $($script:FilesSkipped)]$info" -NoNewline -ForegroundColor Cyan
}
function Invoke-ScanProcesses {
    if (-not $config.scan.check_processes) { return }
    $script:CurrentStep = 1
    $script:CurrentScanType = "Сканирование процессов"
    Update-ProgressDisplay

    foreach ($proc in (Get-Process -ErrorAction SilentlyContinue)) {
        $procName = $proc.Name
        $procPath = $null
        try { $procPath = $proc.Path } catch {}

        $isSystem = Test-Whitelisted -InputString $procName -FilePath $procPath -Mode 'Process'
        $isJava = $procName -match '^(java|javaw|javaws|jp2launcher|javac|jconsole|jvisualvm|jmc|openjdk|javald)$'

        if ($isSystem -and -not $isJava) { continue }

        $script:TotalFilesScanned++
        $script:CurrentFileBeingScanned = $procName
        Update-ProgressDisplay

        $sig = if ($procPath -and (Test-Path -LiteralPath $procPath)) { Test-FileSignature -FilePath $procPath } else { $null }
        $hash = if ($procPath) { Get-FileHashCached -FilePath $procPath -Algorithm 'SHA256' } else { $null }

        $result = [PSCustomObject]@{
            'Тип'                 = if ($isJava) { 'Java процесс' } else { 'Процесс' }
            'Имя'                 = $procName
            'Путь'                = if ($procPath) { $procPath } else { 'N/A' }
            'PID'                 = $proc.Id
            'Детали'              = ''
            'Последнее изменение' = 'N/A'
            'Статус'              = 'Работает'
            'Риск'                = 'Info'
            'Вероятность'         = 0
            'Дней с изменения'    = 999
            'Цвет даты'           = 'gray'
            'Заметка даты'        = ''
            'Подпись'             = if ($null -ne $sig) { if ($sig) { 'Подписано' } else { 'Не подписано' } } else { 'N/A' }
            'SHA256'              = if ($hash) { $hash.Substring(0,16) + '...' } else { 'N/A' }
            'Верификация'         = 'N/A'
        }
        $script:Results.Add($result)
        if ($isJava) { $script:JavaProcessResults.Add($result) } else { $script:ProcessResults.Add($result) }
    }
    Write-Host ""
}

function Invoke-ScanJvmArgs {
    if (-not $config.scan.check_jvm_args) { return }
    $script:CurrentStep = 2
    $script:CurrentScanType = "Проверка JVM-аргументов"
    Update-ProgressDisplay

    $suspiciousJvmArgs = @(
        '-javaagent','-agentpath','-agentlib','-xbootclasspath',
        '-djava.system.class.loader','-djavax.net.ssl.truststore',
        '-dfml.ignoreinvalidminecraftcertificates',
        '-dfml.ignorepatchdiscrepancies',
        '-noverify','-xverify:none',
        '-xx:+disableattachmechanism',
        '-djdk.attach.allowattachself',
        '-dlog4j2.formatmsgnolookups'
    )
    $javaProcs = Get-CimInstance Win32_Process -Filter "Name='java.exe' OR Name='javaw.exe'" -ErrorAction SilentlyContinue
    foreach ($jp in $javaProcs) {
        $script:TotalFilesScanned++
        $script:CurrentFileBeingScanned = "$($jp.Name) (PID $($jp.ProcessId))"
        Update-ProgressDisplay

        $cmdLine = $jp.CommandLine
        if ([string]::IsNullOrWhiteSpace($cmdLine)) { continue }

        $foundArgs = [System.Collections.Generic.List[string]]::new()
        foreach ($arg in $suspiciousJvmArgs) {
            if ($cmdLine.ToLower().Contains($arg.ToLower())) {
                $foundArgs.Add($arg)
            }
        }

        if ($foundArgs.Count -eq 0) { continue }

        $days = 999
        $dateStr = 'N/A'
        $path = $jp.ExecutablePath
        if ($path -and (Test-Path -LiteralPath $path)) {
            try {
                $fi = Get-Item -LiteralPath $path
                $days = Get-DaysSinceLastWrite $fi.LastWriteTime
                $dateStr = Format-LastWriteTime $fi.LastWriteTime
            } catch {}
        }

        $prob = [math]::Min(95, 40 + ($foundArgs.Count * 15))
        $risk = if ($prob -ge 80) { 'Critical' } else { 'High' }
        $result = [PSCustomObject]@{
            'Тип'                 = 'JVM-аргумент'
            'Имя'                 = "$($jp.Name) (PID $($jp.ProcessId))"
            'Путь'                = if ($path) { $path } else { 'N/A' }
            'PID'                 = $jp.ProcessId
            'Детали'              = "Подозрительные JVM-аргументы: $($foundArgs -join ', '). Может быть агентом/инжектом."
            'Последнее изменение' = $dateStr
            'Статус'              = 'Обнаружено'
            'Риск'                = $risk
            'Вероятность'         = $prob
            'Дней с изменения'    = $days
            'Цвет даты'           = Get-DateColor $days
            'Заметка даты'        = Get-DateNote $days
            'Подпись'             = 'N/A'
            'SHA256'              = 'N/A'
            'Верификация'         = ($foundArgs -join ',')
        }
        $script:Results.Add($result)
        $script:JvmArgResults.Add($result)
    }
    Write-Host ""
}

function Invoke-ScanFiles {
    $script:CurrentStep = 3
    $script:CurrentScanType = "Сканирование файлов"
    Update-ProgressDisplay

    foreach ($rawPath in $config.scan.paths) {
        $path = [Environment]::ExpandEnvironmentVariables($rawPath)
        if (-not (Test-Path -LiteralPath $path)) { continue }
        $depthParam = if ($SupportsDepth) { @{ Depth = $config.scan.max_depth_files } } else { @{} }
        $files = Get-ChildItem -LiteralPath $path -File -Recurse @depthParam -ErrorAction SilentlyContinue

        foreach ($file in $files) {
            $script:TotalFilesScanned++
            if (-not (Test-ShouldScanFile -File $file)) { $script:FilesSkipped++; continue }
            $script:CurrentFileBeingScanned = $file.Name
            Update-ProgressDisplay

            $nameDet = Get-RiskLevel -InputString "$($file.Name) $($file.FullName)" -FilePath $file.FullName
            if ($nameDet.Risk -eq 'Clean') { continue }

            $needHash = $file.Extension.ToLower() -in $script:HashableExtensions
            $sig = if ($needHash) { Test-FileSignature -FilePath $file.FullName } else { $null }
            $hash = if ($needHash) { Get-FileHashCached -FilePath $file.FullName -Algorithm 'SHA256' } else { $null }
            $days = Get-DaysSinceLastWrite $file.LastWriteTime

            $script:Results.Add([PSCustomObject]@{
                'Тип'                 = 'файлов'
                'Имя'                 = $file.Name
                'Путь'                = $file.FullName
                'PID'                 = 'N/A'
                'Детали'              = $nameDet.Reason
                'Последнее изменение' = Format-LastWriteTime $file.LastWriteTime
                'Статус'              = 'Найден'
                'Риск'                = $nameDet.Risk
                'Вероятность'         = $nameDet.Probability
                'Дней с изменения'    = $days
                'Цвет даты'           = Get-DateColor $days
                'Заметка даты'        = Get-DateNote $days
                'Подпись'             = if ($null -ne $sig) { if ($sig) { 'Подписано' } else { 'Не подписано' } } else { 'N/A' }
                'SHA256'              = if ($hash) { $hash.Substring(0,16) + '...' } else { 'N/A' }
                'Верификация'         = 'N/A'
            })
        }
    }
    Write-Host ""
}

function Invoke-ScanMinecraft {
    $script:CurrentStep = 4
    $script:CurrentScanType = "Сканирование Minecraft"
    Update-ProgressDisplay

    foreach ($rawPath in $config.scan.minecraft_paths) {
        $path = [Environment]::ExpandEnvironmentVariables($rawPath)
        if (-not (Test-Path -LiteralPath $path)) { continue }
        $depthParam = if ($SupportsDepth) { @{ Depth = $config.scan.max_depth_minecraft } } else { @{} }
        $files = Get-ChildItem -LiteralPath $path -File -Recurse @depthParam -ErrorAction SilentlyContinue

        foreach ($file in $files) {
            $script:TotalFilesScanned++
            if (-not (Test-ShouldScanFile -File $file)) { $script:FilesSkipped++; continue }

            $isJar = $file.Extension.ToLower() -eq '.jar'
            $needHash = $file.Extension.ToLower() -in $script:HashableExtensions
            $isModPath = Test-ModPath -FilePath $file.FullName

            $isLibrary = -not $isModPath -and (
                $file.FullName -match '\\libraries\\' -or
                $file.FullName -match '\\versions\\[^\\]+\\[^\\]+\.jar$' -or
                $file.FullName -match '\\versions\\[^\\]+\\\.fabric\\remappedjars\\'
            )
            if ($isLibrary) { $script:FilesSkipped++; continue }
            if (-not $isModPath -and $isJar) { $script:FilesSkipped++; continue }

            $script:CurrentFileBeingScanned = $file.Name
            Update-ProgressDisplay

            $days = Get-DaysSinceLastWrite $file.LastWriteTime
            $dateColor = Get-DateColor $days
            $dateNote = Get-DateNote $days

            $sha1 = if ($isJar -and $needHash -and $isModPath) { Get-FileHashCached -FilePath $file.FullName -Algorithm 'SHA1' } else { $null }
            $sha256 = $null

            $modInfo = $null
            if ($sha1 -and (Test-LegitMod -FileName $file.Name)) {
                $modInfo = @{ Verified = $true; ModName = $file.Name; ProjectId = 'whitelist'; Reason = 'Легитимный мод (whitelist)' }
            } elseif ($sha1) {
                $modInfo = Get-ModrinthBySha1 -Sha1 $sha1
            }

            if ($config.scan.check_manifest -and $isJar -and $isModPath -and -not ($modInfo -and $modInfo.Verified)) {
                $manifest = Test-JarManifest -FilePath $file.FullName
                if ($manifest) {
                    $mc = $manifest.Content.ToLower()
                    $manifestHits = [System.Collections.Generic.List[string]]::new()
                    foreach ($kw in @('killaura','aimbot','autototem','triggerbot','xray','freecam','nuker','scaffold','bhop','antikb','reachhack','wallhack','velocityhack','cheat','hack','inject','baritone')) {
                        if ($mc.Contains($kw)) { $manifestHits.Add($kw) }
                    }
                    if ($manifestHits.Count -gt 0) {
                        $sig = if ($needHash) { Test-FileSignature -FilePath $file.FullName } else { $null }
                        $result = [PSCustomObject]@{
                            'Тип'                 = 'Манифест JAR'
                            'Имя'                 = $file.Name
                            'Путь'                = $file.FullName
                            'PID'                 = $manifest.Type
                            'Детали'              = "В манифесте найдены подозрительные слова: $($manifestHits -join ', ')"
                            'Последнее изменение' = Format-LastWriteTime $file.LastWriteTime
                            'Статус'              = 'Подозрительный манифест'
                            'Риск'                = 'High'
                            'Вероятность'         = 75
                            'Дней с изменения'    = $days
                            'Цвет даты'           = $dateColor
                            'Заметка даты'        = $dateNote
                            'Подпись'             = if ($null -ne $sig) { if ($sig) { 'Подписано' } else { 'Не подписано' } } else { 'N/A' }
                            'SHA256'              = 'N/A'
                            'Верификация'         = 'Манифест'
                        }
                        $script:Results.Add($result)
                        $script:ManifestResults.Add($result)
                        continue
                    }
                }
            }

            $suspicious = Test-SuspiciousMod -FileName $file.Name
            if ($suspicious) {
                $sig = if ($needHash) { Test-FileSignature -FilePath $file.FullName } else { $null }
                $result = [PSCustomObject]@{
                    'Тип'                 = 'Требует ручной проверки'
                    'Имя'                 = $file.Name
                    'Путь'                = $file.FullName
                    'PID'                 = 'N/A'
                    'Детали'              = "Категория: $($suspicious.Category) · Совпадение: $($suspicious.Pattern). Мод может использоваться для автоматизации действий, которую часто запрещают сервера."
                    'Последнее изменение' = Format-LastWriteTime $file.LastWriteTime
                    'Статус'              = 'Подозрительный'
                    'Риск'                = 'High'
                    'Вероятность'         = 70
                    'Дней с изменения'    = $days
                    'Цвет даты'           = $dateColor
                    'Заметка даты'        = $dateNote
                    'Подпись'             = if ($null -ne $sig) { if ($sig) { 'Подписано' } else { 'Не подписано' } } else { 'N/A' }
                    'SHA256'              = if ($sha256) { $sha256 } else { 'N/A' }
                    'Верификация'         = 'Подозрительный'
                }
                $script:Results.Add($result)
                $script:SuspiciousModResults.Add($result)
                continue
            }

            if ($modInfo -and -not $modInfo.Verified) {
                $sig = if ($needHash) { Test-FileSignature -FilePath $file.FullName } else { $null }
                $result = [PSCustomObject]@{
                    'Тип'                 = 'Неизвестный мод'
                    'Имя'                 = $file.Name
                    'Путь'                = $file.FullName
                    'PID'                 = 'N/A'
                    'Детали'              = 'Не найден в whitelist и на Modrinth. Требует ручной проверки.'
                    'Последнее изменение' = Format-LastWriteTime $file.LastWriteTime
                    'Статус'              = 'Неизвестен'
                    'Риск'                = 'Unknown'
                    'Вероятность'         = 0
                    'Дней с изменения'    = $days
                    'Цвет даты'           = $dateColor
                    'Заметка даты'        = $dateNote
                    'Подпись'             = if ($null -ne $sig) { if ($sig) { 'Подписано' } else { 'Не подписано' } } else { 'N/A' }
                    'SHA256'              = if ($sha256) { $sha256 } else { 'N/A' }
                    'Верификация'         = 'Не подтверждён'
                }
                $script:Results.Add($result)
                $script:UnknownModResults.Add($result)
                continue
            }

            $nameDet = Get-RiskLevel -InputString "$($file.Name) $($file.FullName)" -FilePath $file.FullName
            $jarFindings = @()
            if ($config.scan.check_jar_content -and $isJar -and $nameDet.Risk -ne 'Critical' -and $isModPath) {
                $jarFindings = Test-JarContent -FilePath $file.FullName
            }

            if ($nameDet.Risk -eq 'Clean' -and $jarFindings.Count -eq 0) {
                if ($modInfo -and $modInfo.Verified) {
                    $sig = if ($needHash) { Test-FileSignature -FilePath $file.FullName } else { $null }
                    $script:VerifiedModResults.Add([PSCustomObject]@{
                        'Тип'                 = 'Легитимный мод'
                        'Имя'                 = $file.Name
                        'Путь'                = $file.FullName
                        'PID'                 = 'N/A'
                        'Детали'              = $modInfo.Reason
                        'Последнее изменение' = Format-LastWriteTime $file.LastWriteTime
                        'Статус'              = 'Легитимный'
                        'Риск'                = 'Info'
                        'Вероятность'         = 0
                        'Дней с изменения'    = $days
                        'Цвет даты'           = $dateColor
                        'Заметка даты'        = $dateNote
                        'Подпись'             = if ($null -ne $sig) { if ($sig) { 'Подписано' } else { 'Не подписано' } } else { 'N/A' }
                        'SHA256'              = if ($sha256) { $sha256.Substring(0,16) + '...' } else { 'N/A' }
                        'Верификация'         = 'Легитимный'
                    })
                }
                continue
            }

            $reason = $nameDet.Reason
            if ($jarFindings.Count -gt 0) {
                $uniq = $jarFindings | Select-Object -Unique
                $short = ($uniq | Select-Object -First 3) -join '; '
                if ($uniq.Count -gt 3) { $short += " и ещё $($uniq.Count - 3)" }
                if ($reason) { $reason += " | JAR: $short" } else { $reason = "JAR: $short" }
            }

            $sig2 = if ($needHash) { Test-FileSignature -FilePath $file.FullName } else { $null }
            $finalRisk = $nameDet.Risk
            $finalProb = $nameDet.Probability
            if ($finalRisk -eq 'Clean' -and $jarFindings.Count -gt 0) { $finalRisk = 'High'; $finalProb = 70 }

            $script:Results.Add([PSCustomObject]@{
                'Тип'                 = 'Minecraft'
                'Имя'                 = $file.Name
                'Путь'                = $file.FullName
                'PID'                 = 'N/A'
                'Детали'              = $reason
                'Последнее изменение' = Format-LastWriteTime $file.LastWriteTime
                'Статус'              = 'Возможное совпадение'
                'Риск'                = $finalRisk
                'Вероятность'         = $finalProb
                'Дней с изменения'    = $days
                'Цвет даты'           = $dateColor
                'Заметка даты'        = $dateNote
                'Подпись'             = if ($null -ne $sig2) { if ($sig2) { 'Подписано' } else { 'Не подписано' } } else { 'N/A' }
                'SHA256'              = if ($sha256) { $sha256.Substring(0,16) + '...' } else { 'N/A' }
                'Верификация'         = if ($modInfo -and $modInfo.Verified) { 'Легитимный' } else { 'N/A' }
            })
        }
    }
    Save-ModrinthCache
    Write-Host ""
}

function Invoke-ScanConfigs {
    if (-not $config.scan.check_configs) { return }
    $script:CurrentStep = 5
    $script:CurrentScanType = "Сканирование конфигов"
    Update-ProgressDisplay
    $configPaths = @("$env:AppData\.minecraft\config","$env:AppData\.minecraft\versions")
    foreach ($cfgPath in $configPaths) {
        if (-not (Test-Path -LiteralPath $cfgPath)) { continue }
        $cfgFiles = Get-ChildItem -LiteralPath $cfgPath -File -Recurse -Include "*.json","*.cfg","*.yml","*.yaml","*.properties","*.toml" -ErrorAction SilentlyContinue
        foreach ($cfg in $cfgFiles) {
            $script:TotalFilesScanned++
            if ($cfg.Length -gt 2MB) { $script:FilesSkipped++; continue }
            $script:CurrentFileBeingScanned = $cfg.Name
            Update-ProgressDisplay
            $det = Get-RiskLevel -InputString $cfg.Name -FilePath $cfg.FullName
            if ($det.Risk -eq 'Clean') { continue }
            $days = Get-DaysSinceLastWrite $cfg.LastWriteTime
            $result = [PSCustomObject]@{
                'Тип'                 = 'След конфига'
                'Имя'                 = $cfg.Name
                'Путь'                = $cfg.FullName
                'PID'                 = 'N/A'
                'Детали'              = "$($det.Reason). Остаток от мода. Мод может быть удалён, но конфиг остался."
                'Последнее изменение' = Format-LastWriteTime $cfg.LastWriteTime
                'Статус'              = 'След конфига'
                'Риск'                = $det.Risk
                'Вероятность'         = $det.Probability
                'Дней с изменения'    = $days
                'Цвет даты'           = Get-DateColor $days
                'Заметка даты'        = Get-DateNote $days
                'Подпись'             = 'N/A'
                'SHA256'              = 'N/A'
                'Верификация'         = 'След конфига'
            }
            $script:Results.Add($result)
            $script:ConfigTraceResults.Add($result)
        }
    }
    Write-Host ""
}

function Invoke-ScanCyrillicConfigs {
    if (-not $config.scan.check_cyrillic_configs) { return }
    $script:CurrentStep = 6
    $script:CurrentScanType = "Кириллические конфиги"
    Update-ProgressDisplay
    $cfgPath = "$env:AppData\.minecraft\config"
    if (-not (Test-Path -LiteralPath $cfgPath)) { return }
    $files = Get-ChildItem -LiteralPath $cfgPath -File -Recurse -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        if ($f.Name -match '[а-яА-ЯёЁ]') {
            $script:TotalFilesScanned++
            $script:CurrentFileBeingScanned = $f.Name
            Update-ProgressDisplay
            $days = Get-DaysSinceLastWrite $f.LastWriteTime
            $result = [PSCustomObject]@{
                'Тип'                 = 'Кириллический конфиг'
                'Имя'                 = $f.Name
                'Путь'                = $f.FullName
                'PID'                 = 'N/A'
                'Детали'              = 'Имя файла содержит кириллицу. Часто встречается у читов от русскоязычных авторов.'
                'Последнее изменение' = Format-LastWriteTime $f.LastWriteTime
                'Статус'              = 'Кириллица в имени'
                'Риск'                = 'Suspicious'
                'Вероятность'         = 45
                'Дней с изменения'    = $days
                'Цвет даты'           = Get-DateColor $days
                'Заметка даты'        = Get-DateNote $days
                'Подпись'             = 'N/A'
                'SHA256'              = 'N/A'
                'Верификация'         = 'Кириллица'
            }
            $script:Results.Add($result)
            $script:CyrillicConfigResults.Add($result)
        }
    }
    Write-Host ""
}

function Invoke-ScanLatestLog {
    if (-not $config.scan.check_latest_log) { return }
    $script:CurrentStep = 7
    $script:CurrentScanType = "Анализ latest.log"
    Update-ProgressDisplay

    $logCandidates = @(
        "$env:AppData\.minecraft\logs\latest.log",
        "$env:AppData\.minecraft\logs\debug.log",
        "$env:AppData\.minecraft\logs\blame.log"
    )
    $cutoff = (Get-Date).AddDays(-$config.scan.log_scan_days)

    foreach ($logPath in $logCandidates) {
        if (-not (Test-Path -LiteralPath $logPath)) { continue }
        $fi = Get-Item -LiteralPath $logPath
        if ($fi.LastWriteTime -lt $cutoff) { continue }

        $days = Get-DaysSinceLastWrite $fi.LastWriteTime
        $lines = Read-LogFileUtf8 -Path $logPath
        $lineNum = 0
        foreach ($line in $lines) {
            $lineNum++
            if ([string]::IsNullOrWhiteSpace($line)) { continue }
            $lower = $line.ToLower()
            foreach ($kw in $script:KnownLogKeywords) {
                if ($lower.Contains($kw)) {
                    $script:TotalFilesScanned++
                    $script:CurrentFileBeingScanned = $fi.Name
                    if ($script:TotalFilesScanned % 10 -eq 0) { Update-ProgressDisplay }
                    $short = $line.Trim()
                    if ($short.Length -gt 200) { $short = $short.Substring(0,200) + '...' }
                    $result = [PSCustomObject]@{
                        'Тип'                 = 'latest.log'
                        'Имя'                 = $fi.Name
                        'Путь'                = $logPath
                        'PID'                 = "Строка $lineNum"
                        'Детали'              = "Упоминание '$kw': $short"
                        'Последнее изменение' = Format-LastWriteTime $fi.LastWriteTime
                        'Статус'              = 'Найдено в логе'
                        'Риск'                = 'High'
                        'Вероятность'         = 65
                        'Дней с изменения'    = $days
                        'Цвет даты'           = Get-DateColor $days
                        'Заметка даты'        = Get-DateNote $days
                        'Подпись'             = 'N/A'
                        'SHA256'              = 'N/A'
                        'Верификация'         = $kw
                    }
                    $script:Results.Add($result)
                    $script:LatestLogResults.Add($result)
                    break
                }
            }
        }
    }
    Write-Host ""
}

function Invoke-ScanOptionsTxt {
    if (-not $config.scan.check_options_txt) { return }
    $script:CurrentStep = 8
    $script:CurrentScanType = "Анализ options.txt"
    Update-ProgressDisplay

    $optCandidates = @(
        "$env:AppData\.minecraft\options.txt",
        "$env:AppData\.minecraft\versions"
    )
    foreach ($optPath in $optCandidates) {
        if (-not (Test-Path -LiteralPath $optPath)) { continue }
        $optFiles = @()
        if ((Get-Item -LiteralPath $optPath).PSIsContainer) {
            $optFiles = Get-ChildItem -LiteralPath $optPath -File -Recurse -Filter 'options.txt' -ErrorAction SilentlyContinue
        } else {
            $optFiles = @(Get-Item -LiteralPath $optPath)
        }

        foreach ($opt in $optFiles) {
            $script:TotalFilesScanned++
            $script:CurrentFileBeingScanned = $opt.FullName
            Update-ProgressDisplay
            $days = Get-DaysSinceLastWrite $opt.LastWriteTime
            $findings = [System.Collections.Generic.List[string]]::new()
            $prob = 0
            $lines = Read-LogFileUtf8 -Path $opt.FullName
            foreach ($line in $lines) {
                if ($line -match '^gamma:\s*([\d\.]+)') {
                    $g = [double]$Matches[1]
                    if ($g -gt 1.0) {
                        $findings.Add("gamma=$g (fullbright)")
                        $prob += 30
                    }
                }
                if ($line -match '^fov:\s*([\d\.]+)') {
                    $f = [double]$Matches[1]
                    if ($f -ge 130) {
                        $findings.Add("fov=$f (аномально высокий)")
                        $prob += 15
                    }
                    if ($f -le 40 -and $f -gt 0) {
                        $findings.Add("fov=$f (аномально низкий — аим-ассист)")
                        $prob += 20
                    }
                }
                if ($line -match '^renderDistance:\s*(\d+)') {
                    $r = [int]$Matches[1]
                    if ($r -le 2 -and $r -gt 0) {
                        $findings.Add("renderDistance=$r (низкий — возможно xray)")
                        $prob += 20
                    }
                }
                if ($line -match '^mouseSensitivity:\s*([\d\.]+)') {
                    $ms = [double]$Matches[1]
                    if ($ms -eq 0) {
                        $findings.Add("mouseSensitivity=0 (возможно для аим-ассиста)")
                        $prob += 15
                    }
                }
                if ($line -match '^toggleCrouch:true') {
                    $findings.Add("toggleCrouch=true (макрос)")
                    $prob += 10
                }
                if ($line -match '^toggleSprint:true') {
                    $findings.Add("toggleSprint=true (макрос)")
                    $prob += 10
                }
            }

            if ($findings.Count -eq 0) { continue }
            $prob = [math]::Min(90, $prob + 20)
            $risk = if ($prob -ge 60) { 'High' } else { 'Suspicious' }
            $result = [PSCustomObject]@{
                'Тип'                 = 'options.txt'
                'Имя'                 = $opt.Name
                'Путь'                = $opt.FullName
                'PID'                 = 'N/A'
                'Детали'              = "Аномальные настройки: $($findings -join '; ')"
                'Последнее изменение' = Format-LastWriteTime $opt.LastWriteTime
                'Статус'              = 'Аномалии'
                'Риск'                = $risk
                'Вероятность'         = $prob
                'Дней с изменения'    = $days
                'Цвет даты'           = Get-DateColor $days
                'Заметка даты'        = Get-DateNote $days
                'Подпись'             = 'N/A'
                'SHA256'              = 'N/A'
                'Верификация'         = 'options.txt'
            }
            $script:Results.Add($result)
            $script:OptionsTxtResults.Add($result)
        }
    }
    Write-Host ""
}

function Invoke-ScanHsErr {
    if (-not $config.scan.check_hs_err) { return }
    $script:CurrentStep = 9
    $script:CurrentScanType = "Поиск hs_err_pid*.log"
    Update-ProgressDisplay

    $searchPaths = @(
        "$env:AppData\.minecraft",
        "$env:AppData\.minecraft\logs",
        "$env:UserProfile",
        "$env:TEMP"
    )
    $cutoff = (Get-Date).AddDays(-$config.scan.log_scan_days)
    foreach ($sp in $searchPaths) {
        if (-not (Test-Path -LiteralPath $sp)) { continue }
        $files = Get-ChildItem -LiteralPath $sp -File -Filter 'hs_err_pid*.log' -Recurse -ErrorAction SilentlyContinue
        foreach ($f in $files) {
            if ($f.LastWriteTime -lt $cutoff) { continue }
            $script:TotalFilesScanned++
            $script:CurrentFileBeingScanned = $f.Name
            Update-ProgressDisplay
            $days = Get-DaysSinceLastWrite $f.LastWriteTime
            $lines = Read-LogFileUtf8 -Path $f.FullName
            $hits = [System.Collections.Generic.List[string]]::new()
            foreach ($line in $lines) {
                if ($line -match 'javaagent|agentpath|agentlib|killaura|aimbot|autototem|xray|baritone|meteor|wurst|forgehax|liquidbounce|cheatutils') {
                    $hits.Add($line.Trim())
                    if ($hits.Count -ge 5) { break }
                }
            }
            if ($hits.Count -eq 0) { continue }
            $result = [PSCustomObject]@{
                'Тип'                 = 'hs_err_pid'
                'Имя'                 = $f.Name
                'Путь'                = $f.FullName
                'PID'                 = 'N/A'
                'Детали'              = "В дампе JVM найдены подозрительные строки: $($hits -join ' | ')"
                'Последнее изменение' = Format-LastWriteTime $f.LastWriteTime
                'Статус'              = 'Подозрительный дамп'
                'Риск'                = 'High'
                'Вероятность'         = 75
                'Дней с изменения'    = $days
                'Цвет даты'           = Get-DateColor $days
                'Заметка даты'        = Get-DateNote $days
                'Подпись'             = 'N/A'
                'SHA256'              = 'N/A'
                'Верификация'         = 'hs_err'
            }
            $script:Results.Add($result)
            $script:HsErrResults.Add($result)
        }
    }
    Write-Host ""
}

function Invoke-ScanScreenshots {
    if (-not $config.scan.check_screenshots) { return }
    $script:CurrentStep = 10
    $script:CurrentScanType = "Анализ скриншотов"
    Update-ProgressDisplay

    $shotDir = "$env:AppData\.minecraft\screenshots"
    if (-not (Test-Path -LiteralPath $shotDir)) { return }
    $cutoff = (Get-Date).AddDays(-$config.scan.log_scan_days)
    $files = Get-ChildItem -LiteralPath $shotDir -File -Filter '*.png' -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        if ($f.LastWriteTime -lt $cutoff) { continue }
        $nameLower = $f.Name.ToLower()
        $bad = $false
        foreach ($kw in @('cheat','aura','xray','killaura','aimbot','hack','meteor','wurst','impact','vape','freecam','nuker','scaffold')) {
            if ($nameLower.Contains($kw)) { $bad = $true; break }
        }
        if (-not $bad) { continue }
        $script:TotalFilesScanned++
        $script:CurrentFileBeingScanned = $f.Name
        Update-ProgressDisplay
        $days = Get-DaysSinceLastWrite $f.LastWriteTime
        $result = [PSCustomObject]@{
            'Тип'                 = 'Скриншот'
            'Имя'                 = $f.Name
            'Путь'                = $f.FullName
            'PID'                 = 'N/A'
            'Детали'              = 'Имя скриншота содержит подозрительное слово.'
            'Последнее изменение' = Format-LastWriteTime $f.LastWriteTime
            'Статус'              = 'Подозрительное имя'
            'Риск'                = 'Suspicious'
            'Вероятность'         = 50
            'Дней с изменения'    = $days
            'Цвет даты'           = Get-DateColor $days
            'Заметка даты'        = Get-DateNote $days
            'Подпись'             = 'N/A'
            'SHA256'              = 'N/A'
            'Верификация'         = 'Screenshot'
        }
        $script:Results.Add($result)
        $script:ScreenshotResults.Add($result)
    }
    Write-Host ""
}

function Invoke-ScanReplays {
    if (-not $config.scan.check_replays) { return }
    $script:CurrentStep = 11
    $script:CurrentScanType = "Анализ реплеев"
    Update-ProgressDisplay

    $replayDirs = @(
        "$env:AppData\.minecraft\replay_recordings",
        "$env:AppData\.minecraft\replays",
        "$env:AppData\.minecraft\.replay",
        "$env:AppData\.minecraft\replay_videos"
    )
    $cutoff = (Get-Date).AddDays(-$config.scan.log_scan_days)
    foreach ($rd in $replayDirs) {
        if (-not (Test-Path -LiteralPath $rd)) { continue }
        $files = Get-ChildItem -LiteralPath $rd -File -Include '*.mcpr','*.json' -ErrorAction SilentlyContinue
        foreach ($f in $files) {
            if ($f.LastWriteTime -lt $cutoff) { continue }
            $script:TotalFilesScanned++
            $script:CurrentFileBeingScanned = $f.Name
            Update-ProgressDisplay
            $days = Get-DaysSinceLastWrite $f.LastWriteTime
            $hits = [System.Collections.Generic.List[string]]::new()
            try {
                $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
                foreach ($kw in @('meteor','wurst','impact','killaura','aimbot','xray','freecam','nuker','scaffold','vape','liquidbounce','baritone')) {
                    if ($content.ToLower().Contains($kw)) { $hits.Add($kw) }
                }
            } catch {}
            if ($hits.Count -eq 0) { continue }
            $result = [PSCustomObject]@{
                'Тип'                 = 'Реплей'
                'Имя'                 = $f.Name
                'Путь'                = $f.FullName
                'PID'                 = 'N/A'
                'Детали'              = "В метаданных реплея найдены моды: $($hits -join ', ')"
                'Последнее изменение' = Format-LastWriteTime $f.LastWriteTime
                'Статус'              = 'Моды в реплее'
                'Риск'                = 'High'
                'Вероятность'         = 70
                'Дней с изменения'    = $days
                'Цвет даты'           = Get-DateColor $days
                'Заметка даты'        = Get-DateNote $days
                'Подпись'             = 'N/A'
                'SHA256'              = 'N/A'
                'Верификация'         = 'Replay'
            }
            $script:Results.Add($result)
            $script:ReplayResults.Add($result)
        }
    }
    Write-Host ""
}

function Invoke-ScanCrashReports {
    if (-not $config.scan.check_crash_reports) { return }
    $script:CurrentStep = 12
    $script:CurrentScanType = "Анализ crash-reports"
    Update-ProgressDisplay

    $crashDir = "$env:AppData\.minecraft\crash-reports"
    if (-not (Test-Path -LiteralPath $crashDir)) { return }
    $cutoff = (Get-Date).AddDays(-$config.scan.log_scan_days)
    $files = Get-ChildItem -LiteralPath $crashDir -File -Filter '*.txt' -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        if ($f.LastWriteTime -lt $cutoff) { continue }
        $script:TotalFilesScanned++
        $script:CurrentFileBeingScanned = $f.Name
        Update-ProgressDisplay
        $days = Get-DaysSinceLastWrite $f.LastWriteTime
        $lines = Read-LogFileUtf8 -Path $f.FullName
        $hits = [System.Collections.Generic.List[string]]::new()
        foreach ($line in $lines) {
            foreach ($kw in @('meteor','wurst','impact','baritone','killaura','aimbot','xray','freecam','nuker','scaffold','vape','liquidbounce','forgehax','cheatutils','javaagent')) {
                if ($line.ToLower().Contains($kw)) {
                    $hits.Add($line.Trim())
                    break
                }
            }
            if ($hits.Count -ge 5) { break }
        }
        if ($hits.Count -eq 0) { continue }
        $result = [PSCustomObject]@{
            'Тип'                 = 'crash-report'
            'Имя'                 = $f.Name
            'Путь'                = $f.FullName
            'PID'                 = 'N/A'
            'Детали'              = "В стектрейсе найдены классы читов: $($hits -join ' | ')"
            'Последнее изменение' = Format-LastWriteTime $f.LastWriteTime
            'Статус'              = 'Stacktrace'
            'Риск'                = 'High'
            'Вероятность'         = 75
            'Дней с изменения'    = $days
            'Цвет даты'           = Get-DateColor $days
            'Заметка даты'        = Get-DateNote $days
            'Подпись'             = 'N/A'
            'SHA256'              = 'N/A'
            'Верификация'         = 'CrashReport'
        }
        $script:Results.Add($result)
        $script:CrashReportResults.Add($result)
    }
    Write-Host ""
}

function Invoke-ScanStats {
    if (-not $config.scan.check_stats) { return }
    $script:CurrentStep = 13
    $script:CurrentScanType = "Анализ статистики"
    Update-ProgressDisplay

    $statsDirs = @(
        "$env:AppData\.minecraft\saves",
        "$env:AppData\.minecraft\versions"
    )
    foreach ($sd in $statsDirs) {
        if (-not (Test-Path -LiteralPath $sd)) { continue }
        $files = Get-ChildItem -LiteralPath $sd -File -Recurse -Filter '*.json' -ErrorAction SilentlyContinue |
            Where-Object { $_.FullName -match '\\stats\\' -or $_.FullName -match '\\advancements\\' }
        foreach ($f in $files) {
            $script:TotalFilesScanned++
            $script:CurrentFileBeingScanned = $f.Name
            if ($script:TotalFilesScanned % 20 -eq 0) { Update-ProgressDisplay }
            $days = Get-DaysSinceLastWrite $f.LastWriteTime
            try {
                $json = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8 | ConvertFrom-Json -ErrorAction Stop
                $stats = $json.stats.'minecraft:custom'
                if (-not $stats) { continue }
                $playTime = if ($stats.'minecraft:play_time') { [int]$stats.'minecraft:play_time' } else { 0 }
                $walk = if ($stats.'minecraft:walk_one_cm') { [int]$stats.'minecraft:walk_one_cm' } else { 0 }
                $sprint = if ($stats.'minecraft:sprint_one_cm') { [int]$stats.'minecraft:sprint_one_cm' } else { 0 }
                $deaths = if ($stats.'minecraft:deaths') { [int]$stats.'minecraft:deaths' } else { 0 }
                $mobKills = if ($stats.'minecraft:mob_kills') { [int]$stats.'minecraft:mob_kills' } else { 0 }

                $findings = [System.Collections.Generic.List[string]]::new()
                $prob = 0
                if ($playTime -gt 0 -and $playTime -lt 72000 -and $walk -gt 500000) {
                    $findings.Add("walk_one_cm=$walk при play_time=$playTime (аномалия)")
                    $prob += 25
                }
                if ($sprint -eq 0 -and $walk -gt 100000) {
                    $findings.Add("sprint=0 при walk=$walk (анти-спринт?)")
                    $prob += 20
                }
                if ($deaths -eq 0 -and $mobKills -gt 500) {
                    $findings.Add("deaths=0 при mob_kills=$mobKills (god mode?)")
                    $prob += 30
                }
                if ($findings.Count -eq 0) { continue }
                $result = [PSCustomObject]@{
                    'Тип'                 = 'Статистика'
                    'Имя'                 = $f.Name
                    'Путь'                = $f.FullName
                    'PID'                 = 'N/A'
                    'Детали'              = "Аномалии: $($findings -join '; ')"
                    'Последнее изменение' = Format-LastWriteTime $f.LastWriteTime
                    'Статус'              = 'Аномалии'
                    'Риск'                = 'Suspicious'
                    'Вероятность'         = [math]::Min(85, $prob + 20)
                    'Дней с изменения'    = $days
                    'Цвет даты'           = Get-DateColor $days
                    'Заметка даты'        = Get-DateNote $days
                    'Подпись'             = 'N/A'
                    'SHA256'              = 'N/A'
                    'Верификация'         = 'Stats'
                }
                $script:Results.Add($result)
                $script:StatsResults.Add($result)
            } catch {}
        }
    }
    Write-Host ""
}

function Invoke-ScanServersDat {
    if (-not $config.scan.check_servers_dat) { return }
    $script:CurrentStep = 14
    $script:CurrentScanType = "Анализ servers.dat / profiles"
    Update-ProgressDisplay

    $checks = @(
        @{ Path = "$env:AppData\.minecraft\servers.dat"; Label = 'servers.dat' },
        @{ Path = "$env:AppData\.minecraft\launcher_profiles.json"; Label = 'launcher_profiles.json' },
        @{ Path = "$env:AppData\.minecraft\usercache.json"; Label = 'usercache.json' },
        @{ Path = "$env:AppData\.minecraft\realms_persistence.json"; Label = 'realms_persistence.json' }
    )
    foreach ($chk in $checks) {
        if (-not (Test-Path -LiteralPath $chk.Path)) { continue }
        $script:TotalFilesScanned++
        $script:CurrentFileBeingScanned = $chk.Label
        Update-ProgressDisplay
        $fi = Get-Item -LiteralPath $chk.Path
        $days = Get-DaysSinceLastWrite $fi.LastWriteTime
        try {
            $content = [System.IO.File]::ReadAllText($chk.Path, [System.Text.Encoding]::UTF8)
            $suspicious = [System.Collections.Generic.List[string]]::new()
            foreach ($kw in @('cheat','hack','meteor','wurst','vape','baritone','xray')) {
                if ($content.ToLower().Contains($kw)) { $suspicious.Add($kw) }
            }
            if ($suspicious.Count -eq 0) { continue }
            $result = [PSCustomObject]@{
                'Тип'                 = 'Профиль/сервер'
                'Имя'                 = $chk.Label
                'Путь'                = $chk.Path
                'PID'                 = 'N/A'
                'Детали'              = "В файле найдены подозрительные слова: $($suspicious -join ', ')"
                'Последнее изменение' = Format-LastWriteTime $fi.LastWriteTime
                'Статус'              = 'Подозрительный'
                'Риск'                = 'Suspicious'
                'Вероятность'         = 45
                'Дней с изменения'    = $days
                'Цвет даты'           = Get-DateColor $days
                'Заметка даты'        = Get-DateNote $days
                'Подпись'             = 'N/A'
                'SHA256'              = 'N/A'
                'Верификация'         = $chk.Label
            }
            $script:Results.Add($result)
            $script:ServersDatResults.Add($result)
        } catch {}
    }
    Write-Host ""
}

function Invoke-ScanProfiles {
    if (-not $config.scan.check_profiles) { return }
    $script:CurrentStep = 15
    $script:CurrentScanType = "Анализ лаунчер-профилей"
    Update-ProgressDisplay
    $profilesFile = "$env:AppData\.minecraft\launcher_profiles.json"
    if (-not (Test-Path -LiteralPath $profilesFile)) { return }
    try {
        $raw = Get-Content -LiteralPath $profilesFile -Raw -Encoding UTF8 | ConvertFrom-Json
        if (-not $raw.profiles) { return }
        $count = ($raw.profiles.PSObject.Properties | Measure-Object).Count
        if ($count -lt 15) { return }
        $script:TotalFilesScanned++
        $script:CurrentFileBeingScanned = 'launcher_profiles.json'
        Update-ProgressDisplay
        $fi = Get-Item -LiteralPath $profilesFile
        $days = Get-DaysSinceLastWrite $fi.LastWriteTime
        $result = [PSCustomObject]@{
            'Тип'                 = 'Профили лаунчера'
            'Имя'                 = 'launcher_profiles.json'
            'Путь'                = $profilesFile
            'PID'                 = 'N/A'
            'Детали'              = "Обнаружено $count профилей. Много профилей может говорить о частых экспериментах с версиями/модами."
            'Последнее изменение' = Format-LastWriteTime $fi.LastWriteTime
            'Статус'              = 'Много профилей'
            'Риск'                = 'Suspicious'
            'Вероятность'         = 35
            'Дней с изменения'    = $days
            'Цвет даты'           = Get-DateColor $days
            'Заметка даты'        = Get-DateNote $days
            'Подпись'             = 'N/A'
            'SHA256'              = 'N/A'
            'Верификация'         = 'Profiles'
        }
        $script:Results.Add($result)
        $script:ProfilesResults.Add($result)
    } catch {}
    Write-Host ""
}

function Invoke-ScanDll {
    if (-not $config.scan.check_dll) { return }
    $script:CurrentStep = 16
    $script:CurrentScanType = "Сканирование DLL"
    Update-ProgressDisplay
    $dllPaths = @("$env:Temp", "$env:AppData\Local\Temp",
                  "$env:AppData\.minecraft\bin", "$env:AppData\.minecraft\versions",
                  "$env:AppData\.minecraft\libraries", "$env:AppData\.minecraft\mods")
    $suspiciousDllPatterns = @('*inject*','*hook*','*hack*','*cheat*','*loader*',
                               '*bypass*','*stealth*','*overlay*','*esp*','*aimbot*',
                               '*xray*','*wallhack*','*vape*','*liquidbounce*','*wurst*')
    foreach ($dllPath in $dllPaths) {
        if (-not (Test-Path -LiteralPath $dllPath)) { continue }
        foreach ($pat in $suspiciousDllPatterns) {
            $found = Get-ChildItem -LiteralPath $dllPath -File -Filter "$pat.dll" -Recurse -ErrorAction SilentlyContinue
            foreach ($dll in $found) {
                if (Test-Whitelisted -InputString $dll.Name -FilePath $dll.FullName -Mode 'Dll') { continue }
                $script:TotalFilesScanned++
                $script:CurrentFileBeingScanned = $dll.Name
                Update-ProgressDisplay
                $sig = Test-FileSignature -FilePath $dll.FullName
                $hash = Get-FileHashCached -FilePath $dll.FullName -Algorithm 'SHA256'
                $days = Get-DaysSinceLastWrite $dll.LastWriteTime
                $result = [PSCustomObject]@{
                    'Тип'                 = 'DLL'
                    'Имя'                 = $dll.Name
                    'Путь'                = $dll.FullName
                    'PID'                 = 'N/A'
                    'Детали'              = 'Подозрительное имя DLL'
                    'Последнее изменение' = Format-LastWriteTime $dll.LastWriteTime
                    'Статус'              = 'Найден'
                    'Риск'                = 'High'
                    'Вероятность'         = 70
                    'Дней с изменения'    = $days
                    'Цвет даты'           = Get-DateColor $days
                    'Заметка даты'        = Get-DateNote $days
                    'Подпись'             = if ($null -ne $sig) { if ($sig) { 'Подписано' } else { 'Не подписано' } } else { 'N/A' }
                    'SHA256'              = if ($hash) { $hash.Substring(0,16) + '...' } else { 'N/A' }
                    'Верификация'         = 'N/A'
                }
                $script:Results.Add($result)
                $script:InjectResults.Add($result)
            }
        }
    }
    Write-Host ""
}

function Invoke-ScanRegistry {
    if (-not $config.scan.check_registry) { return }
    $script:CurrentStep = 17
    $script:CurrentScanType = "Сканирование реестра"
    Update-ProgressDisplay
    $regPaths = @(
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run"
    )
    foreach ($regPath in $regPaths) {
        if (-not (Test-Path $regPath)) { continue }
        $items = Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue
        if (-not $items) { continue }
        $items.PSObject.Properties |
            Where-Object { $_.Name -notmatch '^PS' -and $_.Value } |
            ForEach-Object {
                $det = Get-RiskLevel -InputString "$($_.Name) $($_.Value)" -FilePath $_.Value
                if ($det.Risk -eq 'Clean') { return }
                $script:Results.Add([PSCustomObject]@{
                    'Тип'                 = 'Реестр'
                    'Имя'                 = $_.Name
                    'Путь'                = $_.Value
                    'PID'                 = 'N/A'
                    'Детали'              = $det.Reason
                    'Последнее изменение' = 'N/A'
                    'Статус'              = 'В автозагрузке'
                    'Риск'                = $det.Risk
                    'Вероятность'         = $det.Probability
                    'Дней с изменения'    = 999
                    'Цвет даты'           = 'gray'
                    'Заметка даты'        = ''
                    'Подпись'             = 'N/A'
                    'SHA256'              = 'N/A'
                    'Верификация'         = 'N/A'
                })
            }
    }
    Write-Host ""
}

function Invoke-ScanServices {
    if (-not $config.scan.check_services) { return }
    $script:CurrentStep = 18
    $script:CurrentScanType = "Проверка служб"
    Update-ProgressDisplay
    foreach ($svcName in $script:CriticalServices) {
        $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
        if (-not $svc) { continue }
        $wmiSvc = Get-CimInstance -ClassName Win32_Service -Filter "Name='$svcName'" -ErrorAction SilentlyContinue
        $startMode = if ($wmiSvc) { $wmiSvc.StartMode } else { 'Unknown' }

        $processStartTime = 'N/A'
        if ($svc.Status -eq 'Running' -and $wmiSvc -and $wmiSvc.ProcessId -gt 0) {
            try {
                $proc = Get-Process -Id $wmiSvc.ProcessId -ErrorAction SilentlyContinue
                if ($proc -and $proc.StartTime) {
                    $processStartTime = Format-DateShort $proc.StartTime
                }
            } catch {}
        }

        $lastEventTime = 'N/A'
        try {
            $event = Get-WinEvent -FilterHashtable @{
                LogName = 'System'
                ProviderName = 'Service Control Manager'
                Id = 7036
            } -MaxEvents 50 -ErrorAction SilentlyContinue |
                Where-Object { $_.Message -match $svcName } |
                Select-Object -First 1
            if ($event) { $lastEventTime = Format-DateShort $event.TimeCreated }
        } catch {}

        $risk = 'Info'; $prob = 0; $reason = 'Работает'
        if ($svc.Status -ne 'Running') { $risk = 'High'; $prob = 80; $reason = 'Служба не запущена' }
        if ($startMode -eq 'Disabled') { $risk = 'Critical'; $prob = 95; $reason = 'Служба отключена' }

        $result = [PSCustomObject]@{
            'Тип'                 = 'Служба'
            'Имя'                 = $svcName
            'Путь'                = $svc.DisplayName
            'PID'                 = 'N/A'
            'Детали'              = $reason
            'Последнее изменение' = $lastEventTime
            'Статус'              = $svc.Status
            'Риск'                = $risk
            'Вероятность'         = $prob
            'Дней с изменения'    = 999
            'Цвет даты'           = 'gray'
            'Заметка даты'        = ''
            'Подпись'             = $startMode
            'SHA256'              = 'N/A'
            'Верификация'         = $processStartTime
        }
        $script:Results.Add($result)
        $script:ServiceResults.Add($result)
    }
    Write-Host ""
}

function Invoke-ScanNetwork {
    if (-not $config.scan.check_network) { return }
    $script:CurrentStep = 19
    $script:CurrentScanType = "Сканирование сети"
    Update-ProgressDisplay
    foreach ($conn in (Get-NetTCPConnection -ErrorAction SilentlyContinue |
                       Where-Object { $_.State -eq 'Established' -and $_.OwningProcess -ne 0 })) {
        $procName = $null; $procPath = $null
        try {
            $p = Get-Process -Id $conn.OwningProcess -ErrorAction SilentlyContinue
            if ($p) { $procName = $p.Name; try { $procPath = $p.Path } catch {} }
        } catch {}
        if (-not $procName) { continue }
        $det = Get-RiskLevel -InputString "$procName $procPath" -FilePath $procPath
        if ($det.Risk -eq 'Clean') { continue }
        $script:Results.Add([PSCustomObject]@{
            'Тип'                 = 'Сеть'
            'Имя'                 = $procName
            'Путь'                = "$($conn.RemoteAddress):$($conn.RemotePort)"
            'PID'                 = $conn.OwningProcess
            'Детали'              = $det.Reason
            'Последнее изменение' = 'N/A'
            'Статус'              = 'Установлено'
            'Риск'                = $det.Risk
            'Вероятность'         = $det.Probability
            'Дней с изменения'    = 999
            'Цвет даты'           = 'gray'
            'Заметка даты'        = ''
            'Подпись'             = 'N/A'
            'SHA256'              = 'N/A'
            'Верификация'         = 'N/A'
        })
    }
    Write-Host ""
}

function Invoke-ScanPrefetch {
    if (-not $config.scan.check_prefetch) { return }
    $script:CurrentStep = 20
    $script:CurrentScanType = "Сканирование Prefetch"
    Update-ProgressDisplay
    $prefetchPath = "$env:SystemRoot\Prefetch"
    if (Test-Path -LiteralPath $prefetchPath) {
        $pfFiles = Get-ChildItem -LiteralPath $prefetchPath -Filter "*.pf" -File -ErrorAction SilentlyContinue
        foreach ($pf in $pfFiles) {
            $script:TotalFilesScanned++
            $script:CurrentFileBeingScanned = $pf.Name
            Update-ProgressDisplay
            $parsed = ConvertFrom-PrefetchFile -FilePath $pf.FullName
            if (-not $parsed) { continue }
            $det = Get-RiskLevel -InputString $parsed.ExeName
            if ($det.Risk -eq 'Clean') { continue }
            $lastRun = if ($parsed.LastRun) { $parsed.LastRun } else { $pf.LastWriteTime }
            $days = Get-DaysSinceLastWrite $lastRun
            if ($days -gt $config.scan.prefetch_days) { continue }
            $fileExists = $false
            $possiblePaths = @(
                "$env:SystemRoot\System32\$($parsed.ExeName)",
                "$env:SystemRoot\SysWOW64\$($parsed.ExeName)",
                "$env:ProgramFiles\$($parsed.ExeName)",
                "$env:ProgramFiles(x86)\$($parsed.ExeName)"
            )
            foreach ($p in $possiblePaths) { if (Test-Path -LiteralPath $p) { $fileExists = $true; break } }
            $statusText = if ($fileExists) { 'Файл существует' } else { 'Файл не найден' }
            $result = [PSCustomObject]@{
                'Тип'                 = 'Prefetch'
                'Имя'                 = $parsed.ExeName
                'Путь'                = $pf.FullName
                'PID'                 = 'N/A'
                'Детали'              = $det.Reason
                'Последнее изменение' = if ($lastRun) { Format-DateShort $lastRun } else { 'N/A' }
                'Статус'              = $statusText
                'Риск'                = $det.Risk
                'Вероятность'         = $det.Probability
                'Дней с изменения'    = $days
                'Цвет даты'           = Get-DateColor $days
                'Заметка даты'        = Get-DateNote $days
                'Подпись'             = 'N/A'
                'SHA256'              = 'N/A'
                'Верификация'         = 'N/A'
            }
            $script:Results.Add($result)
            $script:PrefetchResults.Add($result)
        }
    }
    Write-Host ""
}

function Invoke-ScanAmcache {
    if (-not $config.scan.check_amcache) { return }
    $script:CurrentStep = 21
    $script:CurrentScanType = "Сканирование Amcache"
    Update-ProgressDisplay
    $amcachePath = "$env:SystemRoot\AppCompat\Programs\Amcache.hve"
    if (Test-Path -LiteralPath $amcachePath) {
        try {
            $regBackup = "$env:TEMP\Amcache_scan_$(Get-Random).hve"
            Copy-Item -LiteralPath $amcachePath -Destination $regBackup -Force -ErrorAction Stop
            $regLoad = "HKLM\TempAmcacheScan"
            $loadResult = reg.exe load $regLoad $regBackup 2>&1
            if ($LASTEXITCODE -eq 0) {
                try {
                    $amcacheRoot = "Registry::HKEY_LOCAL_MACHINE\TempAmcacheScan\Root\File"
                    if (Test-Path $amcacheRoot) {
                        Get-ChildItem -Path $amcacheRoot -ErrorAction SilentlyContinue | ForEach-Object {
                            $entries = Get-ChildItem -Path $_.PSPath -ErrorAction SilentlyContinue
                            foreach ($entry in $entries) {
                                $props = Get-ItemProperty -Path $entry.PSPath -ErrorAction SilentlyContinue
                                if (-not $props) { continue }
                                $filePath = $null
                                try { $filePath = $props.'15' } catch {}
                                if (-not $filePath) { continue }
                                $lastMod = 'N/A'
                                $skipByDate = $false
                                $dt = $null
                                try {
                                    if ($props.'17') {
                                        $dt = [DateTime]::FromFileTime($props.'17')
                                        $lastMod = Format-DateShort $dt
                                        if (((Get-Date) - $dt).TotalDays -gt $config.scan.amcache_days) { $skipByDate = $true }
                                    }
                                } catch {}
                                if ($skipByDate) { continue }
                                $script:TotalFilesScanned++
                                $script:CurrentFileBeingScanned = Split-Path $filePath -Leaf
                                if ($script:TotalFilesScanned % 20 -eq 0) { Update-ProgressDisplay }
                                $det = Get-RiskLevel -InputString $filePath -FilePath $filePath
                                if ($det.Risk -eq 'Clean') { continue }
                                $fileExists = Test-Path -LiteralPath $filePath -ErrorAction SilentlyContinue
                                $statusText = if ($fileExists) { 'Файл существует' } else { 'Файл не найден' }
                                $days = if ($dt) { Get-DaysSinceLastWrite $dt } else { 999 }
                                $result = [PSCustomObject]@{
                                    'Тип'                 = 'Amcache'
                                    'Имя'                 = Split-Path $filePath -Leaf
                                    'Путь'                = $filePath
                                    'PID'                 = 'N/A'
                                    'Детали'              = $det.Reason
                                    'Последнее изменение' = $lastMod
                                    'Статус'              = $statusText
                                    'Риск'                = $det.Risk
                                    'Вероятность'         = $det.Probability
                                    'Дней с изменения'    = $days
                                    'Цвет даты'           = Get-DateColor $days
                                    'Заметка даты'        = Get-DateNote $days
                                    'Подпись'             = 'N/A'
                                    'SHA256'              = 'N/A'
                                    'Верификация'         = 'N/A'
                                }
                                $script:Results.Add($result)
                                $script:AmcacheResults.Add($result)
                            }
                        }
                    }
                } finally {
                    [gc]::Collect(); [gc]::WaitForPendingFinalizers()
                    Start-Sleep -Milliseconds 200
                    reg.exe unload $regLoad 2>&1 | Out-Null
                }
            }
            Remove-Item -LiteralPath $regBackup -Force -ErrorAction SilentlyContinue
        } catch {}
    }
    Write-Host ""
}

function Invoke-ScanBam {
    if (-not $config.scan.check_bam) { return }
    $script:CurrentStep = 22
    $script:CurrentScanType = "Сканирование BAM"
    Update-ProgressDisplay
    $bamPaths = @(
        "HKLM:\SYSTEM\CurrentControlSet\Services\bam\State\UserSettings",
        "HKLM:\SYSTEM\CurrentControlSet\Services\bam\UserSettings"
    )
    foreach ($bamRoot in $bamPaths) {
        if (-not (Test-Path $bamRoot)) { continue }
        Get-ChildItem -Path $bamRoot -ErrorAction SilentlyContinue | ForEach-Object {
            $sid = $_.PSChildName
            $props = Get-ItemProperty -Path $_.PSPath -ErrorAction SilentlyContinue
            if (-not $props) { return }
            $props.PSObject.Properties |
                Where-Object { $_.Name -match '^\\Device\\HarddiskVolume' -or $_.Name -match '^\\Device' } |
                ForEach-Object {
                    $bamPath = $_.Name
                    $det = Get-RiskLevel -InputString $bamPath -FilePath $bamPath
                    if ($det.Risk -eq 'Clean') { return }
                    $lastRunTime = 'N/A'; $days = 999
                    try {
                        $filetime = [System.BitConverter]::ToInt64($_.Value, 0)
                        if ($filetime -gt 0) {
                            $dt = [DateTime]::FromFileTime($filetime)
                            $lastRunTime = Format-DateShort $dt
                            $days = Get-DaysSinceLastWrite $dt
                        }
                    } catch {}
                    $result = [PSCustomObject]@{
                        'Тип'                 = 'BAM'
                        'Имя'                 = Split-Path $bamPath -Leaf
                        'Путь'                = $bamPath
                        'PID'                 = $sid
                        'Детали'              = $det.Reason
                        'Последнее изменение' = $lastRunTime
                        'Статус'              = 'Запускался'
                        'Риск'                = $det.Risk
                        'Вероятность'         = $det.Probability
                        'Дней с изменения'    = $days
                        'Цвет даты'           = Get-DateColor $days
                        'Заметка даты'        = Get-DateNote $days
                        'Подпись'             = 'N/A'
                        'SHA256'              = 'N/A'
                        'Верификация'         = 'N/A'
                    }
                    $script:Results.Add($result)
                    $script:BamResults.Add($result)
                }
        }
    }
    Write-Host ""
}

function Invoke-ScanLogClearing {
    if (-not $config.scan.check_log_clearing) { return }
    $script:CurrentStep = 23
    $script:CurrentScanType = "Проверка очистки логов"
    Update-ProgressDisplay
    $logClearingEvents = @(
        @{ Log = 'Security'; Id = 1102; Desc = 'Security-журнал был очищен' },
        @{ Log = 'System';   Id = 104;  Desc = 'System-журнал был очищен' },
        @{ Log = 'Application'; Id = 104; Desc = 'Application-журнал был очищен' }
    )
    foreach ($evt in $logClearingEvents) {
        try {
            $events = Get-WinEvent -FilterHashtable @{
                LogName = $evt.Log
                Id = $evt.Id
            } -MaxEvents 20 -ErrorAction SilentlyContinue
            foreach ($e in $events) {
                $days = [math]::Floor(((Get-Date) - $e.TimeCreated).TotalDays)
                $result = [PSCustomObject]@{
                    'Тип'                 = 'Очистка логов'
                    'Имя'                 = "$($evt.Log) (ID $($evt.Id))"
                    'Путь'                = $e.ProviderName
                    'PID'                 = 'N/A'
                    'Детали'              = $evt.Desc
                    'Последнее изменение' = Format-DateShort $e.TimeCreated
                    'Статус'              = 'Обнаружено'
                    'Риск'                = 'Critical'
                    'Вероятность'         = 95
                    'Дней с изменения'    = $days
                    'Цвет даты'           = Get-DateColor $days
                    'Заметка даты'        = Get-DateNote $days
                    'Подпись'             = 'N/A'
                    'SHA256'              = 'N/A'
                    'Верификация'         = 'N/A'
                }
                $script:Results.Add($result)
                $script:LogClearingResults.Add($result)
            }
        } catch {}
    }
    Write-Host ""
}

function Invoke-ScanDefender {
    if (-not $config.scan.check_defender) { return }
    $script:CurrentStep = 24
    $script:CurrentScanType = "История Windows Defender"
    Update-ProgressDisplay
    try {
        $mpStatus = Get-MpComputerStatus -ErrorAction SilentlyContinue
        if ($mpStatus) {
            $detections = Get-MpThreatDetection -ErrorAction SilentlyContinue
            if ($detections) {
                foreach ($d in $detections) {
                    $resource = if ($d.Resources) { ($d.Resources -join '; ') } else { 'N/A' }
                    $det = Get-RiskLevel -InputString "$($d.ThreatID) $resource" -FilePath $resource
                    $days = 999; $dtStr = 'N/A'
                    if ($d.InitialDetectionTime) {
                        $dt = [DateTime]$d.InitialDetectionTime
                        $days = Get-DaysSinceLastWrite $dt
                        $dtStr = Format-DateShort $dt
                    }
                    $result = [PSCustomObject]@{
                        'Тип'                 = 'Windows Defender'
                        'Имя'                 = if ($d.ThreatID) { $d.ThreatID } else { 'Unknown' }
                        'Путь'                = $resource
                        'PID'                 = 'N/A'
                        'Детали'              = if ($det.Reason) { $det.Reason } else { 'Defender обнаружил угрозу' }
                        'Последнее изменение' = $dtStr
                        'Статус'              = if ($d.ThreatStatusID -eq 4) { 'Обработано' } else { 'Обнаружено' }
                        'Риск'                = 'Critical'
                        'Вероятность'         = 95
                        'Дней с изменения'    = $days
                        'Цвет даты'           = Get-DateColor $days
                        'Заметка даты'        = Get-DateNote $days
                        'Подпись'             = 'N/A'
                        'SHA256'              = 'N/A'
                        'Верификация'         = 'N/A'
                    }
                    $script:Results.Add($result)
                    $script:DefenderResults.Add($result)
                }
            }
        }
    } catch {}
    Write-Host ""
}

function Invoke-ScanHosts {
    if (-not $config.scan.check_hosts) { return }
    $script:CurrentStep = 25
    $script:CurrentScanType = "Проверка hosts"
    Update-ProgressDisplay
    $hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"
    if (Test-Path -LiteralPath $hostsPath) {
        try {
            $hostsContent = Get-Content -LiteralPath $hostsPath -ErrorAction SilentlyContinue
            $lineNum = 0
            $hostsDate = (Get-Item -LiteralPath $hostsPath).LastWriteTime
            $hostsDays = Get-DaysSinceLastWrite $hostsDate
            foreach ($line in $hostsContent) {
                $lineNum++
                $trimmed = $line.Trim()
                if ([string]::IsNullOrWhiteSpace($trimmed)) { continue }
                if ($trimmed.StartsWith('#')) { continue }
                foreach ($pattern in @('grim','intave','matrix','vulcan','spartan','nocheatplus','aac','anticheat','themis','polar','guardian','sentinel','watchdog','hypixel','minemen','pvp.land','mc-central','cubecraft','funcraft','holyworld','reallyworld','mineplex','faithfulmc','germancraft','minecraftservers','mojang','minecraft.net','session.minecraft.net')) {
                    if ($trimmed -match [regex]::Escape($pattern)) {
                        $result = [PSCustomObject]@{
                            'Тип'                 = 'hosts-блокировка'
                            'Имя'                 = $pattern
                            'Путь'                = "Строка $lineNum"
                            'PID'                 = 'N/A'
                            'Детали'              = "hosts-файл блокирует домен '$pattern'"
                            'Последнее изменение' = Format-DateShort $hostsDate
                            'Статус'              = 'Обнаружено'
                            'Риск'                = 'Critical'
                            'Вероятность'         = 90
                            'Дней с изменения'    = $hostsDays
                            'Цвет даты'           = Get-DateColor $hostsDays
                            'Заметка даты'        = Get-DateNote $hostsDays
                            'Подпись'             = 'N/A'
                            'SHA256'              = 'N/A'
                            'Верификация'         = $trimmed
                        }
                        $script:Results.Add($result)
                        $script:HostsResults.Add($result)
                        break
                    }
                }
            }
        } catch {}
    }
    Write-Host ""
}

function Invoke-ScanMode {
    Write-Host ""
    Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "  Minecraft Cheat Detector v4.0 by 976hk" -ForegroundColor Cyan
    Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "  PS: $($PSVersionTable.PSVersion) · Admin: $(if($isAdmin){'Да'}else{'Нет'}) · Modrinth: $(if(-not $SkipModrinth -and $config.modrinth.enabled){'Да'}else{'Нет'})" -ForegroundColor DarkGray
    Write-Host "════════════════════════════════════════════`n" -ForegroundColor DarkGray

    Invoke-ScanProcesses
    Invoke-ScanJvmArgs
    Invoke-ScanFiles
    Invoke-ScanMinecraft
    Invoke-ScanConfigs
    Invoke-ScanCyrillicConfigs
    Invoke-ScanLatestLog
    Invoke-ScanOptionsTxt
    Invoke-ScanHsErr
    Invoke-ScanScreenshots
    Invoke-ScanReplays
    Invoke-ScanCrashReports
    Invoke-ScanStats
    Invoke-ScanServersDat
    Invoke-ScanProfiles
    Invoke-ScanDll
    Invoke-ScanRegistry
    Invoke-ScanServices
    Invoke-ScanNetwork
    Invoke-ScanPrefetch
    Invoke-ScanAmcache
    Invoke-ScanBam
    Invoke-ScanLogClearing
    Invoke-ScanDefender
    Invoke-ScanHosts

    $script:CurrentStep = 26
    $script:CurrentScanType = "Завершено"
    $script:CurrentFileBeingScanned = ""
    Update-ProgressDisplay
    Write-Host "`n"

    $dedup = @{}
    $uniqueResults = [System.Collections.Generic.List[object]]::new()
    foreach ($r in $script:Results) {
        $key = if ($r.SHA256 -and $r.SHA256 -ne 'N/A' -and $r.SHA256.Length -gt 20) { $r.SHA256 } else { "$($r.Тип)|$($r.Имя)|$($r.Путь)" }
        if (-not $dedup.ContainsKey($key)) { $dedup[$key] = $true; $uniqueResults.Add($r) }
    }
    $script:Results = $uniqueResults
}
function Invoke-LogSearch {
    param([string]$Needle, [int]$DaysLimit = 14)

    $script:LogSearchResults.Clear()
    $cutoff = (Get-Date).AddDays(-$DaysLimit)

    if ([string]::IsNullOrWhiteSpace($Needle)) {
        Write-Host "Пустой запрос." -ForegroundColor Red
        return
    }

    $queryRaw = $Needle.Trim().Trim('"').Trim("'")
    $queryNorm = ConvertTo-NormalizedText -Text $queryRaw
    $queryLower = $queryNorm.ToLower()
    $queryTokens = ConvertTo-FuzzyTokens -Text $queryRaw

    Write-Host "Запрос: `"$queryRaw`"" -ForegroundColor White
    if ($queryNorm -ne $queryRaw) {
        Write-Host "Нормализовано: `"$queryNorm`"" -ForegroundColor DarkGray
    }
    if ($queryTokens.Count -gt 0) {
        Write-Host "Токены: $($queryTokens -join ', ')" -ForegroundColor DarkGray
    }
    Write-Host ""

    $logs = Get-LauncherLogFiles -DaysLimit $DaysLimit
    if ($logs.Count -eq 0) {
        Write-Host "Логи за последние $DaysLimit дней не найдены." -ForegroundColor Yellow
        Write-Host "Проверенные пути:" -ForegroundColor DarkGray
        foreach ($p in $config.scan.launcher_log_paths) {
            $exp = [Environment]::ExpandEnvironmentVariables($p)
            $exists = Test-Path -LiteralPath $exp
            $mark = if ($exists) { '[+]' } else { '[-]' }
            $color = if ($exists) { 'Green' } else { 'DarkGray' }
            Write-Host "  $mark $exp" -ForegroundColor $color
        }
        return
    }

    Write-Host "Найдено логов за $DaysLimit дней: $($logs.Count)" -ForegroundColor DarkGray

    $totalMatches = 0
    $filesWithMatches = 0

    foreach ($log in $logs) {
        $fileMatches = [System.Collections.Generic.List[object]]::new()

        if ($log.Extension.ToLower() -eq '.gz') {
            try {
                $fs = [System.IO.File]::OpenRead($log.FullName)
                $gz = New-Object System.IO.Compression.GZipStream($fs, [System.IO.Compression.CompressionMode]::Decompress)
                $sr = New-Object System.IO.StreamReader($gz, [System.Text.Encoding]::UTF8)
                $lines = @()
                while (-not $sr.EndOfStream) { $lines += $sr.ReadLine() }
                $sr.Close(); $gz.Close(); $fs.Close()
            } catch { continue }
        } else {
            $lines = Read-LogFileUtf8 -Path $log.FullName
        }

        if ($null -eq $lines) { continue }

        $lineNum = 0
        foreach ($line in $lines) {
            $lineNum++
            if ([string]::IsNullOrWhiteSpace($line)) { continue }

            $lineNorm = ConvertTo-NormalizedText -Text $line
            $lineLower = $lineNorm.ToLower()

            $matchType = $null

            if ($lineLower.Contains($queryLower)) {
                $matchType = 'exact'
            } else {
                if ($queryTokens.Count -ge 2) {
                    $hits = 0
                    foreach ($tok in $queryTokens) {
                        if ($lineLower.Contains($tok)) { $hits++ }
                    }
                    $needed = [math]::Max(2, [math]::Ceiling($queryTokens.Count * 0.7))
                    if ($hits -ge $needed) { $matchType = "fuzzy($hits/$($queryTokens.Count))" }
                }
            }

            if ($matchType) {
                $fileMatches.Add([PSCustomObject]@{
                    LineNumber = $lineNum
                    Line       = $line.Trim()
                    MatchType  = $matchType
                })
            }
        }

        if ($fileMatches.Count -gt 0) {
            $filesWithMatches++
            $totalMatches += $fileMatches.Count
            foreach ($m in $fileMatches) {
                $script:LogSearchResults.Add([PSCustomObject]@{
                    File       = $log.FullName
                    FileName   = $log.Name
                    LineNumber = $m.LineNumber
                    Line       = $m.Line
                    MatchType  = $m.MatchType
                    Modified   = Format-DateShort $log.LastWriteTime
                    ModifiedDT = $log.LastWriteTime
                })
            }
        }
    }

    Write-Host ""
    Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "  РЕЗУЛЬТАТЫ ПОИСКА" -ForegroundColor Cyan
    Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "  Логов проверено:       $($logs.Count)" -ForegroundColor White
    Write-Host "  Логов с совпадениями:  $filesWithMatches" -ForegroundColor Yellow
    Write-Host "  Всего совпадений:      $totalMatches" -ForegroundColor Yellow
    Write-Host ""

    if ($totalMatches -eq 0) {
        Write-Host "Совпадений не найдено." -ForegroundColor Green
        Write-Host ""
        Write-Host "Возможные причины:" -ForegroundColor DarkGray
        Write-Host "  • фраза есть, но в логе за пределами $DaysLimit дней" -ForegroundColor DarkGray
        Write-Host "  • фраза разбита переносом строки в исходном файле" -ForegroundColor DarkGray
        Write-Host "  • лаунчер хранит логи в другой папке (добавь путь в launcher_log_paths конфига)" -ForegroundColor DarkGray
        return
    }

    $byFile = $script:LogSearchResults | Group-Object -Property File
    foreach ($group in $byFile) {
        Write-Host "────────────────────────────────────────────" -ForegroundColor DarkGray
        Write-Host " ФАЙЛ: $($group.Name)" -ForegroundColor Cyan
        Write-Host " Совпадений: $($group.Count) · Изменён: $(Format-DateShort $group.Group[0].ModifiedDT)" -ForegroundColor DarkGray
        Write-Host "────────────────────────────────────────────" -ForegroundColor DarkGray
        foreach ($m in $group.Group) {
            $line = $m.Line
            if ($line.Length -gt 220) { $line = $line.Substring(0, 220) + '...' }
            $tag = if ($m.MatchType -eq 'exact') { '' } else { " [$($m.MatchType)]" }
            Write-Host ("  [строка {0}]{1} " -f $m.LineNumber, $tag) -NoNewline -ForegroundColor Yellow
            Write-Host $line -ForegroundColor White
        }
        Write-Host ""
    }
}

function Save-LogSearchToTxt {
    param([string]$Needle)
    if ($script:LogSearchResults.Count -eq 0) { return }
    $outPath = [Environment]::GetFolderPath('Desktop')
    $ts = Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
    $safe = ($Needle -replace '[^\w\-]','_')
    $txtFile = Join-Path $outPath "log_search_${safe}_$ts.txt"
    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add("Log Search: $Needle")
    $lines.Add("Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
    $lines.Add("Period: last $($config.scan.log_scan_days) days")
    $lines.Add("Matches: $($script:LogSearchResults.Count)")
    $lines.Add("")
    $byFile = $script:LogSearchResults | Group-Object -Property File
    foreach ($group in $byFile) {
        $lines.Add("=== FILE: $($group.Name) ===")
        $lines.Add("Modified: $(Format-DateShort $group.Group[0].ModifiedDT)")
        foreach ($m in $group.Group) {
            $tag = if ($m.MatchType -eq 'exact') { '' } else { " [$($m.MatchType)]" }
            $lines.Add("[line $($m.LineNumber)]$tag $($m.Line)")
        }
        $lines.Add("")
    }
    try {
        [System.IO.File]::WriteAllLines($txtFile, $lines, [System.Text.UTF8Encoding]::new($true))
        Write-Host "Сохранено: $txtFile" -ForegroundColor Green
    } catch { Write-Host "Ошибка сохранения: $($_.Exception.Message)" -ForegroundColor Red }
}

function Show-ScanResults {
    $fileResults = $script:Results | Where-Object {
        $_.Тип -notin @('Процесс','Java процесс','Служба','DLL','Неизвестный мод','Легитимный мод','Требует ручной проверки','Prefetch','Amcache','BAM','Очистка логов','Windows Defender','hosts-блокировка','След конфига','JVM-аргумент','latest.log','options.txt','Манифест JAR','hs_err_pid','Скриншот','Реплей','crash-report','Статистика','Профиль/сервер','Профили лаунчера','Кириллический конфиг')
    }
    $critical   = @($fileResults | Where-Object { $_.Риск -eq 'Critical'   -and $_.'Дней с изменения' -le $config.scan.days_recent })
    $high       = @($fileResults | Where-Object { $_.Риск -eq 'High'       -and $_.'Дней с изменения' -le $config.scan.days_recent })
    $suspicious = @($fileResults | Where-Object { $_.Риск -eq 'Suspicious' -and $_.'Дней с изменения' -le $config.scan.days_recent })
    $old        = @($fileResults | Where-Object { $_.'Дней с изменения' -gt $config.scan.days_recent })

    Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "  РЕЗУЛЬТАТЫ" -ForegroundColor Cyan
    Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "  Просканировано:        $($script:TotalFilesScanned)" -ForegroundColor White
    Write-Host "  Пропущено:             $($script:FilesSkipped)" -ForegroundColor DarkGray
    Write-Host "  Хешей посчитано:       $($script:FilesHashed)" -ForegroundColor DarkGray
    Write-Host "  Критические:           $($critical.Count)"   -ForegroundColor Red
    Write-Host "  Высокий риск:          $($high.Count)"       -ForegroundColor DarkRed
    Write-Host "  Подозрительные:        $($suspicious.Count)" -ForegroundColor Yellow
    Write-Host "  Старые:                $($old.Count)"        -ForegroundColor Gray
    Write-Host "  Неизвестные моды:      $($script:UnknownModResults.Count)" -ForegroundColor Magenta
    Write-Host "  Легитимные моды:       $($script:VerifiedModResults.Count)" -ForegroundColor Cyan
    Write-Host "  Требуют проверки:      $($script:SuspiciousModResults.Count)" -ForegroundColor Red
    Write-Host "  Следы конфигов:        $($script:ConfigTraceResults.Count)" -ForegroundColor Yellow
    Write-Host "  Кириллические конфиги: $($script:CyrillicConfigResults.Count)" -ForegroundColor Yellow
    Write-Host "  JVM-аргументы:         $($script:JvmArgResults.Count)" -ForegroundColor Magenta
    Write-Host "  latest.log:            $($script:LatestLogResults.Count)" -ForegroundColor Magenta
    Write-Host "  options.txt:           $($script:OptionsTxtResults.Count)" -ForegroundColor Magenta
    Write-Host "  Манифесты JAR:         $($script:ManifestResults.Count)" -ForegroundColor Magenta
    Write-Host "  hs_err_pid:            $($script:HsErrResults.Count)" -ForegroundColor Magenta
    Write-Host "  Скриншоты:             $($script:ScreenshotResults.Count)" -ForegroundColor Magenta
    Write-Host "  Реплеи:                $($script:ReplayResults.Count)" -ForegroundColor Magenta
    Write-Host "  Crash-reports:         $($script:CrashReportResults.Count)" -ForegroundColor Magenta
    Write-Host "  Статистика:            $($script:StatsResults.Count)" -ForegroundColor Magenta
    Write-Host "  servers.dat/profiles:  $($script:ServersDatResults.Count)" -ForegroundColor Magenta
    Write-Host "  Профили лаунчера:      $($script:ProfilesResults.Count)" -ForegroundColor Magenta
    Write-Host "  Prefetch:              $($script:PrefetchResults.Count)" -ForegroundColor Cyan
    Write-Host "  Amcache:               $($script:AmcacheResults.Count)" -ForegroundColor Cyan
    Write-Host "  BAM:                   $($script:BamResults.Count)" -ForegroundColor Cyan
    Write-Host "  Очистка логов:         $($script:LogClearingResults.Count)" -ForegroundColor Red
    Write-Host "  Windows Defender:      $($script:DefenderResults.Count)" -ForegroundColor Red
    Write-Host "  hosts-блокировки:      $($script:HostsResults.Count)" -ForegroundColor Red
    Write-Host "  Службы:                $($script:ServiceResults.Count)" -ForegroundColor Blue
    Write-Host "  Всего найдено:         $($script:Results.Count)" -ForegroundColor White

    return @{
        Critical   = $critical
        High       = $high
        Suspicious = $suspicious
        Old        = $old
    }
}

function Save-ReportFiles {
    param([hashtable]$Stats)

    Write-Host "`nВведите путь для сохранения (Enter = рабочий стол):" -ForegroundColor Yellow
    $OutputPath = Read-Host
    if ([string]::IsNullOrWhiteSpace($OutputPath)) { $OutputPath = [Environment]::GetFolderPath('Desktop') }
    $OutputPath = $OutputPath.Trim('"').Trim("'")
    if ([string]::IsNullOrWhiteSpace($OutputPath)) { $OutputPath = [Environment]::GetFolderPath('Desktop') }
    if (-not (Test-Path -LiteralPath $OutputPath)) {
        try { New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null }
        catch { $OutputPath = [Environment]::GetFolderPath('Desktop') }
    }

    $ts = Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
    $csvFile  = Join-Path $OutputPath "$($config.output.filename_prefix)_$ts.csv"
    $htmlFile = Join-Path $OutputPath "$($config.output.filename_prefix)_$ts.html"
    $jsonFile = Join-Path $OutputPath "$($config.output.filename_prefix)_$ts.json"

    if ($config.output.save_csv) {
        try {
            $csvContent = $script:Results | ConvertTo-Csv -NoTypeInformation -Delimiter ';'
            [System.IO.File]::WriteAllLines($csvFile, $csvContent, [System.Text.UTF8Encoding]::new($true))
            Write-Host "CSV: $csvFile" -ForegroundColor Green
        } catch { Write-Host "Ошибка CSV: $($_.Exception.Message)" -ForegroundColor Red }
    }

    if ($config.output.save_json) {
        try {
            $script:Results | ConvertTo-Json -Depth 5 | Out-File -FilePath $jsonFile -Encoding UTF8
            Write-Host "JSON: $jsonFile" -ForegroundColor Green
        } catch { Write-Host "Ошибка JSON: $($_.Exception.Message)" -ForegroundColor Red }
    }

    return @{ Html = $htmlFile; Csv = $csvFile; Json = $jsonFile }
}

function New-HtmlReport {
    param([hashtable]$Stats, [string]$HtmlFile)

    $critical   = $Stats.Critical
    $high       = $Stats.High
    $suspicious = $Stats.Suspicious

    $enc = { param($s) if ($null -eq $s) { '' } else { [System.Web.HttpUtility]::HtmlEncode([string]$s) } }
    $sb = [System.Text.StringBuilder]::new(400000)

    [void]$sb.Append(@"
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cheat Detector Report · 976hk</title>
<link rel="icon" type="image/svg+xml" href="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'><defs><linearGradient id='g' x1='0' y1='0' x2='1' y2='1'><stop offset='0' stop-color='%2358a6ff'/><stop offset='1' stop-color='%23bc8cff'/></linearGradient></defs><rect width='32' height='32' rx='8' fill='url(%23g)'/><text x='16' y='23' font-family='Segoe UI,sans-serif' font-size='20' font-weight='800' fill='%230d1117' text-anchor='middle'>X</text></svg>">
<style>
:root{--bg:#0d1117;--bg-soft:#161b22;--bg-card:#1c2128;--border:#30363d;--text:#e6edf3;--text-dim:#8b949e;--accent:#58a6ff;--danger:#f85149;--warn:#d29922;--purple:#bc8cff;--magenta:#ff6ac1}
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:'Segoe UI',Roboto,-apple-system,sans-serif;background:radial-gradient(1200px 600px at 10% -10%, rgba(88,166,255,.12), transparent 60%),radial-gradient(900px 500px at 100% 0%, rgba(188,140,255,.10), transparent 55%),var(--bg);color:var(--text);line-height:1.65;padding:32px 16px 80px;min-height:100vh}
.wrap{max-width:1100px;margin:0 auto}
.header{text-align:center;padding:44px 20px 32px;border:1px solid var(--border);border-radius:20px;background:linear-gradient(180deg, rgba(28,33,40,.9), rgba(13,17,23,.6));box-shadow:0 8px 24px rgba(0,0,0,.5);position:relative;overflow:hidden;margin-bottom:26px}
.header::before{content:"";position:absolute;inset:0;background:linear-gradient(90deg,transparent,rgba(88,166,255,.08),transparent);animation:shine 6s linear infinite}
@keyframes shine{0%{transform:translateX(-100%)}100%{transform:translateX(100%)}}
h1{font-size:clamp(22px,3.5vw,32px);font-weight:700;background:linear-gradient(90deg,#58a6ff,#bc8cff,#3fb950);-webkit-background-clip:text;background-clip:text;color:transparent;position:relative}
.meta{color:var(--text-dim);font-size:14px;margin-top:10px;position:relative}
.meta b{color:#e6edf3}
.author{display:inline-flex;align-items:center;gap:8px;margin-top:14px;padding:6px 14px 6px 6px;border-radius:999px;background:linear-gradient(135deg, rgba(88,166,255,.18), rgba(188,140,255,.18));border:1px solid rgba(88,166,255,.45);font-size:13px;font-weight:600;position:relative}
.avatar{width:24px;height:24px;border-radius:50%;background:linear-gradient(135deg,#58a6ff,#bc8cff);display:grid;place-items:center;font-size:8px;font-weight:800;color:#0d1117}
.nick{background:linear-gradient(90deg,#58a6ff,#bc8cff);-webkit-background-clip:text;background-clip:text;color:transparent;font-weight:700}
.summary{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:12px;margin-bottom:26px}
.stat{background:var(--bg-card);border:1px solid var(--border);border-radius:14px;padding:18px 20px;transition:.25s}
.stat:hover{border-color:var(--accent);transform:translateY(-2px)}
.stat .lbl{font-size:12px;color:var(--text-dim);text-transform:uppercase;letter-spacing:.6px;font-weight:600;display:block;margin-bottom:6px}
.stat .val{font-size:28px;font-weight:800;line-height:1}
.stat.red .val{color:#f85149}.stat.orange .val{color:#ff8c42}.stat.yellow .val{color:#d29922}
.stat.cyan .val{color:#39d0d8}.stat.blue .val{color:#58a6ff}.stat.purple .val{color:#bc8cff}
.stat.gray .val{color:#8b949e}.stat.magenta .val{color:#ff6ac1}
.group{background:var(--bg-card);border:1px solid var(--border);border-radius:14px;margin-bottom:14px;overflow:hidden;transition:.25s}
.group:hover{border-color:var(--accent)}
.group summary{display:flex;align-items:center;gap:12px;padding:16px 20px;cursor:pointer;user-select:none;list-style:none;font-size:16px;font-weight:600;transition:.2s}
.group summary::-webkit-details-marker{display:none}
.group summary:hover{background:rgba(88,166,255,.06)}
.group summary .ico{width:36px;height:36px;flex:0 0 36px;display:grid;place-items:center;border-radius:10px;background:rgba(88,166,255,.12);font-size:17px}
.group summary .title{flex:1}
.group summary .count{font-size:13px;color:var(--text-dim);background:var(--bg-soft);border:1px solid var(--border);padding:3px 10px;border-radius:99px;font-weight:600}
.group summary .chev{color:var(--text-dim);font-size:13px;transition:.3s}
.group[open] summary .chev{transform:rotate(180deg)}
.group .inner{padding:0 20px 20px}
.item{background:var(--bg-soft);border-left:4px solid var(--border);border-radius:8px;padding:14px 16px;margin-bottom:8px;transition:.2s}
.item:hover{background:#1f2630}
.item.date-red{border-left-color:#f85149}
.item.date-orange{border-left-color:#ff8c42}
.item.date-yellow{border-left-color:#d29922}
.item.date-gray{border-left-color:#484f58}
.item.svc-run{border-left-color:#3fb950}
.item.svc-stop{border-left-color:#f85149}
.item.java{border-left-color:#bc8cff}
.item.inject{border-left-color:#ff6ac1}
.item.unknown-mod{border-left-color:#d29922}
.item.verified-mod{border-left-color:#3fb950;background:rgba(63,185,80,.06)}
.item.suspicious-mod{border-left-color:#f85149;background:rgba(248,81,73,.10)}
.item.prefetch{border-left-color:#39d0d8}
.item.amcache{border-left-color:#58a6ff}
.item.bam{border-left-color:#bc8cff}
.item.logclear{border-left-color:#f85149;background:rgba(248,81,73,.12)}
.item.defender{border-left-color:#f85149;background:rgba(248,81,73,.12)}
.item.hosts{border-left-color:#ff8c42;background:rgba(255,140,66,.10)}
.item.config-trace{border-left-color:#d29922;background:rgba(210,153,34,.06)}
.item.jvm{border-left-color:#ff6ac1;background:rgba(255,106,193,.08)}
.item.logkw{border-left-color:#bc8cff;background:rgba(188,140,255,.08)}
.item.opts{border-left-color:#39d0d8;background:rgba(57,208,216,.08)}
.item.manifest{border-left-color:#ff6ac1;background:rgba(255,106,193,.08)}
.item.hserr{border-left-color:#f85149;background:rgba(248,81,73,.10)}
.item.screenshot{border-left-color:#d29922;background:rgba(210,153,34,.06)}
.item.replay{border-left-color:#bc8cff;background:rgba(188,140,255,.08)}
.item.crash{border-left-color:#f85149;background:rgba(248,81,73,.10)}
.item.stats{border-left-color:#ff8c42;background:rgba(255,140,66,.08)}
.item.profiles{border-left-color:#58a6ff;background:rgba(88,166,255,.06)}
.item.cyrillic{border-left-color:#d29922;background:rgba(210,153,34,.06)}
.item .name{font-size:15px;font-weight:700;color:#e6edf3;margin-bottom:6px;display:flex;align-items:center;gap:8px;flex-wrap:wrap}
.item .path{font-family:'Cascadia Code','Consolas',monospace;font-size:12.5px;color:#79c0ff;background:rgba(0,0,0,.35);padding:6px 9px;border-radius:6px;word-break:break-all;margin:6px 0;cursor:pointer;position:relative;transition:.2s}
.item .path:hover{background:rgba(88,166,255,.12)}
.item .path.copied::after{content:"Скопировано";position:absolute;right:8px;top:50%;transform:translateY(-50%);background:#3fb950;color:#0d1117;font-size:10px;font-weight:700;padding:2px 7px;border-radius:5px}
.item .desc{font-size:13.5px;color:#d29922;font-style:italic;margin:5px 0}
.item .meta{font-size:12.5px;color:var(--text-dim);margin:5px 0}
.item .meta b{color:#e6edf3;font-weight:600}
.badge{display:inline-block;font-size:11px;font-weight:700;padding:2px 8px;border-radius:6px;text-transform:uppercase;letter-spacing:.4px}
.badge.signed{background:rgba(63,185,80,.18);color:#3fb950;border:1px solid rgba(63,185,80,.4)}
.badge.unsigned{background:rgba(248,81,73,.18);color:#f85149;border:1px solid rgba(248,81,73,.4)}
.badge.prob-high{background:rgba(248,81,73,.18);color:#f85149}
.badge.prob-med{background:rgba(255,140,66,.18);color:#ff8c42}
.badge.prob-low{background:rgba(210,153,34,.18);color:#d29922}
.badge.unknown{background:rgba(210,153,34,.2);color:#d29922;border:1px solid rgba(210,153,34,.5)}
.badge.verified{background:rgba(63,185,80,.2);color:#3fb950;border:1px solid rgba(63,185,80,.5)}
.badge.not-found{background:rgba(248,81,73,.2);color:#f85149;border:1px solid rgba(248,81,73,.5)}
.badge.exists{background:rgba(63,185,80,.2);color:#3fb950;border:1px solid rgba(63,185,80,.5)}
.badge.date-red{background:rgba(248,81,73,.2);color:#f85149;border:1px solid rgba(248,81,73,.5)}
.badge.date-orange{background:rgba(255,140,66,.2);color:#ff8c42;border:1px solid rgba(255,140,66,.5)}
.badge.date-yellow{background:rgba(210,153,34,.2);color:#d29922;border:1px solid rgba(210,153,34,.5)}
.badge.date-gray{background:rgba(139,148,158,.15);color:#8b949e;border:1px solid rgba(139,148,158,.4)}
.warning-box{background:rgba(210,153,34,.08);border-left:3px solid #d29922;border-radius:8px;padding:12px 16px;margin-bottom:14px;font-size:14px;color:#e6edf3}
.warning-box.danger{background:rgba(248,81,73,.1);border-left-color:#f85149}
.warning-box.info{background:rgba(88,166,255,.08);border-left-color:#58a6ff}
.help-icon{display:inline-flex;align-items:center;justify-content:center;width:20px;height:20px;border-radius:50%;background:rgba(88,166,255,.2);border:1px solid rgba(88,166,255,.5);color:#58a6ff;font-size:12px;font-weight:800;cursor:help;position:relative;flex:0 0 20px;user-select:none}
.help-icon .tip{visibility:hidden;opacity:0;width:340px;background:#1c2128;color:#e6edf3;text-align:left;border-radius:10px;padding:12px 16px;position:absolute;z-index:100;top:130%;right:0;font-size:13px;font-weight:400;line-height:1.5;box-shadow:0 8px 24px rgba(0,0,0,.7);border:1px solid #30363d;transition:.2s;pointer-events:none}
.help-icon:hover .tip{visibility:visible;opacity:1}
.help-icon .tip b{color:#58a6ff;display:block;margin-bottom:6px;font-size:13px}
.help-icon .tip .ok{color:#3fb950;display:block;margin-top:6px}
.help-icon .tip .bad{color:#f85149;display:block;margin-top:6px}
.footer{text-align:center;color:var(--text-dim);font-size:13px;margin-top:40px;padding-top:20px;border-top:1px solid var(--border)}
.footer b{background:linear-gradient(90deg,#58a6ff,#bc8cff);-webkit-background-clip:text;background-clip:text;color:transparent}
</style>
<script>
function copyPath(el){navigator.clipboard.writeText(el.textContent).then(()=>{el.classList.add('copied');setTimeout(()=>el.classList.remove('copied'),1200)})}
</script>
</head>
<body>
<div class="wrap">
<div class="header">
<h1>Minecraft Cheat Detector</h1>
<div class="meta">Отчёт от <b>$(Get-Date -Format 'dd.MM.yy HH:mm')</b> · Просканировано: <b>$($script:TotalFilesScanned)</b> · Уникальных находок: <b>$($script:Results.Count)</b></div>
<div class="author"><div class="avatar">xtwont</div><span>by</span><span class="nick">976hk</span></div>
</div>
<div class="summary">
<div class="stat red"><span class="lbl">Критические</span><div class="val">$($critical.Count)</div></div>
<div class="stat orange"><span class="lbl">Высокий риск</span><div class="val">$($high.Count)</div></div>
<div class="stat yellow"><span class="lbl">Подозрительные</span><div class="val">$($suspicious.Count)</div></div>
<div class="stat magenta"><span class="lbl">Неизвестные моды</span><div class="val">$($script:UnknownModResults.Count)</div></div>
<div class="stat cyan"><span class="lbl">Легитимные моды</span><div class="val">$($script:VerifiedModResults.Count)</div></div>
<div class="stat red"><span class="lbl">Требуют проверки</span><div class="val">$($script:SuspiciousModResults.Count)</div></div>
<div class="stat yellow"><span class="lbl">Следы конфигов</span><div class="val">$($script:ConfigTraceResults.Count)</div></div>
<div class="stat yellow"><span class="lbl">Кириллица</span><div class="val">$($script:CyrillicConfigResults.Count)</div></div>
<div class="stat magenta"><span class="lbl">JVM-аргументы</span><div class="val">$($script:JvmArgResults.Count)</div></div>
<div class="stat purple"><span class="lbl">latest.log</span><div class="val">$($script:LatestLogResults.Count)</div></div>
<div class="stat cyan"><span class="lbl">options.txt</span><div class="val">$($script:OptionsTxtResults.Count)</div></div>
<div class="stat magenta"><span class="lbl">Манифесты JAR</span><div class="val">$($script:ManifestResults.Count)</div></div>
<div class="stat red"><span class="lbl">hs_err_pid</span><div class="val">$($script:HsErrResults.Count)</div></div>
<div class="stat yellow"><span class="lbl">Скриншоты</span><div class="val">$($script:ScreenshotResults.Count)</div></div>
<div class="stat purple"><span class="lbl">Реплеи</span><div class="val">$($script:ReplayResults.Count)</div></div>
<div class="stat red"><span class="lbl">Crash-reports</span><div class="val">$($script:CrashReportResults.Count)</div></div>
<div class="stat orange"><span class="lbl">Статистика</span><div class="val">$($script:StatsResults.Count)</div></div>
<div class="stat blue"><span class="lbl">servers/profiles</span><div class="val">$($script:ServersDatResults.Count)</div></div>
<div class="stat blue"><span class="lbl">Профили</span><div class="val">$($script:ProfilesResults.Count)</div></div>
<div class="stat cyan"><span class="lbl">Prefetch</span><div class="val">$($script:PrefetchResults.Count)</div></div>
<div class="stat blue"><span class="lbl">Amcache</span><div class="val">$($script:AmcacheResults.Count)</div></div>
<div class="stat purple"><span class="lbl">BAM</span><div class="val">$($script:BamResults.Count)</div></div>
<div class="stat red"><span class="lbl">Очистка логов</span><div class="val">$($script:LogClearingResults.Count)</div></div>
<div class="stat red"><span class="lbl">Defender</span><div class="val">$($script:DefenderResults.Count)</div></div>
<div class="stat orange"><span class="lbl">hosts</span><div class="val">$($script:HostsResults.Count)</div></div>
<div class="stat gray"><span class="lbl">Службы</span><div class="val">$($script:ServiceResults.Count)</div></div>
</div>
"@)

    if ($script:LogClearingResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(248,81,73,.15)'>!</div><div class='title'>Очистка журналов событий</div><span class='count'>$($script:LogClearingResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Кто-то очистил журналы Windows.<span class='bad'>Это может быть попыткой скрыть следы.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box danger'>Обнаружены события очистки журналов. Это <b>может быть признаком попытки скрыть следы</b>.</div>")
        foreach ($item in $script:LogClearingResults) {
            [void]$sb.Append("<div class='item logclear date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-high'>Очищено</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Время очистки:</b> $($item.'Последнее изменение') · $($item.'Заметка даты') · <b>Провайдер:</b> $(& $enc $item.Путь)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:DefenderResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(248,81,73,.15)'>D</div><div class='title'>Windows Defender — история обнаружений</div><span class='count'>$($script:DefenderResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Windows Defender уже находил угрозы в системе.<span class='bad'>Если Defender нашёл файл — серьёзный повод для проверки.</span><span class='ok'>Если запись старая (30+ дней) и файл уже удалён — предупреди игрока.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box danger'>Windows Defender уже обнаруживал эти файлы как угрозы.</div>")
        foreach ($item in $script:DefenderResults) {
            [void]$sb.Append("<div class='item defender date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-high'>Обнаружено</span> <span class='badge'>$($item.Статус)</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Обнаружено:</b> $($item.'Последнее изменение') · $($item.'Заметка даты')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:HostsResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(255,140,66,.15)'>H</div><div class='title'>hosts — блокировка доменов</div><span class='count'>$($script:HostsResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Через файл hosts были заблокированы домены античитов или серверов.<span class='bad'>Блокировка античит-доменов — серьёзный повод для проверки.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box danger'>Обнаружена блокировка доменов через hosts.</div>")
        foreach ($item in $script:HostsResults) {
            [void]$sb.Append("<div class='item hosts date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-high'>Заблокирован</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Строка:</b> $(& $enc $item.Верификация) · <b>Файл изменён:</b> $($item.'Последнее изменение') · $($item.'Заметка даты')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:JvmArgResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(255,106,193,.15)'>J</div><div class='title'>Подозрительные JVM-аргументы</div><span class='count'>$($script:JvmArgResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>В командной строке java найдены аргументы -javaagent, -agentpath и подобные.<span class='bad'>Такие аргументы используются для инжекта агентов (читов) в JVM.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box danger'>Найдены JVM-аргументы, характерные для инжекта агентов.</div>")
        foreach ($item in $script:JvmArgResults) {
            [void]$sb.Append("<div class='item jvm'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-med'>JVM</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Аргументы:</b> $(& $enc $item.Верификация)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:LatestLogResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(188,140,255,.15)'>L</div><div class='title'>latest.log — упоминания читов</div><span class='count'>$($script:LatestLogResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>В latest.log/debug.log найдены упоминания известных читов или JVM-агентов.<span class='bad'>Упоминание имени чита в логе — серьёзный повод для проверки.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box danger'>В логах лаунчера найдены упоминания читов.</div>")
        foreach ($item in $script:LatestLogResults) {
            [void]$sb.Append("<div class='item logkw date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-med'>$(& $enc $item.Верификация)</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Строка:</b> $($item.PID) · <b>Изменён:</b> $($item.'Последнее изменение')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:OptionsTxtResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(57,208,216,.15)'>O</div><div class='title'>options.txt — аномальные настройки</div><span class='count'>$($script:OptionsTxtResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>В options.txt игрока аномальные значения (gamma > 1.0 = fullbright, fov 130+ или <=40, низкий renderDistance, mouseSensitivity=0, toggleCrouch/Sprint).<span class='bad'>Fullbright через gamma — часто признак xray-модов.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box'>Найдены аномальные настройки в options.txt.</div>")
        foreach ($item in $script:OptionsTxtResults) {
            [void]$sb.Append("<div class='item opts date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-med'>$($item.Вероятность)%</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение') · $($item.'Заметка даты')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:ManifestResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(255,106,193,.15)'>M</div><div class='title'>Подозрительные манифесты JAR</div><span class='count'>$($script:ManifestResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>В fabric.mod.json / mods.toml найдены подозрительные слова (killaura, aimbot, xray и т.п.).<span class='bad'>Такой мод может быть читом или содержать чит-функции.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box danger'>В манифестах модов найдены подозрительные слова.</div>")
        foreach ($item in $script:ManifestResults) {
            [void]$sb.Append("<div class='item manifest date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-high'>Манифест</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Тип:</b> $($item.PID) · <b>Изменён:</b> $($item.'Последнее изменение')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:HsErrResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(248,81,73,.15)'>J</div><div class='title'>hs_err_pid — дампы JVM</div><span class='count'>$($script:HsErrResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>JVM-крэш-дампы содержат параметры запуска и классы. Если там упоминаются агенты или читы — это улика.<span class='bad'>Агенты через -javaagent часто палятся в hs_err.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box danger'>В JVM-дампах найдены подозрительные строки.</div>")
        foreach ($item in $script:HsErrResults) {
            [void]$sb.Append("<div class='item hserr date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-high'>Дамп</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение') · $($item.'Заметка даты')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:ScreenshotResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(210,153,34,.15)'>S</div><div class='title'>Скриншоты — подозрительные имена</div><span class='count'>$($script:ScreenshotResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Имя файла скриншота содержит слово cheat/aura/xray/etc.<span class='bad'>Возможно, игрок делал скрин с читом и не переименовал.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $script:ScreenshotResults) {
            [void]$sb.Append("<div class='item screenshot date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение') · $($item.'Заметка даты')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:ReplayResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(188,140,255,.15)'>R</div><div class='title'>Реплеи — моды в метаданных</div><span class='count'>$($script:ReplayResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>В метаданных реплея перечислены моды, которые были у игрока во время записи.<span class='bad'>Если там чит — это прямая улика.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box danger'>В метаданных реплея найдены моды-читы.</div>")
        foreach ($item in $script:ReplayResults) {
            [void]$sb.Append("<div class='item replay date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-high'>Replay</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:CrashReportResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(248,81,73,.15)'>C</div><div class='title'>Crash-reports — классы читов</div><span class='count'>$($script:CrashReportResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>В стектрейсе краш-репорта найдены классы или имена читов.<span class='bad'>Чит крашил игру — остался след в отчёте.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box danger'>В crash-reports найдены классы читов.</div>")
        foreach ($item in $script:CrashReportResults) {
            [void]$sb.Append("<div class='item crash date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-high'>Crash</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:StatsResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(255,140,66,.15)'>A</div><div class='title'>Статистика — аномалии</div><span class='count'>$($script:StatsResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Аномальные соотношения в statistics/advancements (walk vs play_time, sprint=0, deaths=0).<span class='bad'>Может говорить о телепорте, god mode, анти-спринт хаке.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $script:StatsResults) {
            [void]$sb.Append("<div class='item stats date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-med'>Stats</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:ServersDatResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(88,166,255,.15)'>V</div><div class='title'>servers.dat / profiles</div><span class='count'>$($script:ServersDatResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>В файлах серверов/профилей найдены подозрительные слова.<span class='bad'>Возможно, игрок добавлял серверы с названиями читов.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $script:ServersDatResults) {
            [void]$sb.Append("<div class='item profiles date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:ProfilesResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(88,166,255,.15)'>P</div><div class='title'>Профили лаунчера</div><span class='count'>$($script:ProfilesResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Много профилей в launcher_profiles.json.<span class='ok'>Не чит, но игрок часто меняет версии/моды — может быть связано с тестами читов.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $script:ProfilesResults) {
            [void]$sb.Append("<div class='item profiles'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-low'>$($item.Вероятность)%</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:CyrillicConfigResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(210,153,34,.15)'>К</div><div class='title'>Кириллические конфиги</div><span class='count'>$($script:CyrillicConfigResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Имя файла конфига содержит кириллицу.<span class='bad'>Часто встречается у читов от русскоязычных авторов.</span><span class='ok'>Но может быть и у легитимных модов.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $script:CyrillicConfigResults) {
            [void]$sb.Append("<div class='item cyrillic date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-low'>Кириллица</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:SuspiciousModResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(248,81,73,.15)'>!</div><div class='title'>Моды, требующие ручной проверки</div><span class='count'>$($script:SuspiciousModResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Эти моды не являются читами по своей природе, но используются для автоматизации действий (инвентарь, бой, движение), которую часто запрещают сервера.<span class='bad'>Требует ручной проверки и уточнения у игрока.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box danger'>Эти моды требуют ручной проверки. Они могут использоваться для автоматизации действий, которую часто запрещают сервера.</div>")
        foreach ($item in $script:SuspiciousModResults) {
            [void]$sb.Append("<div class='item suspicious-mod date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge prob-high'>Подозрительный</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение') · $($item.'Заметка даты') · <b>SHA256:</b> $($item.SHA256)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:ConfigTraceResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(210,153,34,.15)'>C</div><div class='title'>Следы конфигов</div><span class='count'>$($script:ConfigTraceResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>В папке config остались файлы от модов, которые, возможно, уже удалены из mods.<span class='ok'>Это остаток от мода. Мод мог быть удалён, но конфиг остался.</span><span class='bad'>Если конфиг от чита — это след его использования.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box'>Остатки конфигов от модов. Мод может быть удалён, но конфиг остался.</div>")
        foreach ($item in $script:ConfigTraceResults) {
            [void]$sb.Append("<div class='item config-trace date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение') · $($item.'Заметка даты')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:PrefetchResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(57,208,216,.15)'>P</div><div class='title'>Prefetch — следы запусков</div><span class='count'>$($script:PrefetchResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Эти программы запускались на ПК. Файл мог быть удалён, но Prefetch-запись остаётся.<span class='bad'>Свежая запись (до 14 дней) + файл не найден — серьёзный повод для проверки.</span><span class='ok'>Если запись старая (30+ дней) — возможно, игрок давно удалил чит.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box'>Эти программы запускались на компьютере. Файл мог быть удалён, перемещён или переименован.</div>")
        foreach ($item in $script:PrefetchResults) {
            $statusBadge = if ($item.Статус -eq 'Файл не найден') { 'not-found' } else { 'exists' }
            [void]$sb.Append("<div class='item prefetch date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge $statusBadge'>$($item.Статус)</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Последний запуск:</b> $($item.'Последнее изменение') · $($item.'Заметка даты')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:AmcacheResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(88,166,255,.15)'>A</div><div class='title'>Amcache — история программ</div><span class='count'>$($script:AmcacheResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Amcache хранит пути и хеши всех запускавшихся программ.<span class='bad'>Свежая запись + файл не найден = повод для проверки.</span><span class='ok'>Старая запись (месяц+) — просто след.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box'>Amcache хранит историю всех запускавшихся программ. Даже если файл удалён, запись остаётся.</div>")
        foreach ($item in $script:AmcacheResults) {
            $statusBadge = if ($item.Статус -eq 'Файл не найден') { 'not-found' } else { 'exists' }
            [void]$sb.Append("<div class='item amcache date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge $statusBadge'>$($item.Статус)</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Последнее изменение:</b> $($item.'Последнее изменение') · $($item.'Заметка даты')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:BamResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(188,140,255,.15)'>B</div><div class='title'>BAM — последние запуски</div><span class='count'>$($script:BamResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>BAM хранит последние запущенные exe. Часто чистится отдельно от Prefetch.<span class='bad'>Если в BAM есть чит, а в Prefetch его нет — кто-то чистил Prefetch.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box'>BAM хранит последние запущенные exe.</div>")
        foreach ($item in $script:BamResults) {
            [void]$sb.Append("<div class='item bam date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Последний запуск:</b> $($item.'Последнее изменение') · $($item.'Заметка даты') · <b>SID:</b> $($item.PID)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:UnknownModResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(210,153,34,.15)'>?</div><div class='title'>Неизвестные моды</div><span class='count'>$($script:UnknownModResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Мод не найден в whitelist и на Modrinth.<span class='ok'>Это не значит, что это чит. Попроси игрока дать ссылку на мод.</span><span class='bad'>Если игрок не может дать ссылку — требует ручной проверки.</span></div></div><span class='chev'>v</span></summary><div class='inner'><div class='warning-box'>Эти моды не найдены в whitelist и на Modrinth. Требует ручной проверки.</div>")
        foreach ($item in $script:UnknownModResults) {
            [void]$sb.Append("<div class='item unknown-mod date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge unknown'>Не подтверждён</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение') · $($item.'Заметка даты') · <b>SHA256:</b> $($item.SHA256)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:VerifiedModResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(63,185,80,.15)'>+</div><div class='title'>Легитимные моды</div><span class='count'>$($script:VerifiedModResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Эти моды найдены в whitelist или на Modrinth.<span class='ok'>Это легитимные моды.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $script:VerifiedModResults) {
            [void]$sb.Append("<div class='item verified-mod'><div class='name'>$(& $enc $item.Имя) <span class='badge verified'>Легитимный</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='meta'>$(& $enc $item.Детали)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($critical.Count -gt 0 -or $high.Count -gt 0 -or $suspicious.Count -gt 0) {
        $newFindings = @($critical) + @($high) + @($suspicious)
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(248,81,73,.15)'>!</div><div class='title'>Подозрительные совпадения</div><span class='count'>$($newFindings.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Файлы, чьи имена или содержимое совпали с известными читами.<span class='bad'>Это может быть читом. Требует ручной проверки.</span><span class='ok'>Если файл подписан и от вендора — проверь дополнительно.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $newFindings) {
            $probClass = if ($item.Вероятность -ge 90) {'prob-high'} elseif ($item.Вероятность -ge 70) {'prob-med'} else {'prob-low'}
            $sigClass  = if ($item.Подпись -eq 'Подписано') {'signed'} else {'unsigned'}
            [void]$sb.Append("<div class='item date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge $probClass'>$($item.Вероятность)%</span> <span class='badge $sigClass'>$($item.Подпись)</span> <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение') · $($item.'Заметка даты') · <b>SHA256:</b> $($item.SHA256)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:ServiceResults.Count -gt 0) {
        $run  = @($script:ServiceResults | Where-Object { $_.Статус -eq 'Running' }).Count
        $stop = $script:ServiceResults.Count - $run
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(88,166,255,.15)'>S</div><div class='title'>Системные службы</div><span class='count'>$($script:ServiceResults.Count) · Запущено: $run · Остановлено: $stop</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Проверка служб, критичных для SS-проверки.<span class='bad'>Disabled — серьёзный повод для проверки.</span><span class='ok'>Running + Automatic = норма.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $script:ServiceResults) {
            $cls = if ($item.Статус -eq 'Running') {'svc-run'} else {'svc-stop'}
            $ico = if ($item.Статус -eq 'Running') {'[+]'} else {'[-]'}
            $sigClass = if ($item.Риск -eq 'Critical') {'prob-high'} elseif ($item.Риск -eq 'High') {'prob-med'} else {'prob-low'}
            [void]$sb.Append("<div class='item $cls'><div class='name'>$ico $(& $enc $item.Имя) <span class='badge $sigClass'>$($item.Риск)</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='desc'>$(& $enc $item.Детали)</div><div class='meta'><b>Состояние:</b> $($item.Статус) · <b>Тип запуска:</b> $($item.Подпись)</div><div class='meta'><b>Работает с:</b> $($item.Верификация) · <b>Последнее событие:</b> $($item.'Последнее изменение')</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:InjectResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(255,106,193,.15)'>I</div><div class='title'>DLL Инжекты</div><span class='count'>$($script:InjectResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>DLL с подозрительным именем (inject, hook, cheat) в Temp или .minecraft.<span class='bad'>DLL в Temp с именем inject/hook/cheat — серьёзный повод.</span><span class='ok'>Если DLL подписана — проверь дополнительно.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $script:InjectResults) {
            $sigClass = if ($item.Подпись -eq 'Подписано') {'signed'} else {'unsigned'}
            [void]$sb.Append("<div class='item inject date-$($item.'Цвет даты')'><div class='name'>$(& $enc $item.Имя) <span class='badge date-$($item.'Цвет даты')'>$($item.'Дней с изменения') дн.</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='meta'><b>Изменён:</b> $($item.'Последнее изменение') · $($item.'Заметка даты') · <span class='badge $sigClass'>$($item.Подпись)</span> · SHA256: $($item.SHA256)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:JavaProcessResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(188,140,255,.15)'>J</div><div class='title'>Java процессы</div><span class='count'>$($script:JavaProcessResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Запущенные процессы java/javaw. Это нормально для Minecraft.<span class='ok'>Это легитимные процессы.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $script:JavaProcessResults) {
            $sigClass = if ($item.Подпись -eq 'Подписано') {'signed'} else {'unsigned'}
            [void]$sb.Append("<div class='item java'><div class='name'>$(& $enc $item.Имя) <span class='badge'>PID $($item.PID)</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='meta'><span class='badge $sigClass'>$($item.Подпись)</span> · SHA256: $($item.SHA256)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    if ($script:ProcessResults.Count -gt 0) {
        [void]$sb.Append("<details class='group'><summary><div class='ico' style='background:rgba(88,166,255,.15)'>P</div><div class='title'>Процессы</div><span class='count'>$($script:ProcessResults.Count)</span><div class='help-icon'>?<div class='tip'><b>Что это значит</b>Запущенные процессы, не попавшие в whitelist.<span class='ok'>Многие из них — обычные программы.</span><span class='bad'>Если процесс совпадает с именем чита и не подписан — повод для проверки.</span></div></div><span class='chev'>v</span></summary><div class='inner'>")
        foreach ($item in $script:ProcessResults) {
            $sigClass = if ($item.Подпись -eq 'Подписано') {'signed'} else {'unsigned'}
            [void]$sb.Append("<div class='item'><div class='name'>$(& $enc $item.Имя) <span class='badge'>PID $($item.PID)</span></div><div class='path' onclick='copyPath(this)'>$(& $enc $item.Путь)</div><div class='meta'><span class='badge $sigClass'>$($item.Подпись)</span> · SHA256: $($item.SHA256)</div></div>")
        }
        [void]$sb.Append("</div></details>")
    }

    [void]$sb.Append("<div class='footer'>Minecraft Cheat Detector v4.0 · <b>976hk</b> · $(Get-Date -Format 'dd.MM.yy HH:mm')</div></div></body></html>")

    try {
        [System.IO.File]::WriteAllText($HtmlFile, $sb.ToString(), [System.Text.UTF8Encoding]::new($false))
        Write-Host "HTML: $HtmlFile" -ForegroundColor Green
        if ($config.output.open_html_after_scan -and (Test-Path -LiteralPath $HtmlFile)) {
            Start-Process $HtmlFile
        }
    } catch { Write-Host "Ошибка HTML: $($_.Exception.Message)" -ForegroundColor Red }
}

function Invoke-FullScan {
    Invoke-ScanMode
    $stats = Show-ScanResults

    if ($script:Results.Count -eq 0 -and $script:UnknownModResults.Count -eq 0) {
        Write-Host "`nПодозрительные файлы не обнаружены." -ForegroundColor Green
        return
    }

    Write-Host ""
    $save = Read-Host "Сохранить отчёт? (y/n)"
    if ($save -match '^(y|yes|д|да)$') {
        $files = Save-ReportFiles -Stats $stats
        New-HtmlReport -Stats $stats -HtmlFile $files.Html
    }

    Write-Host "`n════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "  Сканирование завершено" -ForegroundColor Cyan
    Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
}

function Start-InteractiveMenu {
    while ($true) {
        Write-Host ""
        Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
        Write-Host "  Minecraft Cheat Detector v4.0 by 976hk" -ForegroundColor Cyan
        Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
        Write-Host "  Что вы хотите сделать?" -ForegroundColor White
        Write-Host ""
        Write-Host "  [scan]   — запустить полное сканирование системы" -ForegroundColor Cyan
        Write-Host "  [search] — найти фразу или никнейм в логах лаунчеров" -ForegroundColor Cyan
        Write-Host "  [exit]   — выйти" -ForegroundColor DarkGray
        Write-Host ""

        $choice = (Read-Host "Введите команду").Trim().ToLower()

        switch ($choice) {
            'scan'   {
                Invoke-FullScan
                Write-Host ""
                $again = Read-Host "Вернуться в меню? (y/n, по умолчанию y)"
                if ($again -match '^(n|no|н|нет)$') { return }
            }
            's'      {
                Invoke-FullScan
                Write-Host ""
                $again = Read-Host "Вернуться в меню? (y/n, по умолчанию y)"
                if ($again -match '^(n|no|н|нет)$') { return }
            }
            'search' {
                Invoke-SearchLoop
            }
            'e'      {
                Invoke-SearchLoop
            }
            'exit'   { return }
            'q'      { return }
            default  {
                Write-Host "Неизвестная команда: $choice" -ForegroundColor Red
            }
        }
    }
}

function Invoke-SearchLoop {
    while ($true) {
        Write-Host ""
        Write-Host "Что искать? (фраза, никнейм, название чита). Enter — назад в меню." -ForegroundColor Yellow
        $q = Read-Host "Запрос"
        if ([string]::IsNullOrWhiteSpace($q)) { return }

        Write-Host ""
        Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
        Write-Host "  Поиск по логам лаунчеров" -ForegroundColor Cyan
        Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
        Write-Host "  Запрос:   $q" -ForegroundColor White
        Write-Host "  Период:   последние $($config.scan.log_scan_days) дней" -ForegroundColor White
        Write-Host "════════════════════════════════════════════" -ForegroundColor DarkGray
        Write-Host ""

        Invoke-LogSearch -Needle $q -DaysLimit $config.scan.log_scan_days

        if ($script:LogSearchResults.Count -gt 0) {
            Write-Host ""
            Write-Host "Что дальше?" -ForegroundColor Cyan
            Write-Host "  [1] Найти что-то ещё" -ForegroundColor White
            Write-Host "  [2] Сохранить результаты в TXT" -ForegroundColor White
            Write-Host "  [3] Запустить scan" -ForegroundColor White
            Write-Host "  [0] Назад в меню" -ForegroundColor DarkGray
            $next = (Read-Host "Выбор").Trim().ToLower()

            switch ($next) {
                '1' { continue }
                '2' {
                    Save-LogSearchToTxt -Needle $q
                    Write-Host ""
                    Write-Host "Что дальше?" -ForegroundColor Cyan
                    Write-Host "  [1] Найти что-то ещё" -ForegroundColor White
                    Write-Host "  [3] Запустить scan" -ForegroundColor White
                    Write-Host "  [0] Назад в меню" -ForegroundColor DarkGray
                    $next2 = (Read-Host "Выбор").Trim().ToLower()
                    switch ($next2) {
                        '1' { continue }
                        '3' {
                            Invoke-FullScan
                            Write-Host ""
                            $after = Read-Host "Вернуться к поиску? (y/n)"
                            if ($after -match '^(y|yes|д|да)$') { continue } else { return }
                        }
                        '0' { return }
                        default { continue }
                    }
                }
                '3' {
                    Invoke-FullScan
                    Write-Host ""
                    $after = Read-Host "Вернуться к поиску? (y/n)"
                    if ($after -match '^(y|yes|д|да)$') { continue } else { return }
                }
                '0' { return }
                default { continue }
            }
        } else {
            Write-Host ""
            $again = Read-Host "Попробовать другой запрос? (y/n, по умолчанию y)"
            if ($again -match '^(n|no|н|нет)$') { return }
        }
    }
}

if ([string]::IsNullOrWhiteSpace($Mode)) {
    Start-InteractiveMenu
} else {
    switch ($Mode) {
        'scan'   {
            Invoke-FullScan
        }
        'search' {
            if ([string]::IsNullOrWhiteSpace($Query)) {
                Write-Host "Что искать?" -ForegroundColor Yellow
                $Query = Read-Host "Запрос"
            }
            if (-not [string]::IsNullOrWhiteSpace($Query)) {
                Invoke-LogSearch -Needle $Query -DaysLimit $config.scan.log_scan_days
            }
        }
    }
}