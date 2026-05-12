-- Load UI first
loadstring(game:HttpGet("https://raw.githubusercontent.com/211112d/LIB/refs/heads/main/Ui.lua"))()

-- Wait for UI to fully initialize
task.wait(3)

-- Load all modules
local Settings = loadstring(game:HttpGet("https://raw.githubusercontent.com/211112d/LIB/refs/heads/main/Settings.lua"))()
local Constants = loadstring(game:HttpGet("https://raw.githubusercontent.com/211112d/LIB/refs/heads/main/Constants.lua"))()
local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/211112d/LIB/refs/heads/main/Utils.lua"))()
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/211112d/LIB/refs/heads/main/Aimbot.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/211112d/LIB/refs/heads/main/ESP.lua"))()
local Movement = loadstring(game:HttpGet("https://raw.githubusercontent.com/211112d/LIB/refs/heads/main/Movement.lua"))()
local Features = loadstring(game:HttpGet("https://raw.githubusercontent.com/211112d/LIB/refs/heads/main/Features.lua"))()
local AntiCheat = loadstring(game:HttpGet("https://raw.githubusercontent.com/211112d/LIB/refs/heads/main/AntiCheat.lua"))()

-- Wait for library to be fully ready
repeat task.wait() until library and library.flags

print("Creating window...")

-- Create the window
local window = library:window({
    name = "KFC", 
    suffix = ".hook", 
    gameInfo = "Cryptic : universal"
})

print("Adding Aimbot tab...")

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
        default = Settings:Get("MasterAimbot") or false,
        callback = function(bool) Settings:Set("MasterAimbot", bool) end
    })
    
    sec:toggle({
        name = "Enabled",
        flag = "AimbotEnabled",
        default = Settings:Get("AimbotEnabled") or false,
        callback = function(bool) Settings:Set("AimbotEnabled", bool) end
    })
    
    sec:dropdown({
        name = "Aim Part",
        flag = "AimPart",
        items = Constants.AimbotParts or {"Head", "Torso"},
        default = Settings:Get("AimPart") or "Head",
        callback = function(val) Settings:Set("AimPart", val) end
    })
    
    sec:slider({
        name = "Smoothness",
        flag = "AimbotSmoothness",
        min = 1, max = 20,
        default = Settings:Get("AimbotSmoothness") or 1,
        callback = function(val) Settings:Set("AimbotSmoothness", val) end
    })
    
    sec:slider({
        name = "FOV",
        flag = "AimbotFov",
        min = 30, max = 500,
        default = Settings:Get("AimbotFov") or 100,
        suffix = "px",
        callback = function(val) Settings:Set("AimbotFov", val) end
    })
    
    sec:toggle({
        name = "Wall Check",
        flag = "WallCheck",
        default = Settings:Get("WallCheck") or false,
        callback = function(bool) Settings:Set("WallCheck", bool) end
    })
    
    sec:toggle({
        name = "Team Check",
        flag = "TeamCheck",
        default = Settings:Get("TeamCheck") or false,
        callback = function(bool) Settings:Set("TeamCheck", bool) end
    })
    
    sec:toggle({
        name = "Prediction",
        flag = "Prediction",
        default = Settings:Get("Prediction") or false,
        callback = function(bool) Settings:Set("Prediction", bool) end
    })
    
    sec:toggle({
        name = "Auto Shoot",
        flag = "AutoShoot",
        default = Settings:Get("AutoShoot") or false,
        callback = function(bool) Settings:Set("AutoShoot", bool) end
    })
    
    sec:toggle({
        name = "Target AI",
        flag = "AimbotTargetAi",
        default = Settings:Get("AimbotTargetAi") or false,
        callback = function(bool) Settings:Set("AimbotTargetAi", bool) end
    })
    
    sec:toggle({
        name = "Target Players",
        flag = "AimbotPlayer",
        default = Settings:Get("AimbotPlayer") or true,
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
        default = Settings:Get("FovVisible") or false,
        callback = function(bool) Settings:Set("FovVisible", bool) end
    })
    
    sec:colorpicker({
        name = "FOV Color",
        flag = "FovColor",
        color = Settings:Get("FovColor") or Color3.fromRGB(129, 210, 255),
        callback = function(color) Settings:Set("FovColor", color) end
    })
    
    sec:toggle({
        name = "Show Tracer",
        flag = "AimbotTracer",
        default = Settings:Get("AimbotTracer") or false,
        callback = function(bool) Settings:Set("AimbotTracer", bool) end,
        seperator = true
    })
end

print("Adding ESP tab...")

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
        default = Settings:Get("DroppedItemESP") or false,
        callback = function(bool) Settings:Set("DroppedItemESP", bool) end
    })
    
    sec:toggle({
        name = "Corpses",
        flag = "CorpseESP",
        default = Settings:Get("CorpseESP") or false,
        callback = function(bool) Settings:Set("CorpseESP", bool) end
    })
    
    sec:toggle({
        name = "Containers",
        flag = "ContainerESP",
        default = Settings:Get("ContainerESP") or false,
        callback = function(bool) Settings:Set("ContainerESP", bool) end
    })
    
    sec:toggle({
        name = "Exit Locations",
        flag = "ExitESP",
        default = Settings:Get("ExitESP") or false,
        callback = function(bool) Settings:Set("ExitESP", bool) end
    })
    
    sec:toggle({
        name = "Quest Items",
        flag = "QuestESP",
        default = Settings:Get("QuestESP") or false,
        callback = function(bool) Settings:Set("QuestESP", bool) end
    })
    
    sec:toggle({
        name = "Vehicles",
        flag = "VehicleTag",
        default = Settings:Get("VehicleTag") or false,
        callback = function(bool) Settings:Set("VehicleTag", bool) end,
        seperator = true
    })
end

print("Adding Movement tab...")

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
        default = Settings:Get("SpeedHack") or false,
        callback = function(bool) Settings:Set("SpeedHack", bool) end
    })
    
    sec:slider({
        name = "Speed",
        flag = "SpeedHackSpeed",
        min = 17, max = 100,
        default = Settings:Get("SpeedHackSpeed") or 17,
        callback = function(val) Settings:Set("SpeedHackSpeed", val) end
    })
    
    sec:toggle({
        name = "Infinity Jump",
        flag = "InfinityJump",
        default = Settings:Get("InfinityJump") or false,
        callback = function(bool) Settings:Set("InfinityJump", bool) end
    })
    
    sec:toggle({
        name = "Bunny Hop",
        flag = "BunnyHop",
        default = Settings:Get("BunnyHop") or false,
        callback = function(bool) Settings:Set("BunnyHop", bool) end
    })
    
    sec:toggle({
        name = "No Fall Damage",
        flag = "NoFall",
        default = Settings:Get("NoFall") or false,
        callback = function(bool) Settings:Set("NoFall", bool) end,
        seperator = true
    })
end

print("Adding World tab...")

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
        default = Settings:Get("FullBrightness") or false,
        callback = function(bool) Settings:Set("FullBrightness", bool) end
    })
    
    sec:toggle({
        name = "No Fog",
        flag = "NoFog",
        default = Settings:Get("NoFog") or false,
        callback = function(bool) Settings:Set("NoFog", bool) end
    })
    
    sec:toggle({
        name = "X-Ray",
        flag = "Xray",
        default = Settings:Get("Xray") or false,
        callback = function(bool) Settings:Set("Xray", bool) end
    })
    
    sec:toggle({
        name = "No Landmines",
        flag = "NoLandMine",
        default = Settings:Get("NoLandMine") or false,
        callback = function(bool) Settings:Set("NoLandMine", bool) end,
        seperator = true
    })
end

print("Adding Config tab...")

-- =============================================
-- CONFIGS TAB
-- =============================================
library:init_config(window)

print("Starting all features...")

-- =============================================
-- START ALL FEATURES
-- =============================================
pcall(function() Aimbot:Start() end)
pcall(function() ESP:Start() end)
pcall(function() Movement:Start() end)
pcall(function() Features:Start() end)
pcall(function() AntiCheat:Start() end)

print("KFC Hook - All tabs and features loaded!")
