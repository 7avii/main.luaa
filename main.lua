--[[
=========================================================
            A Z E E R   H U B   (Delta Mobile)
=========================================================
]]

local Players      = game:GetService("Players")
local CoreGui      = game:GetService("CoreGui")
local RunService   = game:GetService("RunService")
local StarterGui   = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer  = Players.LocalPlayer

local EGG_DEEP   = Color3.fromRGB(28, 12, 40)
local EGG_DARK   = Color3.fromRGB(55, 22, 80)
local EGG_MAIN   = Color3.fromRGB(95, 40, 140)
local EGG_BRIGHT = Color3.fromRGB(155, 80, 215)
local EGG_SOFT   = Color3.fromRGB(200, 165, 240)
local TEXT_LIGHT = Color3.fromRGB(245, 235, 255)

local Whitelist = {
    ["7avii"]                = true,
    ["viper68280"]           = true,
    ["xmlk543"]              = true,
    ["lonko_1220"]           = true,
    ["Farisshamrrrrr"]       = true,
    ["hdjc038"]              = true,
    ["klkkklkllklkoollkllk"] = true,
    ["Hamzae_1"]             = true,
    ["Frcarewtwtr"]          = true,
    ["viper89447"]           = true,
    ["3MK_GOO2"]             = true,
    ["jjjiiimmm91"]          = true, -- التعديل هنا
    ["hnno122"]              = true,
}
if not Whitelist[LocalPlayer.Name] then return end

if LocalPlayer.Name == "viper68280" then
    StarterGui:SetCore("SendNotification", {
        Title = "A Z E E R SYSTEM", Text = "🔥 هلا بل شيخ viper",
        Duration = 5, Icon = "rbxassetid://127916282722332",
    })
else
    StarterGui:SetCore("SendNotification", {
        Title = "A Z E E R SYSTEM", Text = "العب بامان",
        Duration = 5, Icon = "rbxassetid://127916282722332",
    })
end

-- =========================================================
--                       INTRO
-- =========================================================
local function playAzeerIntro()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local head      = character:WaitForChild("Head")
    local camera    = workspace.CurrentCamera

    local introSound = Instance.new("Sound")
    introSound.SoundId = "rbxassetid://111028674888865"
    introSound.Volume  = 2
    introSound.Parent  = SoundService
    pcall(function() introSound:Play() end)

    local highlight = Instance.new("Highlight", character)
    highlight.FillTransparency    = 1
    highlight.OutlineColor        = EGG_BRIGHT
    highlight.OutlineTransparency = 1

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AzeerIntroGui"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = CoreGui

    local textLabel = Instance.new("TextLabel", screenGui)
    textLabel.Size = UDim2.new(1,0,1,0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "AZEER"
    textLabel.TextColor3 = EGG_BRIGHT
    textLabel.Font = Enum.Font.Antique
    textLabel.TextSize = 110
    textLabel.TextStrokeTransparency = 0.4
    textLabel.TextStrokeColor3 = EGG_DEEP
    textLabel.TextTransparency = 1

    local cameraOffset = Instance.new("CFrameValue")
    cameraOffset.Value = CFrame.new(0,3,15)
    camera.CameraType = Enum.CameraType.Scriptable

    local connection = RunService.RenderStepped:Connect(function()
        local shake = Vector3.new(math.random(-10,10)/500, math.random(-10,10)/500, 0)
        camera.CFrame = head.CFrame * cameraOffset.Value * CFrame.new(shake)
    end)

    TweenService:Create(cameraOffset, TweenInfo.new(3, Enum.EasingStyle.Cubic), {
        Value = CFrame.new(1,0.5,4) * CFrame.Angles(0, math.rad(10), 0)
    }):Play()
    TweenService:Create(highlight, TweenInfo.new(2), { OutlineTransparency = 0 }):Play()
    TweenService:Create(camera,    TweenInfo.new(3), { FieldOfView = 35 }):Play()
    task.wait(1)
    TweenService:Create(textLabel, TweenInfo.new(1.5), { TextTransparency = 0 }):Play()
    task.wait(3)

    local outInfo = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    TweenService:Create(highlight, TweenInfo.new(0.5), { OutlineTransparency = 1 }):Play()
    TweenService:Create(textLabel, TweenInfo.new(0.5), { TextTransparency    = 1 }):Play()
    local zoomOut = TweenService:Create(cameraOffset, outInfo, { Value = CFrame.new(0,4,18) })
    TweenService:Create(camera, outInfo, { FieldOfView = 70 }):Play()
    zoomOut:Play()
    zoomOut.Completed:Wait()

    connection:Disconnect()
    camera.CameraType = Enum.CameraType.Custom
    highlight:Destroy()
    screenGui:Destroy()
    local fadeOut = TweenService:Create(introSound, TweenInfo.new(1.2), { Volume = 0 })
    fadeOut:Play()
    fadeOut.Completed:Connect(function() introSound:Destroy() end)
end

task.spawn(playAzeerIntro)

-- =========================================================
--                      MAIN HUB
-- =========================================================
local hubGui = Instance.new("ScreenGui")
hubGui.Name = "AzeerHubGui"
hubGui.ResetOnSpawn = false
hubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
hubGui.Parent = CoreGui

local hub = Instance.new("Frame", hubGui)
hub.Size             = UDim2.new(0, 320, 0, 430)
hub.Position         = UDim2.new(0, 24, 0.22, 0)
hub.BackgroundColor3 = EGG_DEEP
hub.BorderSizePixel  = 0
hub.Active           = true
hub.Draggable        = true
Instance.new("UICorner", hub).CornerRadius = UDim.new(0, 20)

local hubGradient = Instance.new("UIGradient", hub)
hubGradient.Rotation = 90
hubGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, EGG_DARK),
    ColorSequenceKeypoint.new(1, EGG_DEEP),
})

local hubStroke = Instance.new("UIStroke", hub)
hubStroke.Color     = EGG_BRIGHT
hubStroke.Thickness = 2
hubStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local titleBar = Instance.new("Frame", hub)
titleBar.Size             = UDim2.new(1,0,0,46)
titleBar.BackgroundColor3 = EGG_MAIN
titleBar.BorderSizePixel  = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 20)

local titleMask = Instance.new("Frame", titleBar)
titleMask.Size             = UDim2.new(1,0,0.5,0)
titleMask.Position         = UDim2.new(0,0,0.5,0)
titleMask.BackgroundColor3 = EGG_MAIN
titleMask.BorderSizePixel  = 0
titleMask.ZIndex           = 0

local hubTitle = Instance.new("TextLabel", titleBar)
hubTitle.Size = UDim2.new(1,0,1,0)
hubTitle.BackgroundTransparency = 1
hubTitle.Text = "A Z E E R   H U B"
hubTitle.TextColor3 = TEXT_LIGHT
hubTitle.Font = Enum.Font.GothamBlack
hubTitle.TextSize = 22
hubTitle.TextStrokeTransparency = 0.7
hubTitle.TextStrokeColor3 = EGG_DEEP

local iconHolder = Instance.new("Frame", hub)
iconHolder.Size             = UDim2.new(0,110,0,110)
iconHolder.Position         = UDim2.new(0.5,-55,0,64)
iconHolder.BackgroundColor3 = EGG_DARK
iconHolder.BorderSizePixel  = 0
Instance.new("UICorner", iconHolder).CornerRadius = UDim.new(1,0)
local iconStroke = Instance.new("UIStroke", iconHolder)
iconStroke.Color = EGG_BRIGHT; iconStroke.Thickness = 3

local icon = Instance.new("ImageLabel", iconHolder)
icon.Size = UDim2.new(1,-8,1,-8)
icon.Position = UDim2.new(0,4,0,4)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://127916282722332"
icon.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", icon).CornerRadius = UDim.new(1,0)

local subTitle = Instance.new("TextLabel", hub)
subTitle.Size = UDim2.new(1,-24,0,22)
subTitle.Position = UDim2.new(0,12,0,180)
subTitle.BackgroundTransparency = 1
subTitle.Text = "MAIN  MENU"
subTitle.TextColor3 = EGG_SOFT
subTitle.Font = Enum.Font.GothamBold
subTitle.TextSize = 14

local divider = Instance.new("Frame", hub)
divider.Size             = UDim2.new(1,-40,0,1)
divider.Position         = UDim2.new(0,20,0,210)
divider.BackgroundColor3 = EGG_MAIN
divider.BorderSizePixel  = 0
divider.BackgroundTransparency = 0.3

local function makeHubBtn(text, yPos)
    local btn = Instance.new("TextButton", hub)
    btn.Size             = UDim2.new(1,-32,0,54)
    btn.Position         = UDim2.new(0,16,0,yPos)
    btn.BackgroundColor3 = EGG_MAIN
    btn.TextColor3       = TEXT_LIGHT
    btn.Font             = Enum.Font.GothamBlack
    btn.TextSize         = 20
    btn.AutoButtonColor  = false
    btn.Text             = text
    btn.BorderSizePixel  = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,14)
    local s = Instance.new("UIStroke", btn)
    s.Color = EGG_BRIGHT; s.Thickness = 1.5
    return btn
end

local autoBtn   = makeHubBtn("AUTO  :  OFF",   226)
local assistBtn = makeHubBtn("ASSIST  :  OFF", 290)
local shakeBtn  = makeHubBtn("SHAKE  :  OFF",  354)

-- =========================================================
--                       AUTO (FOLLOW)
-- =========================================================
local autoGui = Instance.new("ScreenGui")
autoGui.Name = "AzeerFollowerGui"; autoGui.ResetOnSpawn = false
autoGui.Enabled = false; autoGui.Parent = CoreGui

local sizeGui = Instance.new("ScreenGui")
sizeGui.Name = "AzeerSizeControlGui"; sizeGui.ResetOnSpawn = false
sizeGui.Enabled = false; sizeGui.Parent = CoreGui

local scale, minScale, maxScale, step = 1, 0.6, 1.8, 0.1

local frame = Instance.new("Frame", autoGui)
frame.Size = UDim2.new(0,300,0,130)
frame.Position = UDim2.new(0.5,-150,0.1,0)
frame.BackgroundColor3 = EGG_DEEP
frame.BorderSizePixel = 0
frame.Active = true; frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,18)
local fGradient = Instance.new("UIGradient", frame)
fGradient.Rotation = 90
fGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, EGG_DARK),
    ColorSequenceKeypoint.new(1, EGG_DEEP),
})
local strokeA = Instance.new("UIStroke", frame)
strokeA.Color = EGG_BRIGHT; strokeA.Thickness = 2

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0.4,0)
title.BackgroundTransparency = 1
title.Text = "A Z E E R"
title.TextColor3 = EGG_SOFT
title.Font = Enum.Font.GothamBlack
title.TextSize = 28
title.TextStrokeTransparency = 0.6
title.TextStrokeColor3 = EGG_DEEP

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9,0,0.45,0)
button.Position = UDim2.new(0.05,0,0.5,0)
button.BackgroundColor3 = EGG_MAIN
button.TextColor3 = TEXT_LIGHT
button.Font = Enum.Font.GothamBold
button.TextSize = 22
button.Text = "FOLLOW  :  OFF"
button.BorderSizePixel = 0; button.AutoButtonColor = false
Instance.new("UICorner", button).CornerRadius = UDim.new(0,14)
local btnStroke = Instance.new("UIStroke", button)
btnStroke.Color = EGG_BRIGHT; btnStroke.Thickness = 1.5

local sizeFrame = Instance.new("Frame", sizeGui)
sizeFrame.Size = UDim2.new(0,240,0,110)
sizeFrame.Position = UDim2.new(0.5,-120,0.28,0)
sizeFrame.BackgroundColor3 = EGG_DEEP
sizeFrame.BorderSizePixel = 0
sizeFrame.Active = true; sizeFrame.Draggable = true
Instance.new("UICorner", sizeFrame).CornerRadius = UDim.new(0,16)
local sGradient = Instance.new("UIGradient", sizeFrame)
sGradient.Rotation = 90
sGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, EGG_DARK),
    ColorSequenceKeypoint.new(1, EGG_DEEP),
})
local sizeStroke = Instance.new("UIStroke", sizeFrame)
sizeStroke.Color = EGG_BRIGHT; sizeStroke.Thickness = 2

local sizeTitle = Instance.new("TextLabel", sizeFrame)
sizeTitle.Size = UDim2.new(1,0,0,32)
sizeTitle.BackgroundTransparency = 1
sizeTitle.Text = "GUI  SIZE"
sizeTitle.TextColor3 = EGG_SOFT
sizeTitle.Font = Enum.Font.GothamBlack
sizeTitle.TextSize = 18

local function makeSizeBtn(text, xPos)
    local b = Instance.new("TextButton", sizeFrame)
    b.Size = UDim2.new(0,56,0,42); b.Position = UDim2.new(0,xPos,0,50)
    b.BackgroundColor3 = EGG_MAIN; b.TextColor3 = TEXT_LIGHT
    b.Font = Enum.Font.GothamBold; b.TextSize = 26
    b.Text = text; b.BorderSizePixel = 0; b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    local s = Instance.new("UIStroke", b); s.Color = EGG_BRIGHT; s.Thickness = 1.2
    return b
end

local minusButton = makeSizeBtn("-", 16)
local plusButton  = makeSizeBtn("+", 174)

local resetButton = Instance.new("TextButton", sizeFrame)
resetButton.Size = UDim2.new(0,90,0,42); resetButton.Position = UDim2.new(0,78,0,50)
resetButton.BackgroundColor3 = EGG_DARK; resetButton.TextColor3 = TEXT_LIGHT
resetButton.Font = Enum.Font.GothamBold; resetButton.TextSize = 14
resetButton.Text = "RESET"; resetButton.BorderSizePixel = 0; resetButton.AutoButtonColor = false
Instance.new("UICorner", resetButton).CornerRadius = UDim.new(0,10)
local resetStroke = Instance.new("UIStroke", resetButton)
resetStroke.Color = EGG_BRIGHT; resetStroke.Thickness = 1.2

local function applyScale()
    frame.Size = UDim2.new(0,300*scale,0,130*scale)
    title.TextSize = 28*scale; button.TextSize = 22*scale
    strokeA.Thickness = 2*scale
end
minusButton.MouseButton1Click:Connect(function() scale = math.clamp(scale-step,minScale,maxScale); applyScale() end)
plusButton.MouseButton1Click:Connect(function()  scale = math.clamp(scale+step,minScale,maxScale); applyScale() end)
resetButton.MouseButton1Click:Connect(function() scale = 1; applyScale() end)

local following = false
button.MouseButton1Click:Connect(function()
    following = not following
    button.Text = following and "FOLLOW  :  ON" or "FOLLOW  :  OFF"
    button.BackgroundColor3 = following and EGG_BRIGHT or EGG_MAIN
end)

local function getClosestFollow(root)
    local closest, shortest = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local d = (hrp.Position - root.Position).Magnitude
                if d < shortest then shortest = d; closest = p end
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
    local target = getClosestFollow(root)
    if not target or not target.Character then return end
    local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
    if not tRoot then return end
    local diff = root.Position - tRoot.Position
    if diff.Magnitude < 0.1 then return end
    local goal = tRoot.Position + diff.Unit * offsetDistance
    local now  = tick()
    if not lastGoal or (goal-lastGoal).Magnitude > 0.5 or (now-lastIssue) > 0.5 then
        hum:MoveTo(goal); lastGoal = goal; lastIssue = now
    end
end)

-- =========================================================
--                   ASSIST (MOVEMENT)
-- =========================================================
local assistGui = Instance.new("ScreenGui")
assistGui.Name = "AzeerMovementAssist"; assistGui.ResetOnSpawn = false
assistGui.Enabled = false; assistGui.Parent = CoreGui

local aFrame = Instance.new("Frame", assistGui)
aFrame.Size = UDim2.new(0,320,0,180)
aFrame.Position = UDim2.new(0.5,-160,0.12,0)
aFrame.BackgroundColor3 = EGG_DEEP; aFrame.BorderSizePixel = 0
aFrame.Active = true; aFrame.Draggable = true
Instance.new("UICorner", aFrame).CornerRadius = UDim.new(0,18)
local aGradient = Instance.new("UIGradient", aFrame)
aGradient.Rotation = 90
aGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, EGG_DARK), ColorSequenceKeypoint.new(1, EGG_DEEP),
})
local aStroke = Instance.new("UIStroke", aFrame)
aStroke.Color = EGG_BRIGHT; aStroke.Thickness = 2

local aTitle = Instance.new("TextLabel", aFrame)
aTitle.Size = UDim2.new(1,0,0,40); aTitle.BackgroundTransparency = 1
aTitle.Text = "MOVEMENT  ASSIST"; aTitle.TextColor3 = EGG_SOFT
aTitle.Font = Enum.Font.GothamBlack; aTitle.TextSize = 19

local statusLbl = Instance.new("TextLabel", aFrame)
statusLbl.Size = UDim2.new(1,-24,0,24); statusLbl.Position = UDim2.new(0,12,0,42)
statusLbl.BackgroundTransparency = 1; statusLbl.Text = "Status:  OFF"
statusLbl.TextColor3 = TEXT_LIGHT; statusLbl.Font = Enum.Font.GothamBold; statusLbl.TextSize = 13

local targetLabel = Instance.new("TextLabel", aFrame)
targetLabel.Size = UDim2.new(1,-24,0,22); targetLabel.Position = UDim2.new(0,12,0,66)
targetLabel.BackgroundTransparency = 1; targetLabel.Text = "Target:  None"
targetLabel.TextColor3 = EGG_SOFT; targetLabel.Font = Enum.Font.GothamSemibold
targetLabel.TextSize = 12; targetLabel.TextTruncate = Enum.TextTruncate.AtEnd

local toggle = Instance.new("TextButton", aFrame)
toggle.Size = UDim2.new(1,-24,0,38); toggle.Position = UDim2.new(0,12,0,96)
toggle.BackgroundColor3 = EGG_MAIN; toggle.Text = "ASSIST  OFF"
toggle.TextColor3 = TEXT_LIGHT; toggle.Font = Enum.Font.GothamBlack
toggle.TextSize = 16; toggle.BorderSizePixel = 0; toggle.AutoButtonColor = false
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,12)
local toggleStroke = Instance.new("UIStroke", toggle)
toggleStroke.Color = EGG_BRIGHT; toggleStroke.Thickness = 1.5

local powerButton = Instance.new("TextButton", aFrame)
powerButton.Size = UDim2.new(0.48,-12,0,32); powerButton.Position = UDim2.new(0,12,0,140)
powerButton.BackgroundColor3 = EGG_DARK; powerButton.Text = "POWER:  30%"
powerButton.TextColor3 = TEXT_LIGHT; powerButton.Font = Enum.Font.GothamBlack
powerButton.TextSize = 13; powerButton.BorderSizePixel = 0; powerButton.AutoButtonColor = false
Instance.new("UICorner", powerButton).CornerRadius = UDim.new(0,10)
local powerStroke = Instance.new("UIStroke", powerButton)
powerStroke.Color = EGG_BRIGHT; powerStroke.Thickness = 1.2

local rangeButton = Instance.new("TextButton", aFrame)
rangeButton.Size = UDim2.new(0.48,-12,0,32); rangeButton.Position = UDim2.new(0.52,0,0,140)
rangeButton.BackgroundColor3 = EGG_DARK; rangeButton.Text = "RANGE:  45"
rangeButton.TextColor3 = TEXT_LIGHT; rangeButton.Font = Enum.Font.GothamBlack
rangeButton.TextSize = 13; rangeButton.BorderSizePixel = 0; rangeButton.AutoButtonColor = false
Instance.new("UICorner", rangeButton).CornerRadius = UDim.new(0,10)
local rangeStroke = Instance.new("UIStroke", rangeButton)
rangeStroke.Color = EGG_BRIGHT; rangeStroke.Thickness = 1.2

local assistActive = false
local powers = {0.20,0.25,0.30,0.35,0.40}; local powerIndex = 3
local ranges  = {30,45,60,80};              local rangeIndex  = 2

local function updateUI()
    powerButton.Text = "POWER:  "..math.floor(powers[powerIndex]*100).."%"
    rangeButton.Text = "RANGE:  "..ranges[rangeIndex]
    if assistActive then
        toggle.Text = "ASSIST  ON"; statusLbl.Text = "Status:  ON"
        toggle.BackgroundColor3 = EGG_BRIGHT
    else
        toggle.Text = "ASSIST  OFF"; statusLbl.Text = "Status:  OFF"
        targetLabel.Text = "Target:  None"; toggle.BackgroundColor3 = EGG_MAIN
    end
end
toggle.MouseButton1Click:Connect(function() assistActive = not assistActive; updateUI() end)
powerButton.MouseButton1Click:Connect(function() powerIndex = powerIndex%#powers+1; updateUI() end)
rangeButton.MouseButton1Click:Connect(function() rangeIndex = rangeIndex%#ranges+1; updateUI() end)

local function getClosestTarget(root, maxRange)
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
    local target = getClosestTarget(root, ranges[rangeIndex])
    if not target or not target.Character then targetLabel.Text = "Target:  None"; return end
    local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
    if not tRoot then return end
    targetLabel.Text = "Target:  "..target.Name
    local tDir = tRoot.Position - root.Position
    tDir = Vector3.new(tDir.X,0,tDir.Z)
    if tDir.Magnitude <= 0.1 then return end
    local power   = powers[powerIndex]
    local blended = (hum.MoveDirection.Unit*(1-power)) + (tDir.Unit*power)
    if blended.Magnitude > 0 then hum:Move(blended.Unit, false) end
end)

updateUI()

-- =========================================================
--                   SHAKE (CAMERA) - UPDATED
-- =========================================================
local INTENSITY  = 0.5
local SPEED      = 2
local SHAKE_STRENGTH = 3
local DATA_STRING = "-433,-1247,-1362,-789,-1128,-756,-683,371,949,1488,1049,365,-865,-1529,-1627,-1199,-927,-735,-213,829,2108,2198,1141,4,-1266,-2034,-1353,-811,-732,-374,748,2096,2863,1610,687,-476,-1413,-1596,-1158,-842,-917,316,1333,2232,1665,1132,-593,-1265,-1422,-937,-1020,-381,-21,547,2311,2871,753,147,-596,-1403,-1110,-889,-514,-159,0,819,2337,1511,910,-700,-1611,-1585,-768,-719,-410,-75,-1,1219,1248,538,-1,-1141,-1084,-1135,-840,-496,-77,-1,1669,2519,1747,384,-1132,-1769,-1526,-1251,-874,-874,262,1156,2514,2803,1727,352,-1,-2698,-1773,-1172,-739,-774,101,431,77,-238,-745,-706,-609,-342,651,1160,2161,3306,2362,546,-1,-2269,-2316,-1575,-1003,-571,-301,0,435,912,398,0,-567,-1218,-1162,-850,-897,94,1076,1498,2391,868,145,-752,-2286,-2065,-1277,-878,-348,-1,1246,3095,2718,741,-1,-1303,-2180,-1849,-1146,-692,-857,1111,1862,3438,1603,244,-1330,-2259,-1900,-1443,-1019,-497,-106,892,2945,3263,1518,193,-1543,-2228,-2274,-1373,-1261,-695,199,1403,2642,2438,856,69,-940,-1652,-1532,-1125,-764,-345,988,2016,2861,2128,647,-954,-1746,-1924,-1205,-1130,-570,-632,1393,1825,2915,503,73,-899,-1745,-1532,-1194,-641,-204,-1,1279,2991,1845,676,0,-1333,-1988,-1681,-1283,-758,-309,-1,1162,3010,3523,1190"

local shakeFrames = {}
for val in DATA_STRING:gmatch("([^,]+)") do
    local n = tonumber(val)
    if n then table.insert(shakeFrames, (n/10000) * INTENSITY) end
end

local shakeGui = Instance.new("ScreenGui")
shakeGui.Name = "AzeerShakeGui"; shakeGui.ResetOnSpawn = false
shakeGui.Enabled = false; shakeGui.Parent = CoreGui

local shakeFrame = Instance.new("Frame", shakeGui)
shakeFrame.Size             = UDim2.new(0, 260, 0, 110)
shakeFrame.Position         = UDim2.new(0.5, -130, 0.45, 0)
shakeFrame.BackgroundColor3 = EGG_DEEP
shakeFrame.BorderSizePixel  = 0
shakeFrame.Active           = true
shakeFrame.Draggable        = true
Instance.new("UICorner", shakeFrame).CornerRadius = UDim.new(0, 15)

local shakeGradient = Instance.new("UIGradient", shakeFrame)
shakeGradient.Rotation = 90
shakeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, EGG_DARK),
    ColorSequenceKeypoint.new(1, EGG_DEEP),
})

local shakeStroke = Instance.new("UIStroke", shakeFrame)
shakeStroke.Color = EGG_BRIGHT; shakeStroke.Thickness = 2

local shakeTitle = Instance.new("TextLabel", shakeFrame)
shakeTitle.Size                   = UDim2.new(1, 0, 0, 45)
shakeTitle.BackgroundTransparency = 1
shakeTitle.Text                   = "CAMERA SHAKE"
shakeTitle.TextColor3             = EGG_SOFT
shakeTitle.Font                   = Enum.Font.GothamBlack
shakeTitle.TextSize               = 18

local shakeToggle = Instance.new("TextButton", shakeFrame)
shakeToggle.Size             = UDim2.new(0.9, 0, 0, 42)
shakeToggle.Position         = UDim2.new(0.05, 0, 0, 52)
shakeToggle.BackgroundColor3 = EGG_MAIN
shakeToggle.TextColor3       = TEXT_LIGHT
shakeToggle.Font             = Enum.Font.GothamBlack
shakeToggle.TextSize         = 16
shakeToggle.Text             = "SHAKE: OFF"
shakeToggle.BorderSizePixel  = 0
shakeToggle.AutoButtonColor  = false
Instance.new("UICorner", shakeToggle).CornerRadius = UDim.new(0, 10)
local st = Instance.new("UIStroke", shakeToggle); st.Color = EGG_BRIGHT; st.Thickness = 1.5

local isShaking  = false
local shakeConn  = nil
local shakeTimer = 0
local shakeIndex = 1

local function stopShake()
    isShaking = false
    if shakeConn then shakeConn:Disconnect(); shakeConn = nil end
    shakeToggle.Text             = "SHAKE: OFF"
    shakeToggle.BackgroundColor3 = EGG_MAIN
    shakeStroke.Color            = EGG_BRIGHT
end

local function startShake()
    if isShaking then return end
    isShaking  = true
    shakeTimer = 0
    shakeIndex = 1
    shakeToggle.Text             = "SHAKE: ON"
    shakeToggle.BackgroundColor3 = EGG_BRIGHT
    shakeStroke.Color            = EGG_SOFT

    local camera = workspace.CurrentCamera
    shakeConn = RunService.RenderStepped:Connect(function(dt)
        local char = LocalPlayer.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp or UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then return end

        shakeTimer = shakeTimer + (dt * SPEED)
        shakeIndex = math.floor(shakeTimer * 60) + 1
        if shakeIndex > #shakeFrames then
            shakeIndex = 1; shakeTimer = 0
        end

        local yaw   = shakeFrames[shakeIndex] * SHAKE_STRENGTH
        local pivot = hrp.CFrame.Position
        camera.CFrame = CFrame.new(pivot)
            * CFrame.Angles(0, yaw, 0)
            * CFrame.new(-pivot)
            * camera.CFrame
    end)
end

shakeToggle.MouseButton1Click:Connect(function()
    if isShaking then stopShake() else startShake() end
end)

-- =========================================================
--               HUB Buttons => Open / Close
-- =========================================================
local autoOpen, assistOpen, shakeOpen = false, false, false

autoBtn.MouseButton1Click:Connect(function()
    autoOpen = not autoOpen
    autoGui.Enabled  = autoOpen
    sizeGui.Enabled  = autoOpen
    autoBtn.Text             = autoOpen and "AUTO  :  ON" or "AUTO  :  OFF"
    autoBtn.BackgroundColor3 = autoOpen and EGG_BRIGHT or EGG_MAIN
end)

assistBtn.MouseButton1Click:Connect(function()
    assistOpen = not assistOpen
    assistGui.Enabled        = assistOpen
    assistBtn.Text             = assistOpen and "ASSIST  :  ON" or "ASSIST  :  OFF"
    assistBtn.BackgroundColor3 = assistOpen and EGG_BRIGHT or EGG_MAIN
end)

shakeBtn.MouseButton1Click:Connect(function()
    shakeOpen = not shakeOpen
    shakeGui.Enabled         = shakeOpen
    shakeBtn.Text             = shakeOpen and "SHAKE  :  ON" or "SHAKE  :  OFF"
    shakeBtn.BackgroundColor3 = shakeOpen and EGG_BRIGHT or EGG_MAIN
    if not shakeOpen and isShaking then stopShake() end
end)
