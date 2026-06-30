-- [[ AZEER VORTEX x TITAN: THE BLOODY DARKNESS EDITION ]] --

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- [[ Whitelist ]]
-- ==========================================
local WHITELIST = {
    ["klkkklkllklkoollkllk"] = true,
    ["hdjc038"]              = true,
    ["31_adem3mkk1"]         = true,
    ["Fboodi1"]              = true,
    ["wil"]             = true,
    ["7avii"]                = true,
    ["7avii00"]              = true,
    ["kakwo_88o"]            = true,
    ["momoh_zkx19"]          = true,
    ["31_adem3mkk5"]         = true,
}

if not WHITELIST[LocalPlayer.Name] then
    -- Block screen
    local blockGui = Instance.new("ScreenGui")
    blockGui.Name = "AzeerBlockGui"
    blockGui.ResetOnSpawn = false
    blockGui.Parent = CoreGui

    local blockFrame = Instance.new("Frame", blockGui)
    blockFrame.Size = UDim2.new(0, 320, 0, 170)
    blockFrame.Position = UDim2.new(0.5, -160, 0.5, -85)
    blockFrame.BackgroundColor3 = Color3.fromRGB(6, 0, 0)
    blockFrame.BorderSizePixel = 0
    blockFrame.Active = true
    Instance.new("UICorner", blockFrame).CornerRadius = UDim.new(0, 16)
    local bStroke = Instance.new("UIStroke", blockFrame)
    bStroke.Color = Color3.fromRGB(200, 0, 0); bStroke.Thickness = 2

    local bIcon = Instance.new("TextLabel", blockFrame)
    bIcon.Size = UDim2.new(1, 0, 0, 50); bIcon.Position = UDim2.new(0, 0, 0, 10)
    bIcon.BackgroundTransparency = 1; bIcon.Text = "🚫"
    bIcon.TextSize = 38; bIcon.Font = Enum.Font.GothamBlack

    local bTitle = Instance.new("TextLabel", blockFrame)
    bTitle.Size = UDim2.new(1, 0, 0, 28); bTitle.Position = UDim2.new(0, 0, 0, 60)
    bTitle.BackgroundTransparency = 1
    bTitle.Text = "Access Denied"
    bTitle.TextColor3 = Color3.fromRGB(255, 50, 50)
    bTitle.Font = Enum.Font.GothamBlack; bTitle.TextSize = 17

    local bSub = Instance.new("TextLabel", blockFrame)
    bSub.Size = UDim2.new(0.9, 0, 0, 22); bSub.Position = UDim2.new(0.05, 0, 0, 92)
    bSub.BackgroundTransparency = 1
    bSub.Text = "This script is private and restricted"
    bSub.TextColor3 = Color3.fromRGB(180, 180, 180)
    bSub.Font = Enum.Font.GothamBold; bSub.TextSize = 13

    local bUser = Instance.new("TextLabel", blockFrame)
    bUser.Size = UDim2.new(0.9, 0, 0, 20); bUser.Position = UDim2.new(0.05, 0, 0, 115)
    bUser.BackgroundTransparency = 1
    bUser.Text = "User: " .. LocalPlayer.Name
    bUser.TextColor3 = Color3.fromRGB(120, 120, 120)
    bUser.Font = Enum.Font.GothamBold; bUser.TextSize = 12

    local bClose = Instance.new("TextButton", blockFrame)
    bClose.Size = UDim2.new(0.55, 0, 0, 28); bClose.Position = UDim2.new(0.225, 0, 0, 136)
    bClose.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    bClose.Text = "Close"; bClose.TextColor3 = Color3.fromRGB(255, 255, 255)
    bClose.Font = Enum.Font.GothamBlack; bClose.TextSize = 14
    bClose.BorderSizePixel = 0
    Instance.new("UICorner", bClose).CornerRadius = UDim.new(0, 10)
    bClose.MouseButton1Click:Connect(function()
        blockGui:Destroy()
    end)

    -- halt execution (works with all obfuscators, unlike return)
    while task.wait(9e9) do end
end
-- ==========================================

getgenv().ResolutionScale = 0.65
getgenv().Toggled = false
local Camera = workspace.CurrentCamera

local function GenerateRandomName()
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local name = ""
    for i = 1, math.random(10, 20) do
        local rand = math.random(1, #chars)
        name = name .. string.sub(chars, rand, rand)
    end
    return name
end

local RandomizedNames = {
    MainGui    = GenerateRandomName(),
    FollowerGui = GenerateRandomName(),
    ToggleGui  = GenerateRandomName(),
    GhostModel = "Part_" .. GenerateRandomName()
}

-- ==========================================
-- [[ BLOODY DARKNESS THEME ]]
-- ==========================================
local Theme = {
    Background = Color3.fromRGB(5, 0, 0),
    Gold       = Color3.fromRGB(200, 0, 0),
    Secondary  = Color3.fromRGB(20, 0, 0),
    Text       = Color3.fromRGB(255, 255, 255),
    DimText    = Color3.fromRGB(140, 0, 0),
    White      = Color3.fromRGB(255, 255, 255),
    Accent     = Color3.fromRGB(180, 0, 0),
    Neon       = Color3.fromRGB(255, 30, 30),
}

local BASE_COLOR     = Color3.fromRGB(163, 162, 165)
local ALERT_COLOR    = Color3.fromRGB(255, 0, 0)
local BASE_MATERIAL  = Enum.Material.Plastic
local FLASH_DURATION = 10

local MAIN_IMAGE = "rbxassetid://11548228061"

local function PlayClickSound()
    local s = Instance.new("Sound", SoundService)
    s.SoundId = "rbxassetid://140494750798924"
    s.Volume = 2
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

local isFFrameLocked = false

local function MakeDraggable(obj, target)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not isFFrameLocked then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging and not isFFrameLocked then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function startFlashingEffect(tool)
    local parts = {}
    for _, obj in ipairs(tool:GetDescendants()) do
        if obj:IsA("BasePart") then table.insert(parts, obj) end
    end
    task.spawn(function()
        local startTime = tick()
        while tick() - startTime < FLASH_DURATION do
            local elapsed = tick() - startTime
            local flashSpeed = math.max(0.05, 0.4 * (1 - (elapsed / FLASH_DURATION)))
            for _, p in ipairs(parts) do if p and p.Parent then p.Color = ALERT_COLOR end end
            task.wait(flashSpeed)
            for _, p in ipairs(parts) do if p and p.Parent then p.Color = BASE_COLOR end end
            task.wait(flashSpeed)
        end
        for _, p in ipairs(parts) do
            if p and p.Parent then p.Color = BASE_COLOR p.Material = BASE_MATERIAL end
        end
    end)
end

local function cleanTool(tool)
    if tool:GetAttribute("_cleaned") then return end
    tool:SetAttribute("_cleaned", true)
    local function applyClean()
        for _, obj in ipairs(tool:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Color, obj.Material, obj.Reflectance, obj.CastShadow = BASE_COLOR, BASE_MATERIAL, 0, false
            elseif obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("SpecialMesh") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") then
                obj.Enabled = false
            end
        end
    end
    applyClean()
    startFlashingEffect(tool)
    tool.DescendantAdded:Connect(function(d)
        task.defer(function()
            if d and d.Parent then
                if d:IsA("BasePart") then
                    d.Color, d.Material, d.Reflectance, d.CastShadow = BASE_COLOR, BASE_MATERIAL, 0, false
                elseif d:IsA("Texture") or d:IsA("Decal") or d:IsA("SpecialMesh") then
                    d:Destroy()
                elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") or d:IsA("Fire") or d:IsA("Smoke") then
                    d.Enabled = false
                end
            end
        end)
    end)
end

local azeerUltimateActive = false
local azeerUltimateConn = nil

local function ExecuteAzeerUltimate()
    if azeerUltimateActive then return end
    azeerUltimateActive = true

    PlayClickSound()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Lighting.GlobalShadows = false
    Lighting.FogEnd, Lighting.FogStart = 100000, 100000
    for _, fx in ipairs(Lighting:GetChildren()) do
        if fx:IsA("BloomEffect") or fx:IsA("BlurEffect") or fx:IsA("SunRaysEffect") or fx:IsA("DepthOfFieldEffect") or fx:IsA("ColorCorrectionEffect") then
            fx:Destroy()
        end
    end
    local colorFX = Instance.new("ColorCorrectionEffect", Lighting)
    colorFX.Brightness, colorFX.Contrast, colorFX.Saturation = 0.04, 0.12, 0.20
    local bloomFX = Instance.new("BloomEffect", Lighting)
    bloomFX.Intensity, bloomFX.Size, bloomFX.Threshold = 0.25, 20, 0.95
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Texture") or obj:IsA("Decal") then
            obj:Destroy()
        elseif obj:IsA("BasePart") then
            obj.Material, obj.Reflectance, obj.CastShadow = Enum.Material.SmoothPlastic, 0, false
        elseif obj:IsA("Tool") then
            cleanTool(obj)
        end
    end

    if not azeerUltimateConn then
        azeerUltimateConn = workspace.DescendantAdded:Connect(function(d)
            task.defer(function()
                if not d or not d.Parent then return end
                if d:IsA("Explosion") then
                    d.Visible = false d:Destroy()
                elseif d:IsA("Tool") then
                    cleanTool(d)
                elseif d:IsA("Texture") or d:IsA("Decal") then
                    d:Destroy()
                elseif d:IsA("BasePart") then
                    d.Material, d.Reflectance, d.CastShadow = Enum.Material.SmoothPlastic, 0, false
                end
            end)
        end)
    end
end

local turnBoostEnabled = false
local TURN_SPEED = 12
RunService.Heartbeat:Connect(function(dt)
    if not turnBoostEnabled then return end
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum  = char and char:FindFirstChild("Humanoid")
    if root and hum and hum.MoveDirection.Magnitude > 0.1 then
        local newDir = root.CFrame.LookVector:Lerp(hum.MoveDirection, TURN_SPEED * dt)
        root.CFrame = CFrame.lookAt(root.Position, root.Position + newDir)
    end
end)

local ghostModel, ghostRunning, ghostHistory = nil, false, {}
local function CreateGhost()
    if ghostModel then ghostModel:Destroy() end
    ghostModel = Instance.new("Model", workspace)
    ghostModel.Name = RandomizedNames.GhostModel
    local parts = {Head=Vector3.new(1,1,1), Torso=Vector3.new(2,2,1), ["Left Arm"]=Vector3.new(1,2,1), ["Right Arm"]=Vector3.new(1,2,1), ["Left Leg"]=Vector3.new(1,2,1), ["Right Leg"]=Vector3.new(1,2,1)}
    for name, size in pairs(parts) do
        local p = Instance.new("Part", ghostModel)
        p.Name = name p.Size = size p.Transparency = 0.5 p.Color = Theme.Gold
        p.Material = Enum.Material.Neon p.Anchored = true p.CanCollide = false
    end
end

local lastGhostUpdate = 0
RunService.PostSimulation:Connect(function()
    if not ghostRunning or not LocalPlayer.Character then return end
    local now = tick()
    if now - lastGhostUpdate < 0.05 then return end
    lastGhostUpdate = now

    local char = LocalPlayer.Character
    local delayInSeconds = (_G.AzeerPing or 200) / 1000
    local snap = {Time = now, Parts = {}}
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then snap.Parts[part.Name] = part.CFrame end
    end
    table.insert(ghostHistory, snap)
    if #ghostHistory > 80 then table.remove(ghostHistory, 1) end
    local targetTime = now - delayInSeconds
    local closest = nil
    for i = #ghostHistory, 1, -1 do
        if ghostHistory[i].Time <= targetTime then closest = ghostHistory[i] break end
    end
    if closest and ghostModel then
        for name, cf in pairs(closest.Parts) do
            local gp = ghostModel:FindFirstChild(name)
            if gp then gp.CFrame = cf end
        end
    end
end)

-- ==========================================
-- [[ Follower GUI ]]
-- ==========================================

local EGG_DEEP   = Color3.fromRGB(5, 0, 0)
local EGG_DARK   = Color3.fromRGB(20, 0, 0)
local EGG_MAIN   = Color3.fromRGB(40, 0, 0)
local EGG_BRIGHT = Color3.fromRGB(200, 0, 0)
local EGG_SOFT   = Color3.fromRGB(255, 255, 255)
local TEXT_LIGHT = Color3.fromRGB(255, 255, 255)

local autoGui = Instance.new("ScreenGui")
autoGui.Name = "AzeerFollowerGui"
autoGui.ResetOnSpawn = false
autoGui.Enabled = false
autoGui.Parent = CoreGui

local fFrame = Instance.new("Frame", autoGui)
fFrame.Size = UDim2.new(0, 300, 0, 130)
fFrame.Position = UDim2.new(0.5, -150, 0.1, 0)
fFrame.BackgroundColor3 = EGG_DEEP
fFrame.BorderSizePixel = 0; fFrame.Active = true; fFrame.Draggable = true
Instance.new("UICorner", fFrame).CornerRadius = UDim.new(0, 18)
local fGradient = Instance.new("UIGradient", fFrame)
fGradient.Rotation = 90
fGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, EGG_DARK),
    ColorSequenceKeypoint.new(1, EGG_DEEP),
})
local strokeA = Instance.new("UIStroke", fFrame)
strokeA.Color = EGG_BRIGHT; strokeA.Thickness = 2

local fTitle = Instance.new("TextLabel", fFrame)
fTitle.Size = UDim2.new(1, 0, 0.4, 0)
fTitle.BackgroundTransparency = 1
fTitle.Text = "A Z E E R  FOLLOW"
fTitle.TextColor3 = EGG_SOFT
fTitle.Font = Enum.Font.GothamBlack
fTitle.TextSize = 25
fTitle.TextStrokeTransparency = 0.6
fTitle.TextStrokeColor3 = EGG_DEEP

local fButton = Instance.new("TextButton", fFrame)
fButton.Size = UDim2.new(0.9, 0, 0.45, 0)
fButton.Position = UDim2.new(0.05, 0, 0.5, 0)
fButton.BackgroundColor3 = EGG_MAIN
fButton.TextColor3 = TEXT_LIGHT
fButton.Font = Enum.Font.GothamBold
fButton.TextSize = 22
fButton.Text = "FOLLOW  :  OFF"
fButton.BorderSizePixel = 0; fButton.AutoButtonColor = false
Instance.new("UICorner", fButton).CornerRadius = UDim.new(0, 14)
local fBtnStroke = Instance.new("UIStroke", fButton)
fBtnStroke.Color = EGG_BRIGHT; fBtnStroke.Thickness = 1.5

local following = false
fButton.MouseButton1Click:Connect(function()
    following = not following
    fButton.Text = following and "FOLLOW  :  ON" or "FOLLOW  :  OFF"
    fButton.BackgroundColor3 = following and EGG_BRIGHT or EGG_MAIN
end)

-- وظيفة البحث المحدثة: تفحص اللاعبين فقط مع فلتر التيم والـ Highlight
local function getClosestTarget(root)
    local closest, shortest = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local isTeammate = false
                if LocalPlayer.Team and player.Team == LocalPlayer.Team then
                    isTeammate = true
                end
                if char:FindFirstChildOfClass("Highlight") then
                    isTeammate = true
                end
                if not isTeammate then
                    local d = (hrp.Position - root.Position).Magnitude
                    if d < shortest then
                        shortest = d
                        closest = char
                    end
                end
            end
        end
    end
    return closest
end

local lastGoal, lastIssue = nil, 0
local offsetDistance = 2.3

RunService.Heartbeat:Connect(function()
    if not following then return end
    local char = LocalPlayer.Character; if not char then return end
    local hum  = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root or hum.Health <= 0 then return end
    local target = getClosestTarget(root)
    if not target then return end
    local tRoot = target:FindFirstChild("HumanoidRootPart")
    if not tRoot then return end
    local diff = root.Position - tRoot.Position
    local goal = tRoot.Position + (diff.Unit * offsetDistance)
    local now  = tick()
    if not lastGoal or (goal - lastGoal).Magnitude > 0.5 or (now - lastIssue) > 0.5 then
        hum:MoveTo(goal); lastGoal = goal; lastIssue = now
    end
end)

-- ==========================================
-- [[ Main GUI ]]
-- ==========================================

local mainGui = Instance.new("ScreenGui", CoreGui)
mainGui.Name = RandomizedNames.MainGui
mainGui.Enabled = false

local main = Instance.new("Frame", mainGui)
main.Size = UDim2.new(0, 500, 0, 300)
main.Position = UDim2.new(0.5, -250, 0.5, -150)
main.BackgroundTransparency = 0.05
main.BackgroundColor3 = Theme.Background
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)

local bgImg = Instance.new("ImageLabel", main)
bgImg.Size = UDim2.new(1, 0, 1, 0)
bgImg.Position = UDim2.new(0, 0, 0, 0)
bgImg.AnchorPoint = Vector2.new(0, 0)
bgImg.Image = MAIN_IMAGE
bgImg.BackgroundTransparency = 1
bgImg.ImageTransparency = 0.6
bgImg.ZIndex = 1
bgImg.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", bgImg).CornerRadius = UDim.new(0, 18)

local mStroke = Instance.new("UIStroke", main)
mStroke.Color = Theme.Gold
mStroke.Thickness = 2.5
mStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundTransparency = 1
header.ZIndex = 5
MakeDraggable(header, main)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(0, 220, 1, 0)
title.Position = UDim2.new(0.03, 0, 0, 0)
title.Text = "⚡ A Z E E R  V O R T E X"
title.TextColor3 = Theme.Gold
title.Font = Enum.Font.GothamBlack
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1

local subTitle = Instance.new("TextLabel", header)
subTitle.Size = UDim2.new(0, 180, 0, 16)
subTitle.Position = UDim2.new(0.03, 0, 0.62, 0)
subTitle.Text = "DELTA MOBILE EDITION"
subTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subTitle.Font = Enum.Font.GothamMedium
subTitle.TextSize = 10
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.BackgroundTransparency = 1

local perfFrame = Instance.new("Frame", header)
perfFrame.Size = UDim2.new(0, 180, 0, 30)
perfFrame.Position = UDim2.new(0.6, 0, 0.15, 0)
perfFrame.BackgroundTransparency = 1

local fpsLabel = Instance.new("TextLabel", perfFrame)
fpsLabel.Size = UDim2.new(0.5, 0, 1, 0)
fpsLabel.Text = "FPS: 60"
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.Font = Enum.Font.Code
fpsLabel.TextSize = 13
fpsLabel.BackgroundTransparency = 1

local pingLabel = Instance.new("TextLabel", perfFrame)
pingLabel.Size = UDim2.new(0.5, 0, 1, 0)
pingLabel.Position = UDim2.new(0.5, 0, 0, 0)
pingLabel.Text = "PING: 0ms"
pingLabel.TextColor3 = Theme.Gold
pingLabel.Font = Enum.Font.Code
pingLabel.TextSize = 13
pingLabel.BackgroundTransparency = 1

local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
end)
task.spawn(function()
    while true do
        task.wait(1)
        fpsLabel.Text = "FPS: " .. tostring(frameCount)
        pingLabel.Text = "PING: " .. tostring(math.floor(LocalPlayer:GetNetworkPing() * 1000)) .. "ms"
        frameCount = 0
    end
end)

local tabsFrame = Instance.new("Frame", main)
tabsFrame.Size = UDim2.new(1, 0, 0, 35)
tabsFrame.Position = UDim2.new(0, 0, 0.15, 0)
tabsFrame.BackgroundTransparency = 1
tabsFrame.ZIndex = 5

local pages = {
    Main  = Instance.new("Frame", main),
    Misc  = Instance.new("Frame", main),
    Scale = Instance.new("Frame", main)
}
for name, page in pairs(pages) do
    page.Size = UDim2.new(1, 0, 0.7, 0)
    page.Position = UDim2.new(0, 0, 0.28, 0)
    page.BackgroundTransparency = 1
    page.Visible = (name == "Main")
    page.ZIndex = 5
end

local tabButtons = {}
local function OpenPage(name)
    PlayClickSound()
    for n, p in pairs(pages) do p.Visible = (n == name) end
    for n, btn in pairs(tabButtons) do
        TweenService:Create(btn, TweenInfo.new(0.25), {
            TextColor3 = (n == name and Theme.Gold or Theme.DimText),
            BackgroundColor3 = (n == name and Color3.fromRGB(50, 0, 0) or Theme.Secondary)
        }):Play()
    end
end

for i, name in ipairs({"Main","Misc","Scale"}) do
    local b = Instance.new("TextButton", tabsFrame)
    b.Size = UDim2.new(0.3, 0, 0.8, 0)
    b.Position = UDim2.new(0.02 + (i-1)*0.32, 0, 0, 0)
    b.Text = name
    b.BackgroundColor3 = (name == "Main" and Color3.fromRGB(50, 0, 0) or Theme.Secondary)
    b.TextColor3 = (name == "Main" and Theme.Gold or Theme.DimText)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    tabButtons[name] = b
    b.MouseButton1Click:Connect(function() OpenPage(name) end)
end

-- ==========================================
-- [[ Scale Tab ]]
-- ==========================================

if getgenv().ResolutionLoop == nil then
    getgenv().ResolutionLoop = RunService.RenderStepped:Connect(function()
        if getgenv().Toggled then
            Camera.CFrame = Camera.CFrame * CFrame.new(0,0,0,1,0,0,0,getgenv().ResolutionScale,0,0,0,1)
        end
    end)
end

local scaleToggle = Instance.new("TextButton", pages.Scale)
scaleToggle.Size = UDim2.new(0.94, 0, 0, 50)
scaleToggle.Position = UDim2.new(0.03, 0, 0.05, 0)
scaleToggle.Text = "RES SYSTEM: OFF"
scaleToggle.BackgroundColor3 = Theme.Secondary
scaleToggle.TextColor3 = Theme.Text
scaleToggle.Font = Enum.Font.GothamBold
Instance.new("UICorner", scaleToggle).CornerRadius = UDim.new(0, 10)
scaleToggle.MouseButton1Click:Connect(function()
    PlayClickSound()
    getgenv().Toggled = not getgenv().Toggled
    scaleToggle.Text = getgenv().Toggled and "RES SYSTEM: ON" or "RES SYSTEM: OFF"
    scaleToggle.TextColor3 = getgenv().Toggled and Color3.fromRGB(0,255,127) or Theme.Text
    scaleToggle.BackgroundColor3 = getgenv().Toggled and Color3.fromRGB(60, 0, 0) or Theme.Secondary
    if not getgenv().Toggled then
        Camera.CFrame = Camera.CFrame * CFrame.new(0,0,0,1,0,0,0,1,0,0,0,1)
    end
end)

local rcUp = Instance.new("TextButton", pages.Scale)
rcUp.Size = UDim2.new(0.45, 0, 0, 60)
rcUp.Position = UDim2.new(0.03, 0, 0.35, 0)
rcUp.Text = "RC UP (+)"
rcUp.BackgroundColor3 = Theme.Secondary
rcUp.TextColor3 = Theme.Gold
rcUp.Font = Enum.Font.GothamBold
Instance.new("UICorner", rcUp).CornerRadius = UDim.new(0, 10)

local rcDown = Instance.new("TextButton", pages.Scale)
rcDown.Size = UDim2.new(0.45, 0, 0, 60)
rcDown.Position = UDim2.new(0.52, 0, 0.35, 0)
rcDown.Text = "RC DOWN (-)"
rcDown.BackgroundColor3 = Theme.Secondary
rcDown.TextColor3 = Theme.Gold
rcDown.Font = Enum.Font.GothamBold
Instance.new("UICorner", rcDown).CornerRadius = UDim.new(0, 10)

local resLabel = Instance.new("TextLabel", pages.Scale)
resLabel.Size = UDim2.new(0.94, 0, 0, 30)
resLabel.Position = UDim2.new(0.03, 0, 0.7, 0)
resLabel.BackgroundTransparency = 1
resLabel.Text = "Current Scale: 0.65"
resLabel.TextColor3 = Theme.Gold
resLabel.Font = Enum.Font.Code
resLabel.TextSize = 14

rcUp.MouseButton1Click:Connect(function()
    PlayClickSound()
    getgenv().ResolutionScale = math.clamp(getgenv().ResolutionScale + 0.05, 0.1, 1.25)
    resLabel.Text = "Current Scale: " .. string.format("%.2f", getgenv().ResolutionScale)
end)
rcDown.MouseButton1Click:Connect(function()
    PlayClickSound()
    getgenv().ResolutionScale = math.clamp(getgenv().ResolutionScale - 0.05, 0.1, 1.25)
    resLabel.Text = "Current Scale: " .. string.format("%.2f", getgenv().ResolutionScale)
end)

-- ==========================================
-- [[ Auto Garp GUI ]]
-- ==========================================

local autoGarpGui = Instance.new("ScreenGui")
autoGarpGui.Name = "AutoGarpGui"; autoGarpGui.ResetOnSpawn = false
autoGarpGui.Enabled = false; autoGarpGui.Parent = CoreGui

local garpFrame = Instance.new("Frame", autoGarpGui)
garpFrame.Size = UDim2.new(0, 280, 0, 120)
garpFrame.Position = UDim2.new(0.5, -140, 0.1, 0)
garpFrame.BackgroundColor3 = EGG_DEEP
garpFrame.Active = true; garpFrame.Draggable = true; garpFrame.BorderSizePixel = 0
Instance.new("UICorner", garpFrame).CornerRadius = UDim.new(0, 18)
local garpGrad = Instance.new("UIGradient", garpFrame)
garpGrad.Rotation = 90
garpGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, EGG_DARK), ColorSequenceKeypoint.new(1, EGG_DEEP),
})
local garpStroke = Instance.new("UIStroke", garpFrame)
garpStroke.Color = EGG_BRIGHT; garpStroke.Thickness = 3

local garpTitle = Instance.new("TextLabel", garpFrame)
garpTitle.Size = UDim2.new(1, 0, 0.4, 0)
garpTitle.BackgroundTransparency = 1
garpTitle.Text = "AUTO GARP"
garpTitle.TextColor3 = Theme.Gold
garpTitle.Font = Enum.Font.GothamBlack; garpTitle.TextSize = 28

local garpButton = Instance.new("TextButton", garpFrame)
garpButton.Size = UDim2.new(0.9, 0, 0.45, 0)
garpButton.Position = UDim2.new(0.05, 0, 0.5, 0)
garpButton.BackgroundColor3 = EGG_MAIN
garpButton.TextColor3 = TEXT_LIGHT
garpButton.Font = Enum.Font.GothamBold; garpButton.TextSize = 22
garpButton.Text = "FOLLOW : OFF"; garpButton.BorderSizePixel = 0
Instance.new("UICorner", garpButton).CornerRadius = UDim.new(0, 14)
local garpBtnStroke = Instance.new("UIStroke", garpButton)
garpBtnStroke.Color = EGG_BRIGHT; garpBtnStroke.Thickness = 1.5

local garpFollowing = false

local function garpHasTool()
    if LocalPlayer.Character then
        return LocalPlayer.Character:FindFirstChildOfClass("Tool") ~= nil
    end
    return false
end

local function garpStop()
    garpFollowing = false
    garpButton.Text = "FOLLOW : OFF"
    garpButton.BackgroundColor3 = EGG_MAIN
    garpBtnStroke.Color = EGG_BRIGHT
    garpStroke.Color = EGG_BRIGHT
end

garpButton.MouseButton1Click:Connect(function()
    if not garpFollowing then
        if garpHasTool() then return end
        garpFollowing = true
        garpButton.Text = "FOLLOW : ON"
        garpButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        garpBtnStroke.Color = EGG_SOFT
        garpStroke.Color = EGG_SOFT
    else
        garpStop()
    end
end)

-- auto-stop if player picks up a tool while following
RunService.RenderStepped:Connect(function()
    if garpFollowing and garpHasTool() then
        garpStop()
    end
    if not garpFollowing then return end

    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        if hum.MoveDirection.Magnitude > 0 then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            local closest, shortest = nil, math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Right Arm") then
                    local isTeammate = false
                    if LocalPlayer.Team and p.Team == LocalPlayer.Team then isTeammate = true end
                    if p.Character:FindFirstChildOfClass("Highlight") then isTeammate = true end
                    if not isTeammate then
                        local dist = (p.Character["Right Arm"].Position - root.Position).Magnitude
                        if dist < shortest then shortest = dist; closest = p end
                    end
                end
            end
            if closest then
                local targetArm = closest.Character["Right Arm"]
                hum:MoveTo(targetArm.Position + targetArm.CFrame.LookVector * 1.6)
            end
        end
    end
end)

-- ==========================================
-- [[ Main Tab ]]
-- ==========================================

local autoBtn = Instance.new("TextButton", pages.Main)
autoBtn.Size = UDim2.new(0.94, 0, 0, 50)
autoBtn.Position = UDim2.new(0.03, 0, 0.02, 0)
autoBtn.Text = "OPEN AUTO INTERFACE"
autoBtn.BackgroundColor3 = Theme.Secondary
autoBtn.TextColor3 = Theme.Gold
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 13
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 10)
autoBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    autoGui.Enabled = not autoGui.Enabled
end)

local up = Instance.new("TextButton", pages.Main)
up.Size = UDim2.new(0.45, 0, 0, 50)
up.Position = UDim2.new(0.03, 0, 0.22, 0)
up.Text = "EXPAND (+)"
up.BackgroundColor3 = Theme.Secondary
up.TextColor3 = Theme.Gold
up.Font = Enum.Font.GothamBold
Instance.new("UICorner", up).CornerRadius = UDim.new(0, 10)
up.MouseButton1Click:Connect(function()
    PlayClickSound()
    local fs = fFrame.Size
    fFrame:TweenSize(UDim2.new(0, fs.X.Offset+10, 0, fs.Y.Offset+10), "Out", "Back", 0.3, true)
end)

local down = Instance.new("TextButton", pages.Main)
down.Size = UDim2.new(0.45, 0, 0, 50)
down.Position = UDim2.new(0.52, 0, 0.22, 0)
down.Text = "SHRINK (-)"
down.BackgroundColor3 = Theme.Secondary
down.TextColor3 = Theme.Gold
down.Font = Enum.Font.GothamBold
Instance.new("UICorner", down).CornerRadius = UDim.new(0, 10)
down.MouseButton1Click:Connect(function()
    PlayClickSound()
    local fs = fFrame.Size
    fFrame:TweenSize(UDim2.new(0, math.max(fs.X.Offset-10, 50), 0, math.max(fs.Y.Offset-10, 20)), "Out", "Back", 0.3, true)
end)

local autoGarpBtn = Instance.new("TextButton", pages.Main)
autoGarpBtn.Size = UDim2.new(0.94, 0, 0, 50)
autoGarpBtn.Position = UDim2.new(0.03, 0, 0.44, 0)
autoGarpBtn.Text = "AUTO GARP: OFF"
autoGarpBtn.BackgroundColor3 = Theme.Secondary
autoGarpBtn.TextColor3 = Theme.Text
autoGarpBtn.Font = Enum.Font.GothamBold
autoGarpBtn.TextSize = 13
Instance.new("UICorner", autoGarpBtn).CornerRadius = UDim.new(0, 10)
autoGarpBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    autoGarpGui.Enabled = not autoGarpGui.Enabled
    autoGarpBtn.Text = autoGarpGui.Enabled and "AUTO GARP: ON" or "AUTO GARP: OFF"
    autoGarpBtn.TextColor3 = autoGarpGui.Enabled and Theme.Gold or Theme.Text
    autoGarpBtn.BackgroundColor3 = autoGarpGui.Enabled and Color3.fromRGB(60, 0, 0) or Theme.Secondary
end)

-- ==========================================
-- [[ Misc Tab ]]
-- ==========================================

local miscScroll = Instance.new("ScrollingFrame", pages.Misc)
miscScroll.Size = UDim2.new(0.96, 0, 0.9, 0)
miscScroll.Position = UDim2.new(0.02, 0, 0.05, 0)
miscScroll.BackgroundTransparency = 1
miscScroll.CanvasSize = UDim2.new(0, 0, 3.0, 0)
miscScroll.ScrollBarThickness = 2
miscScroll.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)

local pingBox = Instance.new("TextBox", miscScroll)
pingBox.Size = UDim2.new(0.48, 0, 0, 45)
pingBox.Position = UDim2.new(0, 0, 0.02, 0)
pingBox.PlaceholderText = "Ping (ms)"
pingBox.Text = "200"
pingBox.BackgroundColor3 = Theme.Secondary
pingBox.TextColor3 = Theme.Gold
pingBox.Font = Enum.Font.GothamBold
Instance.new("UICorner", pingBox).CornerRadius = UDim.new(0, 10)
pingBox:GetPropertyChangedSignal("Text"):Connect(function()
    local val = tonumber(pingBox.Text)
    if val then
        if val > 350 then pingBox.Text = "350" val = 350 end
        _G.AzeerPing = val
    end
end)

local ghostBtn = Instance.new("TextButton", miscScroll)
ghostBtn.Size = UDim2.new(0.48, 0, 0, 45)
ghostBtn.Position = UDim2.new(0.5, 5, 0.02, 0)
ghostBtn.Text = "GHOST: OFF"
ghostBtn.BackgroundColor3 = Theme.Secondary
ghostBtn.TextColor3 = Theme.Text
ghostBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ghostBtn).CornerRadius = UDim.new(0, 10)
ghostBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    ghostRunning = not ghostRunning
    _G.AzeerPing = math.clamp(tonumber(pingBox.Text) or 200, 0, 350)
    if ghostRunning then CreateGhost() else if ghostModel then ghostModel:Destroy() end end
    ghostBtn.Text = ghostRunning and "GHOST: ON" or "GHOST: OFF"
    ghostBtn.TextColor3 = ghostRunning and Theme.Gold or Theme.Text
    ghostBtn.BackgroundColor3 = ghostRunning and Color3.fromRGB(60, 0, 0) or Theme.Secondary
end)

local turnBtn = Instance.new("TextButton", miscScroll)
turnBtn.Size = UDim2.new(0.98, 0, 0, 45)
turnBtn.Position = UDim2.new(0, 0, 0.15, 0)
turnBtn.Text = "TURN BOOST: OFF"
turnBtn.BackgroundColor3 = Theme.Secondary
turnBtn.TextColor3 = Theme.Text
turnBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", turnBtn).CornerRadius = UDim.new(0, 10)
turnBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    turnBoostEnabled = not turnBoostEnabled
    turnBtn.Text = turnBoostEnabled and "TURN BOOST: ON" or "TURN BOOST: OFF"
    turnBtn.TextColor3 = turnBoostEnabled and Theme.Gold or Theme.Text
    turnBtn.BackgroundColor3 = turnBoostEnabled and Color3.fromRGB(60, 0, 0) or Theme.Secondary
end)

local ultBtn = Instance.new("TextButton", miscScroll)
ultBtn.Size = UDim2.new(0.98, 0, 0, 45)
ultBtn.Position = UDim2.new(0, 0, 0.28, 0)
ultBtn.Text = "AZEER ULTIMATE (OPTIMIZATION)"
ultBtn.BackgroundColor3 = Theme.Secondary
ultBtn.TextColor3 = Theme.Gold
ultBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ultBtn).CornerRadius = UDim.new(0, 10)
ultBtn.MouseButton1Click:Connect(ExecuteAzeerUltimate)

-- ==========================================
-- [[ BODY NOCLIP ]]
-- ==========================================

if getgenv().AzeerNoClipConns then
    for _, c in pairs(getgenv().AzeerNoClipConns) do
        pcall(function() c:Disconnect() end)
    end
end
getgenv().AzeerNoClipConns = {}
if getgenv().AzeerNoClipEnabled == nil then
    getgenv().AzeerNoClipEnabled = false
end

local function setCharNoClip(char, state)
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.CanCollide = state
        end
    end
end

local function hookPlayerNoClip(player)
    if player == LocalPlayer then return end
    local function onChar(char)
        task.wait(0.3)
        if getgenv().AzeerNoClipEnabled then
            setCharNoClip(char, false)
        end
        local descConn
        descConn = char.DescendantAdded:Connect(function(d)
            if getgenv().AzeerNoClipEnabled and d:IsA("BasePart") and d.Name ~= "HumanoidRootPart" then
                d.CanCollide = false
            end
        end)
        table.insert(getgenv().AzeerNoClipConns, descConn)
    end
    if player.Character then onChar(player.Character) end
    table.insert(getgenv().AzeerNoClipConns, player.CharacterAdded:Connect(onChar))
end

for _, p in ipairs(Players:GetPlayers()) do hookPlayerNoClip(p) end
table.insert(getgenv().AzeerNoClipConns, Players.PlayerAdded:Connect(hookPlayerNoClip))

task.spawn(function()
    while true do
        task.wait(0.3)
        if getgenv().AzeerNoClipEnabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    setCharNoClip(player.Character, false)
                end
            end
        end
    end
end)

local bodyNoClipBtn = Instance.new("TextButton", miscScroll)
bodyNoClipBtn.Size = UDim2.new(0.98, 0, 0, 45)
bodyNoClipBtn.Position = UDim2.new(0, 0, 0.41, 0)
bodyNoClipBtn.Text = getgenv().AzeerNoClipEnabled and "BODY NOCLIP: ON" or "BODY NOCLIP: OFF"
bodyNoClipBtn.BackgroundColor3 = getgenv().AzeerNoClipEnabled and Color3.fromRGB(60, 0, 0) or Theme.Secondary
bodyNoClipBtn.TextColor3 = getgenv().AzeerNoClipEnabled and Theme.Gold or Theme.Text
bodyNoClipBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", bodyNoClipBtn).CornerRadius = UDim.new(0, 10)

bodyNoClipBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    getgenv().AzeerNoClipEnabled = not getgenv().AzeerNoClipEnabled
    if not getgenv().AzeerNoClipEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                setCharNoClip(player.Character, true)
            end
        end
    end
    bodyNoClipBtn.Text = getgenv().AzeerNoClipEnabled and "BODY NOCLIP: ON" or "BODY NOCLIP: OFF"
    bodyNoClipBtn.TextColor3 = getgenv().AzeerNoClipEnabled and Theme.Gold or Theme.Text
    bodyNoClipBtn.BackgroundColor3 = getgenv().AzeerNoClipEnabled and Color3.fromRGB(60, 0, 0) or Theme.Secondary
end)

-- ==========================================
-- [[ KROBLOX LEGS ]]
-- ==========================================

local legsEnabled = false
local legsRespawnConn = nil

local function applyKrobloxLegs(character)
    local rightLeg = character:WaitForChild("Right Leg", 5)
    if not rightLeg then return end
    for _, v in ipairs(rightLeg:GetChildren()) do
        if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then v:Destroy() end
    end
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://101851696"
    mesh.TextureId = "rbxassetid://101851254"
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = rightLeg
end

local function removeKrobloxLegs(character)
    if not character then return end
    local rightLeg = character:FindFirstChild("Right Leg")
    if not rightLeg then return end
    for _, v in ipairs(rightLeg:GetChildren()) do
        if v:IsA("SpecialMesh") then v:Destroy() end
    end
end

local legsBtn = Instance.new("TextButton", miscScroll)
legsBtn.Size = UDim2.new(0.98, 0, 0, 45)
legsBtn.Position = UDim2.new(0, 0, 0.54, 0)
legsBtn.Text = "KROBLOX LEGS (Not Fe): OFF"
legsBtn.BackgroundColor3 = Theme.Secondary
legsBtn.TextColor3 = Theme.Text
legsBtn.Font = Enum.Font.GothamBold
legsBtn.TextSize = 13
Instance.new("UICorner", legsBtn).CornerRadius = UDim.new(0, 10)
legsBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    legsEnabled = not legsEnabled
    if legsEnabled then
        if LocalPlayer.Character then applyKrobloxLegs(LocalPlayer.Character) end
        legsRespawnConn = LocalPlayer.CharacterAdded:Connect(function(char)
            if legsEnabled then applyKrobloxLegs(char) end
        end)
    else
        if legsRespawnConn then legsRespawnConn:Disconnect() legsRespawnConn = nil end
        removeKrobloxLegs(LocalPlayer.Character)
    end
    legsBtn.Text = legsEnabled and "KROBLOX LEGS (Not Fe): ON" or "KROBLOX LEGS (Not Fe): OFF"
    legsBtn.TextColor3 = legsEnabled and Theme.Gold or Theme.Text
    legsBtn.BackgroundColor3 = legsEnabled and Color3.fromRGB(60, 0, 0) or Theme.Secondary
end)

-- ==========================================
-- [[ HEADLESS HEAD ]]
-- ==========================================

local headlessEnabled = false
local headlessRespawnConn = nil
local savedHeadMeshData = {}

local function saveOriginalHeadMesh(head)
    local meshData = {
        MeshType  = Enum.MeshType.Head,
        MeshId    = "",
        TextureId = "",
        Scale     = Vector3.new(1.25, 1.25, 1.25),
        Offset    = Vector3.new(0, 0, 0),
        FaceTexture = nil,
    }
    for _, v in ipairs(head:GetChildren()) do
        if v:IsA("SpecialMesh") then
            meshData.MeshType  = v.MeshType
            meshData.MeshId    = v.MeshId
            meshData.TextureId = v.TextureId
            meshData.Scale     = v.Scale
            meshData.Offset    = v.Offset
        elseif v:IsA("Decal") then
            meshData.FaceTexture = v.Texture
        end
    end
    return meshData
end

local function applyHeadless(character)
    local head = character:WaitForChild("Head", 5)
    if not head then return end
    savedHeadMeshData[character] = saveOriginalHeadMesh(head)
    head.Transparency = 1
    head.CanCollide = false
    local face = head:FindFirstChildOfClass("Decal")
    if face then face:Destroy() end
    for _, v in ipairs(head:GetChildren()) do
        if v:IsA("SpecialMesh") or v:IsA("CharacterMesh") then v:Destroy() end
    end
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://1095708"
    mesh.Scale = Vector3.new(0.001, 0.001, 0.001)
    mesh.Parent = head
end

local function removeHeadless(character)
    if not character then return end
    local head = character:FindFirstChild("Head")
    if not head then return end
    head.Transparency = 0
    head.CanCollide = true
    for _, v in ipairs(head:GetChildren()) do
        if v:IsA("SpecialMesh") then v:Destroy() end
    end
    local data = savedHeadMeshData[character]
    if data then
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType  = data.MeshType
        mesh.MeshId    = data.MeshId
        mesh.TextureId = data.TextureId
        mesh.Scale     = data.Scale
        mesh.Offset    = data.Offset
        mesh.Parent    = head
        savedHeadMeshData[character] = nil
    else
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.Head
        mesh.Scale    = Vector3.new(1.25, 1.25, 1.25)
        mesh.Parent   = head
    end
    local faceTexture = (data and data.FaceTexture) or "rbxasset://textures/face.png"
    if faceTexture and faceTexture ~= "" then
        local face = Instance.new("Decal")
        face.Texture = faceTexture
        face.Parent = head
    end
end

local headlessBtn = Instance.new("TextButton", miscScroll)
headlessBtn.Size = UDim2.new(0.98, 0, 0, 45)
headlessBtn.Position = UDim2.new(0, 0, 0.67, 0)
headlessBtn.Text = "HEADLESS HEAD (Not Fe): OFF"
headlessBtn.BackgroundColor3 = Theme.Secondary
headlessBtn.TextColor3 = Theme.Text
headlessBtn.Font = Enum.Font.GothamBold
headlessBtn.TextSize = 13
Instance.new("UICorner", headlessBtn).CornerRadius = UDim.new(0, 10)
headlessBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    headlessEnabled = not headlessEnabled
    if headlessEnabled then
        task.spawn(function() applyHeadless(LocalPlayer.Character) end)
        headlessRespawnConn = LocalPlayer.CharacterAdded:Connect(function(char)
            if headlessEnabled then
                savedHeadMeshData[char] = nil
                task.spawn(function() applyHeadless(char) end)
            end
        end)
    else
        if headlessRespawnConn then headlessRespawnConn:Disconnect() headlessRespawnConn = nil end
        task.spawn(function() removeHeadless(LocalPlayer.Character) end)
    end
    headlessBtn.Text = headlessEnabled and "HEADLESS HEAD (Not Fe): ON" or "HEADLESS HEAD (Not Fe): OFF"
    headlessBtn.TextColor3 = headlessEnabled and Theme.Gold or Theme.Text
    headlessBtn.BackgroundColor3 = headlessEnabled and Color3.fromRGB(60, 0, 0) or Theme.Secondary
end)

local assistMiscBtn = Instance.new("TextButton", miscScroll)
assistMiscBtn.Size = UDim2.new(0.98, 0, 0, 45)
assistMiscBtn.Position = UDim2.new(0, 0, 0.80, 0)
assistMiscBtn.Text = "MOVEMENT ASSIST: OFF"
assistMiscBtn.BackgroundColor3 = Theme.Secondary
assistMiscBtn.TextColor3 = Theme.Text
assistMiscBtn.Font = Enum.Font.GothamBold
assistMiscBtn.TextSize = 13
Instance.new("UICorner", assistMiscBtn).CornerRadius = UDim.new(0, 10)

local shakeMiscBtn = Instance.new("TextButton", miscScroll)
shakeMiscBtn.Size = UDim2.new(0.98, 0, 0, 45)
shakeMiscBtn.Position = UDim2.new(0, 0, 0.93, 0)
shakeMiscBtn.Text = "CAMERA SHAKE: OFF"
shakeMiscBtn.BackgroundColor3 = Theme.Secondary
shakeMiscBtn.TextColor3 = Theme.Text
shakeMiscBtn.Font = Enum.Font.GothamBold
shakeMiscBtn.TextSize = 13
Instance.new("UICorner", shakeMiscBtn).CornerRadius = UDim.new(0, 10)

-- ==========================================
-- [[ ASSIST GUI ]]
-- ==========================================

local assistGui = Instance.new("ScreenGui")
assistGui.Name = "AzeerMovementAssist"; assistGui.ResetOnSpawn = false
assistGui.Enabled = false; assistGui.Parent = CoreGui

local aFrame = Instance.new("Frame", assistGui)
aFrame.Size = UDim2.new(0, 320, 0, 180)
aFrame.Position = UDim2.new(0.5, -160, 0.12, 0)
aFrame.BackgroundColor3 = EGG_DEEP; aFrame.BorderSizePixel = 0
aFrame.Active = true; aFrame.Draggable = true
Instance.new("UICorner", aFrame).CornerRadius = UDim.new(0, 18)
local aGradient = Instance.new("UIGradient", aFrame)
aGradient.Rotation = 90
aGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, EGG_DARK), ColorSequenceKeypoint.new(1, EGG_DEEP),
})
local aStroke = Instance.new("UIStroke", aFrame)
aStroke.Color = EGG_BRIGHT; aStroke.Thickness = 2

local aTitle = Instance.new("TextLabel", aFrame)
aTitle.Size = UDim2.new(1, 0, 0, 40); aTitle.BackgroundTransparency = 1
aTitle.Text = "MOVEMENT  ASSIST"; aTitle.TextColor3 = EGG_SOFT
aTitle.Font = Enum.Font.GothamBlack; aTitle.TextSize = 19

local statusLbl = Instance.new("TextLabel", aFrame)
statusLbl.Size = UDim2.new(1, -24, 0, 24); statusLbl.Position = UDim2.new(0, 12, 0, 42)
statusLbl.BackgroundTransparency = 1; statusLbl.Text = "Status:  OFF"
statusLbl.TextColor3 = TEXT_LIGHT; statusLbl.Font = Enum.Font.GothamBold; statusLbl.TextSize = 13

local targetLabel = Instance.new("TextLabel", aFrame)
targetLabel.Size = UDim2.new(1, -24, 0, 22); targetLabel.Position = UDim2.new(0, 12, 0, 66)
targetLabel.BackgroundTransparency = 1; targetLabel.Text = "Target:  None"
targetLabel.TextColor3 = EGG_SOFT; targetLabel.Font = Enum.Font.GothamSemibold
targetLabel.TextSize = 12; targetLabel.TextTruncate = Enum.TextTruncate.AtEnd

local assistToggle = Instance.new("TextButton", aFrame)
assistToggle.Size = UDim2.new(1, -24, 0, 38); assistToggle.Position = UDim2.new(0, 12, 0, 96)
assistToggle.BackgroundColor3 = EGG_MAIN; assistToggle.Text = "ASSIST  OFF"
assistToggle.TextColor3 = TEXT_LIGHT; assistToggle.Font = Enum.Font.GothamBlack
assistToggle.TextSize = 16; assistToggle.BorderSizePixel = 0; assistToggle.AutoButtonColor = false
Instance.new("UICorner", assistToggle).CornerRadius = UDim.new(0, 12)
local atStroke = Instance.new("UIStroke", assistToggle)
atStroke.Color = EGG_BRIGHT; atStroke.Thickness = 1.5

local powerButton = Instance.new("TextButton", aFrame)
powerButton.Size = UDim2.new(0.48, -12, 0, 32); powerButton.Position = UDim2.new(0, 12, 0, 140)
powerButton.BackgroundColor3 = EGG_DARK; powerButton.Text = "POWER:  30%"
powerButton.TextColor3 = TEXT_LIGHT; powerButton.Font = Enum.Font.GothamBlack
powerButton.TextSize = 13; powerButton.BorderSizePixel = 0; powerButton.AutoButtonColor = false
Instance.new("UICorner", powerButton).CornerRadius = UDim.new(0, 10)
local pwStroke = Instance.new("UIStroke", powerButton)
pwStroke.Color = EGG_BRIGHT; pwStroke.Thickness = 1.2

local rangeButton = Instance.new("TextButton", aFrame)
rangeButton.Size = UDim2.new(0.48, -12, 0, 32); rangeButton.Position = UDim2.new(0.52, 0, 0, 140)
rangeButton.BackgroundColor3 = EGG_DARK; rangeButton.Text = "RANGE:  45"
rangeButton.TextColor3 = TEXT_LIGHT; rangeButton.Font = Enum.Font.GothamBlack
rangeButton.TextSize = 13; rangeButton.BorderSizePixel = 0; rangeButton.AutoButtonColor = false
Instance.new("UICorner", rangeButton).CornerRadius = UDim.new(0, 10)
local rgStroke = Instance.new("UIStroke", rangeButton)
rgStroke.Color = EGG_BRIGHT; rgStroke.Thickness = 1.2

local assistActive = false
local powers = {0.20, 0.25, 0.30, 0.35, 0.40}; local powerIndex = 3
local ranges  = {30, 45, 60, 80};               local rangeIndex  = 2

local function updateAssistUI()
    powerButton.Text = "POWER:  " .. math.floor(powers[powerIndex] * 100) .. "%"
    rangeButton.Text = "RANGE:  " .. ranges[rangeIndex]
    if assistActive then
        assistToggle.Text = "ASSIST  ON"; statusLbl.Text = "Status:  ON"
        assistToggle.BackgroundColor3 = EGG_BRIGHT
    else
        assistToggle.Text = "ASSIST  OFF"; statusLbl.Text = "Status:  OFF"
        targetLabel.Text = "Target:  None"; assistToggle.BackgroundColor3 = EGG_MAIN
    end
end
assistToggle.MouseButton1Click:Connect(function() assistActive = not assistActive; updateAssistUI() end)
powerButton.MouseButton1Click:Connect(function() powerIndex = powerIndex % #powers + 1; updateAssistUI() end)
rangeButton.MouseButton1Click:Connect(function() rangeIndex = rangeIndex % #ranges + 1; updateAssistUI() end)

local function getAssistTarget(root, maxRange)
    local closest, shortest = nil, maxRange
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
            local tHum  = p.Character:FindFirstChildOfClass("Humanoid")
            if tRoot and tHum and tHum.Health > 0 then
                local d = (tRoot.Position - root.Position).Magnitude
                if d < shortest then shortest = d; closest = p end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if not assistActive then return end
    local char = LocalPlayer.Character; if not char then return end
    local hum  = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root or hum.Health <= 0 then return end
    if hum.MoveDirection.Magnitude <= 0 then
        targetLabel.Text = "Target:  Waiting Movement"; return
    end
    local target = getAssistTarget(root, ranges[rangeIndex])
    if not target or not target.Character then targetLabel.Text = "Target:  None"; return end
    local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
    if not tRoot then return end
    targetLabel.Text = "Target:  " .. target.Name
    local tDir = tRoot.Position - root.Position
    tDir = Vector3.new(tDir.X, 0, tDir.Z)
    if tDir.Magnitude <= 0.1 then return end
    local power   = powers[powerIndex]
    local blended = (hum.MoveDirection.Unit * (1 - power)) + (tDir.Unit * power)
    if blended.Magnitude > 0 then hum:Move(blended.Unit, false) end
end)

updateAssistUI()

assistMiscBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    assistGui.Enabled = not assistGui.Enabled
    assistMiscBtn.Text = assistGui.Enabled and "MOVEMENT ASSIST: ON" or "MOVEMENT ASSIST: OFF"
    assistMiscBtn.TextColor3 = assistGui.Enabled and Theme.Gold or Theme.Text
    assistMiscBtn.BackgroundColor3 = assistGui.Enabled and Color3.fromRGB(60, 0, 0) or Theme.Secondary
end)

-- ==========================================
-- [[ SHAKE GUI - AUTO CAMERA MOTION DETECTION ]]
-- ==========================================

local INTENSITY         = 0.5
local SPEED             = 2
local SHAKE_STRENGTH    = 3
local DETECT_THRESHOLD  = 0.04
local DETECT_REVERSALS  = 3
local DETECT_WINDOW     = 0.4
local STOP_COOLDOWN     = 0.5

local SHAKE_ON_COLOR  = Color3.fromRGB(200, 0, 0)
local SHAKE_OFF_COLOR = Color3.fromRGB(50, 50, 50)

local DATA_STRING = "-433,-1247,-1362,-789,-1128,-756,-683,371,949,1488,1049,365,-865,-1529,-1627,-1199,-927,-735,-213,829,2108,2198,1141,4,-1266,-2034,-1353,-811,-732,-374,748,2096,2863,1610,687,-476,-1413,-1596,-1158,-842,-917,316,1333,2232,1665,1132,-593,-1265,-1422,-937,-1020,-381,-21,547,2311,2871,753,147,-596,-1403,-1110,-889,-514,-159,0,819,2337,1511,910,-700,-1611,-1585,-768,-719,-410,-75,-1,1219,1248,538,-1,-1141,-1084,-1135,-840,-496,-77,-1,1669,2519,1747,384,-1132,-1769,-1526,-1251,-874,-874,262,1156,2514,2803,1727,352,-1,-2698,-1773,-1172,-739,-774,101,431,77,-238,-745,-706,-609,-342,651,1160,2161,3306,2362,546,-1,-2269,-2316,-1575,-1003,-571,-301,0,435,912,398,0,-567,-1218,-1162,-850,-897,94,1076,1498,2391,868,145,-752,-2286,-2065,-1277,-878,-348,-1,1246,3095,2718,741,-1,-1303,-2180,-1849,-1146,-692,-857,1111,1862,3438,1603,244,-1330,-2259,-1900,-1443,-1019,-497,-106,892,2945,3263,1518,193,-1543,-2228,-2274,-1373,-1261,-695,199,1403,2642,2438,856,69,-940,-1652,-1532,-1125,-764,-345,988,2016,2861,2128,647,-954,-1746,-1924,-1205,-1130,-570,-632,1393,1825,2915,503,73,-899,-1745,-1532,-1194,-641,-204,-1,1279,2991,1845,676,0,-1333,-1988,-1681,-1283,-758,-309,-1,1162,3010,3523,1190"

local shakeFrames = {}
for val in DATA_STRING:gmatch("([^,]+)") do
    local n = tonumber(val)
    if n then table.insert(shakeFrames, (n / 10000) * INTENSITY) end
end

local shakeGui = Instance.new("ScreenGui")
shakeGui.Name = "AzeerShakeGui"; shakeGui.ResetOnSpawn = false
shakeGui.Enabled = false; shakeGui.Parent = CoreGui

local shakeFrame = Instance.new("Frame", shakeGui)
shakeFrame.Size = UDim2.new(0, 260, 0, 110)
shakeFrame.Position = UDim2.new(0.5, -130, 0.45, 0)
shakeFrame.BackgroundColor3 = EGG_DEEP
shakeFrame.BorderSizePixel = 0; shakeFrame.Active = true; shakeFrame.Draggable = true
Instance.new("UICorner", shakeFrame).CornerRadius = UDim.new(0, 15)
local shGradient = Instance.new("UIGradient", shakeFrame)
shGradient.Rotation = 90
shGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, EGG_DARK), ColorSequenceKeypoint.new(1, EGG_DEEP),
})
local shakeStroke = Instance.new("UIStroke", shakeFrame)
shakeStroke.Color = EGG_BRIGHT; shakeStroke.Thickness = 2

local titleLabel = Instance.new("TextLabel", shakeFrame)
titleLabel.Size = UDim2.new(1, -90, 0, 36); titleLabel.Position = UDim2.new(0, 10, 0, 8)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SHAKE: Waiting..."
titleLabel.TextColor3 = TEXT_LIGHT
titleLabel.Font = Enum.Font.GothamBlack; titleLabel.TextSize = 15
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local toggleBtn = Instance.new("TextButton", shakeFrame)
toggleBtn.Size = UDim2.new(0, 68, 0, 32); toggleBtn.Position = UDim2.new(1, -76, 0, 10)
toggleBtn.BackgroundColor3 = SHAKE_OFF_COLOR
toggleBtn.Text = "OFF"; toggleBtn.TextColor3 = TEXT_LIGHT
toggleBtn.Font = Enum.Font.GothamBold; toggleBtn.TextSize = 13
toggleBtn.AutoButtonColor = false; toggleBtn.BorderSizePixel = 0
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)
local toggleStroke = Instance.new("UIStroke", toggleBtn)
toggleStroke.Color = EGG_BRIGHT; toggleStroke.Thickness = 1

local statusBar = Instance.new("Frame", shakeFrame)
statusBar.Size = UDim2.new(0.88, 0, 0, 6); statusBar.Position = UDim2.new(0.06, 0, 0, 50)
statusBar.BackgroundColor3 = EGG_DARK; statusBar.BorderSizePixel = 0
Instance.new("UICorner", statusBar).CornerRadius = UDim.new(0, 3)

local statusFill = Instance.new("Frame", statusBar)
statusFill.Size = UDim2.new(0, 0, 1, 0)
statusFill.BackgroundColor3 = EGG_BRIGHT; statusFill.BorderSizePixel = 0
Instance.new("UICorner", statusFill).CornerRadius = UDim.new(0, 3)

local modeLabel = Instance.new("TextLabel", shakeFrame)
modeLabel.Size = UDim2.new(0.88, 0, 0, 28); modeLabel.Position = UDim2.new(0.06, 0, 0, 60)
modeLabel.BackgroundTransparency = 1
modeLabel.Text = "Mode: Auto — move camera left/right"
modeLabel.TextColor3 = EGG_SOFT
modeLabel.Font = Enum.Font.Gotham; modeLabel.TextSize = 11
modeLabel.TextWrapped = true; modeLabel.TextXAlignment = Enum.TextXAlignment.Left

local stateLabel = Instance.new("TextLabel", shakeFrame)
stateLabel.Size = UDim2.new(0.88, 0, 0, 20); stateLabel.Position = UDim2.new(0.06, 0, 0, 87)
stateLabel.BackgroundTransparency = 1; stateLabel.Text = ""
stateLabel.TextColor3 = EGG_BRIGHT
stateLabel.Font = Enum.Font.GothamBold; stateLabel.TextSize = 12
stateLabel.TextXAlignment = Enum.TextXAlignment.Left

local isShaking  = false
local shakeConn  = nil
local shakeTimer = 0
local shakeIndex = 1
local shakeEnabled = false

local function updateToggleBtn()
    if shakeEnabled then
        toggleBtn.Text = "ON"
        toggleBtn.BackgroundColor3 = SHAKE_ON_COLOR
        toggleStroke.Color = EGG_BRIGHT
        modeLabel.Text = "Mode: Auto — move camera left/right"
        modeLabel.TextColor3 = EGG_SOFT
    else
        toggleBtn.Text = "OFF"
        toggleBtn.BackgroundColor3 = SHAKE_OFF_COLOR
        toggleStroke.Color = Color3.fromRGB(100, 100, 100)
        modeLabel.Text = "Mode: Disabled"
        modeLabel.TextColor3 = Color3.fromRGB(180, 80, 80)
    end
end

local function stopShake()
    if not isShaking then return end
    isShaking = false
    if shakeConn then shakeConn:Disconnect(); shakeConn = nil end
    titleLabel.Text = "SHAKE: Waiting..."
    titleLabel.TextColor3 = TEXT_LIGHT
    stateLabel.Text = ""
    shakeTimer = 0; shakeIndex = 1
end

local function startShake()
    if isShaking then return end
    isShaking = true
    titleLabel.Text = "SHAKE: Active ✓"
    titleLabel.TextColor3 = EGG_SOFT
    stateLabel.Text = "● Active"
    shakeConn = RunService.RenderStepped:Connect(function(dt)
        local char = LocalPlayer.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp or UIS.MouseBehavior ~= Enum.MouseBehavior.LockCenter then return end
        shakeTimer = shakeTimer + (dt * SPEED)
        shakeIndex = math.floor(shakeTimer * 60) + 1
        if shakeIndex > #shakeFrames then shakeIndex = 1; shakeTimer = 0 end
        local yaw   = shakeFrames[shakeIndex] * SHAKE_STRENGTH
        local pivot = hrp.CFrame.Position
        workspace.CurrentCamera.CFrame =
            CFrame.new(pivot) * CFrame.Angles(0, yaw, 0) * CFrame.new(-pivot) * workspace.CurrentCamera.CFrame
    end)
end

toggleBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    shakeEnabled = not shakeEnabled
    updateToggleBtn()
    if not shakeEnabled then
        stopShake()
        statusFill.Size = UDim2.new(0, 0, 1, 0)
        titleLabel.Text = "SHAKE: Disabled"
        titleLabel.TextColor3 = Color3.fromRGB(180, 80, 80)
    else
        titleLabel.Text = "SHAKE: Waiting..."
        titleLabel.TextColor3 = TEXT_LIGHT
    end
end)

local prevYaw       = nil
local prevDelta     = 0
local reversalTimes = {}
local lastMoveTime  = 0

RunService.RenderStepped:Connect(function(dt)
    if not shakeEnabled then return end
    local cam = workspace.CurrentCamera
    local _, y, _ = cam.CFrame:ToEulerAnglesYXZ()
    if prevYaw == nil then prevYaw = y; return end
    local delta = y - prevYaw
    if delta >  math.pi then delta = delta - 2 * math.pi end
    if delta < -math.pi then delta = delta + 2 * math.pi end
    if math.abs(delta) > DETECT_THRESHOLD then
        lastMoveTime = tick()
        if prevDelta ~= 0 and (delta * prevDelta < 0) then
            table.insert(reversalTimes, tick())
        end
        prevDelta = delta
        local now, kept = tick(), {}
        local count = 0
        for _, t in ipairs(reversalTimes) do
            if now - t <= DETECT_WINDOW then
                count = count + 1
                table.insert(kept, t)
            end
        end
        reversalTimes = kept
        local ratio = math.min(count / DETECT_REVERSALS, 1)
        statusFill.Size = UDim2.new(ratio, 0, 1, 0)
        statusFill.BackgroundColor3 = ratio >= 1 and EGG_BRIGHT or EGG_MAIN
        if count >= DETECT_REVERSALS and not isShaking then
            startShake()
        end
    else
        if isShaking and (tick() - lastMoveTime) >= STOP_COOLDOWN then
            stopShake()
            reversalTimes = {}
            statusFill.Size = UDim2.new(0, 0, 1, 0)
            statusFill.BackgroundColor3 = EGG_MAIN
        end
    end
    prevYaw = y
end)

updateToggleBtn()

shakeMiscBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    shakeGui.Enabled = not shakeGui.Enabled
    if not shakeGui.Enabled then
        stopShake()
        shakeEnabled = false
        updateToggleBtn()
        statusFill.Size = UDim2.new(0, 0, 1, 0)
        titleLabel.Text = "SHAKE: Waiting..."
        titleLabel.TextColor3 = TEXT_LIGHT
    end
    shakeMiscBtn.Text = shakeGui.Enabled and "CAMERA SHAKE: ON" or "CAMERA SHAKE: OFF"
    shakeMiscBtn.TextColor3 = shakeGui.Enabled and Theme.Gold or Theme.Text
    shakeMiscBtn.BackgroundColor3 = shakeGui.Enabled and Color3.fromRGB(60, 0, 0) or Theme.Secondary
end)

-- ==========================================
-- [[ Toggle Button ]]
-- ==========================================

local toggleGui = Instance.new("ScreenGui", CoreGui)
toggleGui.Name = RandomizedNames.ToggleGui
toggleGui.Enabled = false

local azBtn = Instance.new("ImageButton", toggleGui)
azBtn.Size = UDim2.new(0, 55, 0, 55)
azBtn.Position = UDim2.new(0, 20, 0.5, -27)
azBtn.BackgroundColor3 = Theme.Background
azBtn.Image = MAIN_IMAGE
azBtn.ClipsDescendants = true
Instance.new("UICorner", azBtn).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", azBtn)
ToggleStroke.Color = Theme.Gold
ToggleStroke.Thickness = 2.5
MakeDraggable(azBtn, azBtn)
azBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    mainGui.Enabled = not mainGui.Enabled
end)

-- ==========================================
-- [[ TITAN Entry Screen ]]
-- ==========================================

local titanGui = Instance.new("ScreenGui", CoreGui)
titanGui.Name = "AzeerTitanEntry"

local tFrame = Instance.new("Frame", titanGui)
tFrame.Size = UDim2.new(0, 550, 0, 300)
tFrame.Position = UDim2.new(0.5, -275, 0.5, -150)
tFrame.BackgroundColor3 = Theme.Background
Instance.new("UICorner", tFrame).CornerRadius = UDim.new(0, 18)
local mStrokeTitan = Instance.new("UIStroke", tFrame)
mStrokeTitan.Color = Theme.Gold
mStrokeTitan.Thickness = 2.5

local titanTopBar = Instance.new("Frame", tFrame)
titanTopBar.Size = UDim2.new(1, 0, 0, 3)
titanTopBar.BackgroundColor3 = Theme.Accent
titanTopBar.BorderSizePixel = 0
titanTopBar.ZIndex = 5
Instance.new("UICorner", titanTopBar).CornerRadius = UDim.new(0, 18)

local avatarImg = Instance.new("ImageLabel", tFrame)
avatarImg.Size = UDim2.new(0, 120, 0, 120)
avatarImg.Position = UDim2.new(0, 30, 0.5, -60)
avatarImg.BackgroundColor3 = Theme.Secondary
avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(0, 15)
local avatarStroke = Instance.new("UIStroke", avatarImg)
avatarStroke.Color = Theme.Gold
avatarStroke.Thickness = 2

local entryBgImg = Instance.new("ImageLabel", tFrame)
entryBgImg.Size = UDim2.new(1, 0, 1, 0)
entryBgImg.Image = MAIN_IMAGE
entryBgImg.BackgroundTransparency = 1
entryBgImg.ImageTransparency = 0.82
entryBgImg.ZIndex = 0
entryBgImg.ScaleType = Enum.ScaleType.Crop

local infoFrame = Instance.new("Frame", tFrame)
infoFrame.Size = UDim2.new(0, 230, 0, 120)
infoFrame.Position = UDim2.new(0, 170, 0.5, -60)
infoFrame.BackgroundTransparency = 1

local tkLabel = Instance.new("TextLabel", infoFrame)
tkLabel.Size = UDim2.new(1, 0, 0, 30)
tkLabel.Position = UDim2.new(0, 0, 0, 10)
tkLabel.Text = "⚡ Tik Tok : 78n.o"
tkLabel.TextColor3 = Theme.Gold
tkLabel.Font = Enum.Font.GothamBlack
tkLabel.TextSize = 22
tkLabel.BackgroundTransparency = 1

local deltaLabel = Instance.new("TextLabel", infoFrame)
deltaLabel.Size = UDim2.new(1, 0, 0, 20)
deltaLabel.Position = UDim2.new(0, 0, 0, 36)
deltaLabel.Text = "DELTA MOBILE EDITION"
deltaLabel.TextColor3 = Theme.Accent
deltaLabel.Font = Enum.Font.GothamBold
deltaLabel.TextSize = 12
deltaLabel.BackgroundTransparency = 1

local hintLabel = Instance.new("TextLabel", infoFrame)
hintLabel.Size = UDim2.new(1, 0, 0, 60)
hintLabel.Position = UDim2.new(0, 0, 0, 58)
hintLabel.Text = "Follow us on TikTok and share your feedback!"
hintLabel.TextColor3 = Theme.DimText
hintLabel.Font = Enum.Font.GothamMedium
hintLabel.TextScaled = true
hintLabel.BackgroundTransparency = 1

local startBtn = Instance.new("TextButton", tFrame)
startBtn.Size = UDim2.new(0, 120, 0, 120)
startBtn.Position = UDim2.new(0, 410, 0.5, -60)
startBtn.BackgroundColor3 = Theme.Secondary
startBtn.Text = "START\nVORTEX"
startBtn.TextColor3 = Theme.Gold
startBtn.Font = Enum.Font.GothamBlack
startBtn.TextSize = 20
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 15)
local startBtnStroke = Instance.new("UIStroke", startBtn)
startBtnStroke.Color = Theme.Accent
startBtnStroke.Thickness = 2

startBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    titanGui:Destroy()
    toggleGui.Enabled = true
end)

startBtn.MouseEnter:Connect(function()
    TweenService:Create(startBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 0, 0)}):Play()
end)
startBtn.MouseLeave:Connect(function()
    TweenService:Create(startBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Secondary}):Play()
end)

-- ==========================================
-- [[ Intro Animation ]]
-- ==========================================

local showWhatsNew

local function PlayIntro()
    local introGui = Instance.new("ScreenGui", CoreGui)
    introGui.IgnoreGuiInset = true
    introGui.DisplayOrder = 10000

    local bg = Instance.new("Frame", introGui)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(5, 0, 0)
    bg.BorderSizePixel = 0

    local introMusic = Instance.new("Sound", SoundService)
    introMusic.SoundId = "rbxassetid://124004202059646"
    introMusic.Volume = 4
    introMusic:Play()
    task.spawn(function()
        task.wait(20)
        if introMusic and introMusic.Parent then
            TweenService:Create(introMusic, TweenInfo.new(2), {Volume = 0}):Play()
            task.wait(2)
            introMusic:Stop()
            introMusic:Destroy()
        end
    end)

    local skipBtn = Instance.new("TextButton", introGui)
    skipBtn.Size = UDim2.new(0, 100, 0, 36)
    skipBtn.Position = UDim2.new(1, -115, 1, -55)
    skipBtn.Text = "SKIP ▶▶"
    skipBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
    skipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    skipBtn.Font = Enum.Font.GothamBold
    skipBtn.TextSize = 14
    skipBtn.ZIndex = 20
    Instance.new("UICorner", skipBtn).CornerRadius = UDim.new(0, 10)
    local skipStroke = Instance.new("UIStroke", skipBtn)
    skipStroke.Color = Color3.fromRGB(200, 0, 0)
    skipStroke.Thickness = 2

    local skipped = false
    skipBtn.MouseButton1Click:Connect(function()
        if skipped then return end
        skipped = true
        active = false
        TweenService:Create(bg, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
        TweenService:Create(skipBtn, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        for _, v in pairs(bg:GetDescendants()) do
            if v:IsA("TextLabel") then
                TweenService:Create(v, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            elseif v:IsA("Frame") then
                TweenService:Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            elseif v:IsA("UIStroke") then
                TweenService:Create(v, TweenInfo.new(0.3), {Transparency = 1}):Play()
            end
        end
        if introMusic and introMusic.Parent then
            TweenService:Create(introMusic, TweenInfo.new(0.5), {Volume = 0}):Play()
        end
        task.wait(0.5)
        introGui:Destroy()
    end)

    local nameContainer = Instance.new("Frame", bg)
    nameContainer.Size = UDim2.new(1, 0, 0.3, 0)
    nameContainer.Position = UDim2.new(0, 0, 0.25, 0)
    nameContainer.BackgroundTransparency = 1

    local letterLabels = {}
    for i, char in ipairs({"A","Z","E","E","R"}) do
        local l = Instance.new("TextLabel", nameContainer)
        l.Size = UDim2.new(0.2, 0, 1, 0)
        l.Position = UDim2.new((i-1)*0.2, 0, 0, 0)
        l.BackgroundTransparency = 1
        l.Text = char
        l.TextColor3 = Color3.fromRGB(220, 0, 0)
        l.Font = Enum.Font.Antique
        l.TextSize = 110
        l.TextTransparency = 1
        local stroke = Instance.new("UIStroke", l)
        stroke.Thickness = 1.5
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.Transparency = 1
        letterLabels[i] = l
    end

    local warningArabic = Instance.new("TextLabel", bg)
    warningArabic.Size = UDim2.new(1, 0, 0.05, 0)
    warningArabic.Position = UDim2.new(0, 0, 0.65, 0)
    warningArabic.BackgroundTransparency = 1
    warningArabic.Text = "( WARNING: Detectable — Risk of Ban )"
    warningArabic.TextColor3 = Color3.fromRGB(255, 255, 255)
    warningArabic.Font = Enum.Font.GothamBold
    warningArabic.TextSize = 30
    warningArabic.TextTransparency = 1

    local warningEnglish = Instance.new("TextLabel", bg)
    warningEnglish.Size = UDim2.new(1, 0, 0.05, 0)
    warningEnglish.Position = UDim2.new(0, 0, 0.72, 0)
    warningEnglish.BackgroundTransparency = 1
    warningEnglish.Text = "( EXPOSED GAMEPLAY LEADS TO BAN )"
    warningEnglish.TextColor3 = Color3.fromRGB(200, 0, 0)
    warningEnglish.Font = Enum.Font.Code
    warningEnglish.TextSize = 22
    warningEnglish.TextTransparency = 1

    local function CreateRain()
        local drop = Instance.new("Frame", bg)
        drop.Size = UDim2.new(0, 2, 0, 20)
        drop.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        drop.BackgroundTransparency = 0.3
        local screenWidth = introGui.AbsoluteSize.X
        if screenWidth == 0 then screenWidth = 1000 end
        local posX = math.random(0, screenWidth)
        drop.Position = UDim2.new(0, posX, 0, -20)
        local t = TweenService:Create(drop, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            Position = UDim2.new(0, posX, 1, 50),
            BackgroundTransparency = 1
        })
        t:Play()
        t.Completed:Connect(function() drop:Destroy() end)
    end

    task.wait(0.5)
    local openInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    for _, l in ipairs(letterLabels) do
        TweenService:Create(l, openInfo, {TextTransparency = 0}):Play()
        local s = l:FindFirstChildOfClass("UIStroke")
        if s then TweenService:Create(s, openInfo, {Transparency = 0}):Play() end
    end
    task.wait(0.8)
    TweenService:Create(warningArabic, openInfo, {TextTransparency = 0}):Play()
    TweenService:Create(warningEnglish, openInfo, {TextTransparency = 0}):Play()

    local active = true

    task.spawn(function()
        while active do
            CreateRain()
            task.wait(0.08)
        end
    end)

    task.spawn(function()
        while active do
            task.wait(0.4)
            if math.random() > 0.8 then
                warningArabic.Text = "( WARNING: Detectable              )"
                warningEnglish.Text = "( EXPOSED GAMEPLAY LEADS TO     )"
                task.delay(0.08, function()
                    warningArabic.Text = "( WARNING: Detectable — Risk of Ban )"
                    warningEnglish.Text = "( EXPOSED GAMEPLAY LEADS TO BAN )"
                end)
            end
        end
    end)

    task.spawn(function()
        while active do
            local alpha = (math.sin(tick() * 3) * 0.08)
            for _, l in ipairs(letterLabels) do
                l.TextTransparency = math.clamp(alpha, 0, 0.15)
            end
            task.wait(0.04)
        end
    end)

    task.wait(8)
    active = false
    skipped = true
    local fadeOut = TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    TweenService:Create(bg, fadeOut, {BackgroundTransparency = 1}):Play()
    TweenService:Create(skipBtn, TweenInfo.new(0.4), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    local skipStrokeObj = skipBtn:FindFirstChildOfClass("UIStroke")
    if skipStrokeObj then
        TweenService:Create(skipStrokeObj, TweenInfo.new(0.4), {Transparency = 1}):Play()
    end
    for _, v in pairs(bg:GetDescendants()) do
        if v:IsA("TextLabel") then
            TweenService:Create(v, fadeOut, {TextTransparency = 1}):Play()
        elseif v:IsA("Frame") then
            TweenService:Create(v, fadeOut, {BackgroundTransparency = 1}):Play()
        elseif v:IsA("UIStroke") then
            TweenService:Create(v, fadeOut, {Transparency = 1}):Play()
        end
    end
    task.wait(2.7)
    introGui:Destroy()
    task.spawn(showWhatsNew)
end

-- ==========================================
-- [[ What's New Notification ]]
-- ==========================================
showWhatsNew = function()
    local updates = {
        "  Whitelist system",
        "  Auto Garp",
        "  Camera Shake detection",
        "  Main tab redesigned",
        "  Auto Follow updated to v3",
    }

    local wGui = Instance.new("ScreenGui")
    wGui.Name = "AzeerWhatsNew"; wGui.ResetOnSpawn = false
    wGui.DisplayOrder = 9999; wGui.Parent = CoreGui

    local lineH   = 17
    local topPad  = 26
    local botPad  = 7
    local totalH  = topPad + (#updates * lineH) + botPad

    local wFrame = Instance.new("Frame", wGui)
    wFrame.Size         = UDim2.new(0, 200, 0, totalH)
    wFrame.Position     = UDim2.new(1, 10, 0, 8)
    wFrame.AnchorPoint  = Vector2.new(1, 0)
    wFrame.BackgroundColor3 = Color3.fromRGB(6, 0, 0)
    wFrame.BorderSizePixel  = 0
    Instance.new("UICorner", wFrame).CornerRadius = UDim.new(0, 10)
    local wStroke = Instance.new("UIStroke", wFrame)
    wStroke.Color = Color3.fromRGB(200, 0, 0); wStroke.Thickness = 1.5

    local wTitle = Instance.new("TextLabel", wFrame)
    wTitle.Size     = UDim2.new(1, -10, 0, topPad)
    wTitle.Position = UDim2.new(0, 8, 0, 2)
    wTitle.BackgroundTransparency = 1
    wTitle.Text     = "● WHAT'S NEW"
    wTitle.TextColor3 = Color3.fromRGB(255, 55, 55)
    wTitle.Font     = Enum.Font.GothamBlack
    wTitle.TextSize = 11
    wTitle.TextXAlignment = Enum.TextXAlignment.Left

    local divider = Instance.new("Frame", wFrame)
    divider.Size     = UDim2.new(1, -16, 0, 1)
    divider.Position = UDim2.new(0, 8, 0, topPad - 2)
    divider.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
    divider.BorderSizePixel  = 0

    for i, txt in ipairs(updates) do
        local lbl = Instance.new("TextLabel", wFrame)
        lbl.Size     = UDim2.new(1, -14, 0, lineH)
        lbl.Position = UDim2.new(0, 10, 0, topPad + (i - 1) * lineH)
        lbl.BackgroundTransparency = 1
        lbl.Text     = txt
        lbl.TextColor3 = Color3.fromRGB(210, 210, 210)
        lbl.Font     = Enum.Font.Gotham
        lbl.TextSize = 10
        lbl.TextXAlignment = Enum.TextXAlignment.Left
    end

    TweenService:Create(wFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -8, 0, 8)}):Play()

    task.wait(3.5)

    local fadeInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad)
    TweenService:Create(wFrame, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(wStroke, fadeInfo, {Transparency = 1}):Play()
    for _, v in pairs(wFrame:GetDescendants()) do
        if v:IsA("TextLabel") then
            TweenService:Create(v, fadeInfo, {TextTransparency = 1}):Play()
        elseif v:IsA("Frame") then
            TweenService:Create(v, fadeInfo, {BackgroundTransparency = 1}):Play()
        end
    end
    task.wait(0.5)
    wGui:Destroy()
end

task.spawn(PlayIntro)

-- ==========================================
-- [[ NPC Script ]]
-- ==========================================

local targetUserId = 2885487339
local firstMsg = "Welcome!"
local secondMsg = "Warning: Play carefully. I am not responsible if you get banned."
local spawnDelay = 8

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

task.wait(spawnDelay)

character = player.Character or player.CharacterAdded:Wait()

local npc
local success, err = pcall(function()
    npc = Players:CreateHumanoidModelFromUserId(targetUserId)
end)

if success and npc then
    npc.Name = "Azeer"
    npc.Parent = game.Workspace

    local playerRoot = character:WaitForChild("HumanoidRootPart")
    npc:SetPrimaryPartCFrame(playerRoot.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, math.pi, 0))

    local head = npc:WaitForChild("Head")
    local billboard = Instance.new("BillboardGui", head)
    billboard.Size = UDim2.new(0, 300, 0, 100)
    billboard.ExtentsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Theme.Gold
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    local torso = npc:FindFirstChild("Torso")
    local humanoidRoot = npc:FindFirstChild("HumanoidRootPart")
    local humanoid = npc:FindFirstChildOfClass("Humanoid")
    local rightShoulder = torso and torso:FindFirstChild("Right Shoulder")
    local leftShoulder = torso and torso:FindFirstChild("Left Shoulder")
    local rightHip = torso and torso:FindFirstChild("Right Hip")
    local leftHip = torso and torso:FindFirstChild("Left Hip")
    local neck = torso and torso:FindFirstChild("Neck")

    local originalC0 = {}
    if rightShoulder then originalC0.RS = rightShoulder.C0 end
    if leftShoulder then originalC0.LS = leftShoulder.C0 end
    if rightHip then originalC0.RH = rightHip.C0 end
    if leftHip then originalC0.LH = leftHip.C0 end
    if neck then originalC0.N = neck.C0 end

    local isAlive = true
    local idleEnabled = true

    task.spawn(function()
        local startTime = tick()
        while isAlive and npc.Parent do
            if idleEnabled then
                local t = tick() - startTime
                local breathe = math.sin(t * 1.2) * 0.06
                local sway = math.sin(t * 0.8) * 0.04
                local headSway = math.sin(t * 0.6) * 0.08
                local headNod = math.sin(t * 0.9) * 0.03
                if neck and originalC0.N then
                    neck.C0 = originalC0.N * CFrame.Angles(headNod + breathe * 0.3, headSway, 0)
                end
                if rightShoulder and originalC0.RS then
                    rightShoulder.C0 = originalC0.RS * CFrame.Angles(breathe * 0.5, 0, sway + breathe * 0.4)
                end
                if leftShoulder and originalC0.LS then
                    leftShoulder.C0 = originalC0.LS * CFrame.Angles(breathe * 0.5, 0, -sway - breathe * 0.4)
                end
                if rightHip and originalC0.RH then
                    rightHip.C0 = originalC0.RH * CFrame.Angles(0, 0, sway * 0.3)
                end
                if leftHip and originalC0.LH then
                    leftHip.C0 = originalC0.LH * CFrame.Angles(0, 0, -sway * 0.3)
                end
            end
            task.wait(0.05)
        end
    end)

    local function lookAtPlayer()
        if neck and originalC0.N then
            local lookInfo = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            TweenService:Create(neck, lookInfo, {C0 = originalC0.N * CFrame.Angles(0.1, 0, 0)}):Play()
        end
    end

    local function naturalGreeting()
        if not rightShoulder then return end
        idleEnabled = false
        local raiseInfo = TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        TweenService:Create(rightShoulder, raiseInfo, {
            C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(0, math.pi/2, math.pi/1.3)
        }):Play()
        task.wait(0.7)
        for i = 1, 3 do
            TweenService:Create(rightShoulder, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(0, math.pi/2, math.pi/1.7)
            }):Play()
            task.wait(0.4)
            TweenService:Create(rightShoulder, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(0, math.pi/2, math.pi/1.1)
            }):Play()
            task.wait(0.4)
        end
        TweenService:Create(rightShoulder, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            C0 = originalC0.RS or CFrame.new(1, 0.5, 0) * CFrame.Angles(0, math.pi/2, 0)
        }):Play()
        task.wait(0.6)
        idleEnabled = true
    end

    local function naturalTalk()
        if not rightShoulder then return end
        idleEnabled = false
        local gestureInfo = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        TweenService:Create(rightShoulder, gestureInfo, {
            C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(-math.pi/3.5, math.pi/2, math.pi/10)
        }):Play()
        task.wait(0.6)
        for i = 1, 3 do
            TweenService:Create(rightShoulder, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(-math.pi/2.8, math.pi/2, math.pi/8)
            }):Play()
            task.wait(0.45)
            TweenService:Create(rightShoulder, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(-math.pi/4.5, math.pi/2, math.pi/12)
            }):Play()
            task.wait(0.45)
        end
        TweenService:Create(rightShoulder, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            C0 = originalC0.RS or CFrame.new(1, 0.5, 0) * CFrame.Angles(0, math.pi/2, 0)
        }):Play()
        task.wait(0.55)
        idleEnabled = true
    end

    local function naturalNod()
        if not neck or not originalC0.N then return end
        idleEnabled = false
        for i = 1, 2 do
            TweenService:Create(neck, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                C0 = originalC0.N * CFrame.Angles(0.25, 0, 0)
            }):Play()
            task.wait(0.4)
            TweenService:Create(neck, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                C0 = originalC0.N * CFrame.Angles(-0.05, 0, 0)
            }):Play()
            task.wait(0.4)
        end
        TweenService:Create(neck, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
            C0 = originalC0.N
        }):Play()
        task.wait(0.3)
        idleEnabled = true
    end

    label.Text = firstMsg
    lookAtPlayer()
    task.wait(0.3)
    task.spawn(naturalGreeting)
    task.wait(3.5)

    label.TextTransparency = 1
    task.wait(0.3)
    label.TextColor3 = Theme.Neon
    label.TextTransparency = 0
    label.Text = secondMsg

    task.spawn(naturalTalk)
    task.wait(3)
    naturalNod()
    task.wait(0.8)

    isAlive = false
    task.wait(0.2)
    label:Destroy()

    for _, item in pairs(npc:GetDescendants()) do
        if item:IsA("BasePart") then
            TweenService:Create(item, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {Transparency = 1}):Play()
        end
    end
    task.delay(1.3, function() npc:Destroy() end)
else
    warn("Error: " .. tostring(err))
end
