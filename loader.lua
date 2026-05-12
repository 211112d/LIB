
loadstring(game:HttpGet(""))()

task.wait(3)


local Settings = loadstring(game:HttpGet(""))()
local Constants = loadstring(game:HttpGet(""))()
local Utils = loadstring(game:HttpGet(""))()
local Aimbot = loadstring(game:HttpGet(""))()
local ESP = loadstring(game:HttpGet(""))()
local Movement = loadstring(game:HttpGet(""))()
local Features = loadstring(game:HttpGet(""))()
local AntiCheat = loadstring(game:HttpGet(""))()


repeat task.wait() until library and library.flags

local window = library:window({
    name = "KFC", 
    suffix = ".hook", 
    gameInfo = string.format("Cryptic : %s", (game.PlaceId == 4991214437 and "Town") or "Universal")
})

-- =============================================
-- AIMBOT TAB
-- =============================================
local AimMain, AimVisuals = window:tab({
    name = "Aimbot",
    icon = GetImage("Aimlock.png"),
    tabs = {"Main", "Visuals"}
})

do
    local col = AimMain:column({})
    local sec = col:section({
        name = "Aimbot", 
        size = 1, 
        icon = GetImage("Aimlock.png"), 
        fading = true
    })
    
    sec:toggle({
        name = "Master Aimbot",
        flag = "MasterAimbot",
        default = Settings:Get("MasterAimbot"),
        callback = function(bool) Settings:Set("MasterAimbot", bool) end
    })
    
    sec:toggle({
        name = "Enabled",
        flag = "AimbotEnabled",
        default = Settings:Get("AimbotEnabled"),
        callback = function(bool) Settings:Set("AimbotEnabled", bool) end
    })
    
    sec:dropdown({
        name = "Aim Part",
        flag = "AimPart",
        items = Constants.AimbotParts,
        default = Settings:Get("AimPart"),
        callback = function(val) Settings:Set("AimPart", val) end
    })
    
    sec:slider({
        name = "Smoothness",
        flag = "AimbotSmoothness",
        min = 1, max = 20,
        default = Settings:Get("AimbotSmoothness"),
        callback = function(val) Settings:Set("AimbotSmoothness", val) end
    })
    
    sec:slider({
        name = "FOV",
        flag = "AimbotFov",
        min = 30, max = 500,
        default = Settings:Get("AimbotFov"),
        suffix = "px",
        callback = function(val) Settings:Set("AimbotFov", val) end
    })
    
    sec:toggle({
        name = "Wall Check",
        flag = "WallCheck",
        default = Settings:Get("WallCheck"),
        callback = function(bool) Settings:Set("WallCheck", bool) end
    })
    
    sec:toggle({
        name = "Team Check",
        flag = "TeamCheck",
        default = Settings:Get("TeamCheck"),
        callback = function(bool) Settings:Set("TeamCheck", bool) end
    })
    
    sec:toggle({
        name = "Sticky Aim",
        flag = "StickyAim",
        default = Settings:Get("StickyAim"),
        callback = function(bool) Settings:Set("StickyAim", bool) end
    })
    
    sec:toggle({
        name = "Prediction",
        flag = "Prediction",
        default = Settings:Get("Prediction"),
        callback = function(bool) Settings:Set("Prediction", bool) end
    })
    
    sec:toggle({
        name = "Auto Shoot",
        flag = "AutoShoot",
        default = Settings:Get("AutoShoot"),
        callback = function(bool) Settings:Set("AutoShoot", bool) end
    })
    
    sec:toggle({
        name = "Target AI",
        flag = "AimbotTargetAi",
        default = Settings:Get("AimbotTargetAi"),
        callback = function(bool) Settings:Set("AimbotTargetAi", bool) end
    })
    
    sec:toggle({
        name = "Target Players",
        flag = "AimbotPlayer",
        default = Settings:Get("AimbotPlayer"),
        callback = function(bool) Settings:Set("AimbotPlayer", bool) end,
        seperator = true
    })
end

do
    local col = AimVisuals:column({})
    local sec = col:section({
        name = "Visuals",
        size = 1,
        icon = GetImage("FieldOfView2.png")
    })
    
    sec:toggle({
        name = "Show FOV Circle",
        flag = "FovVisible",
        default = Settings:Get("FovVisible"),
        callback = function(bool) Settings:Set("FovVisible", bool) end
    })
    
    sec:colorpicker({
        name = "FOV Color",
        flag = "FovColor",
        color = Settings:Get("FovColor"),
        callback = function(color) Settings:Set("FovColor", color) end
    })
    
    sec:toggle({
        name = "Show Tracer",
        flag = "AimbotTracer",
        default = Settings:Get("AimbotTracer"),
        callback = function(bool) Settings:Set("AimbotTracer", bool) end
    })
    
    sec:colorpicker({
        name = "Tracer Color",
        flag = "AimbotTracerColor",
        color = Settings:Get("AimbotTracerColor"),
        callback = function(color) Settings:Set("AimbotTracerColor", color) end,
        seperator = true
    })
end

-- =============================================
-- ESP TAB
-- =============================================
local ESPPlayers, ESPWorld = window:tab({
    name = "ESP",
    icon = GetImage("ESP.png"),
    tabs = {"Players", "World"}
})

do
    local col = ESPPlayers:column({})
    local sec = col:section({
        name = "Player ESP",
        size = 1,
        icon = GetImage("ESP.png"),
        fading = true
    })
    
    sec:toggle({
        name = "Master ESP",
        flag = "MasterESP",
        default = false,
        callback = function(bool) Settings:Set("MasterESP", bool) end
    })
    
    sec:toggle({
        name = "Show Box",
        flag = "ShowBox",
        default = true,
        callback = function(bool) Settings:Set("ShowBox", bool) end
    })
    
    sec:toggle({
        name = "Show Name",
        flag = "ShowName",
        default = true,
        callback = function(bool) Settings:Set("ShowName", bool) end
    })
    
    sec:toggle({
        name = "Show Distance",
        flag = "ShowDistance",
        default = true,
        callback = function(bool) Settings:Set("ShowDistance", bool) end
    })
    
    sec:toggle({
        name = "Show Health",
        flag = "ShowHealth",
        default = true,
        callback = function(bool) Settings:Set("ShowHealth", bool) end
    })
    
    sec:toggle({
        name = "Show Chams",
        flag = "ShowChams",
        default = false,
        callback = function(bool) Settings:Set("ShowChams", bool) end
    })
    
    sec:slider({
        name = "Max Distance",
        flag = "MaxDistance",
        min = 50, max = 2000,
        default = 500,
        suffix = "s",
        callback = function(val) Settings:Set("MaxDistance", val) end,
        seperator = true
    })
end

do
    local col = ESPWorld:column({})
    local sec = col:section({
        name = "World ESP",
        size = 1,
        icon = GetImage("World.png")
    })
    
    sec:toggle({
        name = "Dropped Items",
        flag = "DroppedItemESP",
        default = Settings:Get("DroppedItemESP"),
        callback = function(bool) Settings:Set("DroppedItemESP", bool) end
    })
    
    sec:toggle({
        name = "Corpses",
        flag = "CorpseESP",
        default = Settings:Get("CorpseESP"),
        callback = function(bool) Settings:Set("CorpseESP", bool) end
    })
    
    sec:toggle({
        name = "Containers",
        flag = "ContainerESP",
        default = Settings:Get("ContainerESP"),
        callback = function(bool) Settings:Set("ContainerESP", bool) end
    })
    
    sec:toggle({
        name = "Exit Locations",
        flag = "ExitESP",
        default = Settings:Get("ExitESP"),
        callback = function(bool) Settings:Set("ExitESP", bool) end
    })
    
    sec:toggle({
        name = "Quest Items",
        flag = "QuestESP",
        default = Settings:Get("QuestESP"),
        callback = function(bool) Settings:Set("QuestESP", bool) end
    })
    
    sec:toggle({
        name = "Vehicles",
        flag = "VehicleTag",
        default = Settings:Get("VehicleTag"),
        callback = function(bool) Settings:Set("VehicleTag", bool) end,
        seperator = true
    })
end

-- =============================================
-- MOVEMENT TAB
-- =============================================
local MoveMain = window:tab({
    name = "Movement",
    icon = GetImage("Node.png"),
    tabs = {"Main"}
})

do
    local col = MoveMain:column({})
    local sec = col:section({
        name = "Movement",
        size = 1,
        icon = GetImage("Node.png")
    })
    
    sec:toggle({
        name = "Speed Hack",
        flag = "SpeedHack",
        default = Settings:Get("SpeedHack"),
        callback = function(bool) Settings:Set("SpeedHack", bool) end
    })
    
    sec:slider({
        name = "Speed",
        flag = "SpeedHackSpeed",
        min = 17, max = 100,
        default = Settings:Get("SpeedHackSpeed"),
        callback = function(val) Settings:Set("SpeedHackSpeed", val) end
    })
    
    sec:toggle({
        name = "Infinity Jump",
        flag = "InfinityJump",
        default = Settings:Get("InfinityJump"),
        callback = function(bool) Settings:Set("InfinityJump", bool) end
    })
    
    sec:toggle({
        name = "Bunny Hop",
        flag = "BunnyHop",
        default = Settings:Get("BunnyHop"),
        callback = function(bool) Settings:Set("BunnyHop", bool) end
    })
    
    sec:toggle({
        name = "No Fall Damage",
        flag = "NoFall",
        default = Settings:Get("NoFall"),
        callback = function(bool) Settings:Set("NoFall", bool) end,
        seperator = true
    })
end

-- =============================================
-- WORLD TAB
-- =============================================
local WorldT = window:tab({
    name = "World",
    icon = GetImage("World.png"),
    tabs = {"Main"}
})

do
    local col = WorldT:column({})
    local sec = col:section({
        name = "World",
        size = 1,
        icon = GetImage("World.png")
    })
    
    sec:toggle({
        name = "Full Brightness",
        flag = "FullBrightness",
        default = Settings:Get("FullBrightness"),
        callback = function(bool) Settings:Set("FullBrightness", bool) end
    })
    
    sec:toggle({
        name = "No Fog",
        flag = "NoFog",
        default = Settings:Get("NoFog"),
        callback = function(bool) Settings:Set("NoFog", bool) end
    })
    
    sec:toggle({
        name = "X-Ray",
        flag = "Xray",
        default = Settings:Get("Xray"),
        callback = function(bool) Settings:Set("Xray", bool) end
    })
    
    sec:toggle({
        name = "No Landmines",
        flag = "NoLandMine",
        default = Settings:Get("NoLandMine"),
        callback = function(bool) Settings:Set("NoLandMine", bool) end,
        seperator = true
    })
end


library:init_config(window)

Aimbot:Start()
ESP:Start()
Movement:Start()
Features:Start()
AntiCheat:Start()

print("KFC Hook - Fully Loaded!")
