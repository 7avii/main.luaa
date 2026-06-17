-- ══════════════════════════
--   HM INTRO  ->  HM UI
--   Cinematic Sequence
-- ══════════════════════════

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")

local function tw(obj, props, t, style, dir)
    local tween = TweenService:Create(
        obj,
        TweenInfo.new(t or 0.5, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out),
        props
    )
    tween:Play()
    return tween
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━
-- HM UI — launched after intro ends
-- ━━━━━━━━━━━━━━━━━━━━━━━━
local function launchUI()
    local C = {
        bg    = Color3.fromRGB(8,  0,  0),
        panel = Color3.fromRGB(14, 2,  2),
        card  = Color3.fromRGB(20, 5,  5),
        blood = Color3.fromRGB(140, 0,  0),
        red   = Color3.fromRGB(200, 15, 15),
        glow  = Color3.fromRGB(255, 40, 40),
        white = Color3.new(1, 1, 1),
        muted = Color3.fromRGB(180, 120, 120),
        dim   = Color3.fromRGB(60,  20, 20),
    }

    if game.CoreGui:FindFirstChild("HM_UI") then
        game.CoreGui:FindFirstChild("HM_UI"):Destroy()
    end

    local Screen = Instance.new("ScreenGui", game.CoreGui)
    Screen.Name           = "HM_UI"
    Screen.ResetOnSpawn   = false
    Screen.IgnoreGuiInset = true
    Screen.DisplayOrder   = 9999

    -- ── Window ──
    local Win = Instance.new("Frame", Screen)
    Win.Size             = UDim2.new(0, 420, 0, 400)
    Win.Position         = UDim2.new(0.5, -210, 0.5, -200)
    Win.BackgroundColor3 = C.bg
    Win.BackgroundTransparency = 1
    Win.BorderSizePixel  = 0
    Win.ClipsDescendants = true
    Instance.new("UICorner", Win).CornerRadius = UDim.new(0, 14)

    -- Background image
    local BG = Instance.new("ImageLabel", Win)
    BG.Size                   = UDim2.new(1, 0, 1, 0)
    BG.BackgroundTransparency = 1
    BG.Image                  = "rbxthumb://type=Asset&id=103122892052801&w=420&h=420"
    BG.ImageTransparency      = 1
    BG.ScaleType              = Enum.ScaleType.Crop
    BG.ZIndex                 = 1
    Instance.new("UICorner", BG).CornerRadius = UDim.new(0, 14)

    -- Dark overlay for text readability
    local OV = Instance.new("Frame", Win)
    OV.Size = UDim2.new(1, 0, 1, 0)
    OV.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OV.BackgroundTransparency = 1
    OV.BorderSizePixel = 0; OV.ZIndex = 2
    Instance.new("UICorner", OV).CornerRadius = UDim.new(0, 14)

    -- ── Title Bar ──
    local TitleBar = Instance.new("Frame", Win)
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.BackgroundColor3 = C.panel
    TitleBar.BackgroundTransparency = 1
    TitleBar.BorderSizePixel = 0; TitleBar.ZIndex = 10

    -- HM Badge
    local badge = Instance.new("Frame", TitleBar)
    badge.Size = UDim2.new(0, 40, 0, 32)
    badge.Position = UDim2.new(0, 12, 0.5, -16)
    badge.BackgroundColor3 = C.blood
    badge.BackgroundTransparency = 1
    badge.BorderSizePixel = 0; badge.ZIndex = 11
    Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 6)
    local bStr = Instance.new("UIStroke", badge)
    bStr.Color = C.glow; bStr.Thickness = 1.5; bStr.Transparency = 1

    local badgeTxt = Instance.new("TextLabel", badge)
    badgeTxt.Size = UDim2.new(1, 0, 1, 0)
    badgeTxt.BackgroundTransparency = 1
    badgeTxt.Text = "HM"
    badgeTxt.TextColor3 = C.white
    badgeTxt.TextTransparency = 1
    badgeTxt.TextSize = 15; badgeTxt.Font = Enum.Font.GothamBlack; badgeTxt.ZIndex = 12

    -- Title text
    local titleTxt = Instance.new("TextLabel", TitleBar)
    titleTxt.Size = UDim2.new(0, 200, 1, 0)
    titleTxt.Position = UDim2.new(0, 60, 0, 0)
    titleTxt.BackgroundTransparency = 1
    titleTxt.Text = "HM  |  PREMIUM"
    titleTxt.TextColor3 = C.white
    titleTxt.TextTransparency = 1
    titleTxt.TextSize = 14
    titleTxt.Font = Enum.Font.GothamBold
    titleTxt.TextXAlignment = Enum.TextXAlignment.Left; titleTxt.ZIndex = 11

    -- Live dot
    local dot = Instance.new("Frame", TitleBar)
    dot.Size = UDim2.new(0, 7, 0, 7)
    dot.Position = UDim2.new(0, 238, 0.5, -3)
    dot.BackgroundColor3 = C.glow
    dot.BackgroundTransparency = 1
    dot.BorderSizePixel = 0; dot.ZIndex = 11
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    -- Minimize button
    local minBtn = Instance.new("TextButton", TitleBar)
    minBtn.Size = UDim2.new(0, 26, 0, 26)
    minBtn.Position = UDim2.new(1, -62, 0.5, -13)
    minBtn.BackgroundColor3 = C.dim
    minBtn.BackgroundTransparency = 1
    minBtn.Text = "—"; minBtn.TextColor3 = C.muted
    minBtn.TextTransparency = 1
    minBtn.TextSize = 12; minBtn.Font = Enum.Font.GothamBold
    minBtn.BorderSizePixel = 0; minBtn.ZIndex = 11
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

    -- Close button
    local closeBtn = Instance.new("TextButton", TitleBar)
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -30, 0.5, -13)
    closeBtn.BackgroundColor3 = C.blood
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "x"; closeBtn.TextColor3 = C.white
    closeBtn.TextTransparency = 1
    closeBtn.TextSize = 12; closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0; closeBtn.ZIndex = 11
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

    -- Ping label (right side before buttons, hidden by default)
    local pingLabel = Instance.new("TextLabel", TitleBar)
    pingLabel.Size = UDim2.new(0, 82, 0, 22)
    pingLabel.Position = UDim2.new(1, -158, 0.5, -11)
    pingLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    pingLabel.BackgroundTransparency = 1
    pingLabel.BorderSizePixel = 0
    pingLabel.Text = "PING  --"
    pingLabel.TextColor3 = C.white
    pingLabel.TextSize = 11; pingLabel.Font = Enum.Font.GothamBold
    pingLabel.TextTransparency = 1
    pingLabel.ZIndex = 13
    Instance.new("UICorner", pingLabel).CornerRadius = UDim.new(0, 5)

    -- Divider line
    local divLine = Instance.new("Frame", Win)
    divLine.Size = UDim2.new(1, -24, 0, 1)
    divLine.Position = UDim2.new(0, 12, 0, 50)
    divLine.BackgroundColor3 = C.blood
    divLine.BackgroundTransparency = 1
    divLine.BorderSizePixel = 0; divLine.ZIndex = 10

    -- Scroll area
    local Scroll = Instance.new("ScrollingFrame", Win)
    Scroll.Size = UDim2.new(1, -16, 1, -60)
    Scroll.Position = UDim2.new(0, 8, 0, 56)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 2
    Scroll.ScrollBarImageColor3 = C.blood
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 70)
    Scroll.ZIndex = 12

    -- ── Component builders ──

    local function ripple(parent, z)
        local r = Instance.new("Frame", parent)
        r.Size = UDim2.new(0, 0, 0, 0); r.Position = UDim2.new(0.5, 0, 0.5, 0)
        r.AnchorPoint = Vector2.new(0.5, 0.5); r.BackgroundColor3 = C.glow
        r.BackgroundTransparency = 0.5; r.BorderSizePixel = 0; r.ZIndex = z or 25
        Instance.new("UICorner", r).CornerRadius = UDim.new(1, 0)
        tw(r, {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}, 0.4, Enum.EasingStyle.Quad)
        task.delay(0.4, function() r:Destroy() end)
    end

    local function makeSection(y, text)
        local row = Instance.new("Frame", Scroll)
        row.Size = UDim2.new(1, -8, 0, 22); row.Position = UDim2.new(0, 4, 0, y)
        row.BackgroundTransparency = 1; row.ZIndex = 14

        local line = Instance.new("Frame", row)
        line.Size = UDim2.new(1, 0, 0, 1); line.Position = UDim2.new(0, 0, 0.5, 0)
        line.BackgroundColor3 = C.blood; line.BackgroundTransparency = 0.5
        line.BorderSizePixel = 0; line.ZIndex = 14

        local bg = Instance.new("Frame", row)
        bg.Position = UDim2.new(0.5, 0, 0, 0); bg.AnchorPoint = Vector2.new(0.5, 0)
        bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0); bg.BackgroundTransparency = 0.1
        bg.BorderSizePixel = 0; bg.AutomaticSize = Enum.AutomaticSize.X
        bg.Size = UDim2.new(0, 0, 1, 0); bg.ZIndex = 15

        local lbl = Instance.new("TextLabel", bg)
        lbl.BackgroundTransparency = 1; lbl.Text = "  " .. text .. "  "
        lbl.TextColor3 = C.glow; lbl.TextSize = 10; lbl.Font = Enum.Font.GothamBold
        lbl.AutomaticSize = Enum.AutomaticSize.X
        lbl.Size = UDim2.new(0, 0, 1, 0); lbl.ZIndex = 16
    end

    local function makeToggle(y, icon, label, default)
        local c = Instance.new("Frame", Scroll)
        c.Size = UDim2.new(1, -8, 0, 42); c.Position = UDim2.new(0, 4, 0, y)
        c.BackgroundColor3 = C.card; c.BackgroundTransparency = 0.4
        c.BorderSizePixel = 0; c.ZIndex = 14; c.ClipsDescendants = true
        Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)
        local cs = Instance.new("UIStroke", c); cs.Color = C.dim; cs.Thickness = 1

        local side = Instance.new("Frame", c)
        side.Size = UDim2.new(0, 3, 0.6, 0); side.Position = UDim2.new(0, 0, 0.2, 0)
        side.BackgroundColor3 = default and C.glow or C.dim
        side.BorderSizePixel = 0; side.ZIndex = 15
        Instance.new("UICorner", side).CornerRadius = UDim.new(1, 0)

        local il = Instance.new("TextLabel", c)
        il.Size = UDim2.new(0, 26, 0, 26); il.Position = UDim2.new(0, 10, 0.5, -13)
        il.BackgroundTransparency = 1; il.Text = icon; il.TextSize = 15; il.ZIndex = 15

        local lbl = Instance.new("TextLabel", c)
        lbl.Size = UDim2.new(1, -105, 1, 0); lbl.Position = UDim2.new(0, 42, 0, 0)
        lbl.BackgroundTransparency = 1; lbl.Text = label
        lbl.TextColor3 = C.white; lbl.TextSize = 13; lbl.Font = Enum.Font.GothamMedium
        lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 15

        local tBg = Instance.new("Frame", c)
        tBg.Size = UDim2.new(0, 40, 0, 20); tBg.Position = UDim2.new(1, -48, 0.5, -10)
        tBg.BackgroundColor3 = default and C.blood or C.dim
        tBg.BackgroundTransparency = default and 0.25 or 0.1
        tBg.BorderSizePixel = 0; tBg.ZIndex = 15
        Instance.new("UICorner", tBg).CornerRadius = UDim.new(1, 0)
        local tStr = Instance.new("UIStroke", tBg)
        tStr.Color = default and C.glow or C.dim; tStr.Thickness = 1.2

        local circ = Instance.new("Frame", tBg)
        circ.Size = UDim2.new(0, 14, 0, 14)
        circ.Position = default and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        circ.BackgroundColor3 = C.white; circ.BorderSizePixel = 0; circ.ZIndex = 16
        Instance.new("UICorner", circ).CornerRadius = UDim.new(1, 0)

        local val = default or false
        local btn = Instance.new("TextButton", c)
        btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1
        btn.Text = ""; btn.ZIndex = 17

        btn.MouseButton1Click:Connect(function()
            val = not val; ripple(c, 17)
            tw(tBg, {BackgroundColor3 = val and C.blood or C.dim, BackgroundTransparency = val and 0.25 or 0.1}, 0.2)
            tw(tStr, {Color = val and C.glow or C.dim}, 0.2)
            tw(circ, {Position = val and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)}, 0.2)
            tw(side, {BackgroundColor3 = val and C.glow or C.dim}, 0.2)
        end)
        btn.MouseEnter:Connect(function() tw(c, {BackgroundTransparency = 0.22}, 0.12) end)
        btn.MouseLeave:Connect(function() tw(c, {BackgroundTransparency = 0.4},  0.12) end)
    end

    local function makeButton(y, icon, label, cb)
        local c = Instance.new("Frame", Scroll)
        c.Size = UDim2.new(1, -8, 0, 40); c.Position = UDim2.new(0, 4, 0, y)
        c.BackgroundColor3 = C.blood; c.BackgroundTransparency = 0.6
        c.BorderSizePixel = 0; c.ZIndex = 14; c.ClipsDescendants = true
        Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)
        local cs = Instance.new("UIStroke", c); cs.Color = C.glow; cs.Thickness = 1; cs.Transparency = 0.5

        local side = Instance.new("Frame", c)
        side.Size = UDim2.new(0, 3, 0.6, 0); side.Position = UDim2.new(0, 0, 0.2, 0)
        side.BackgroundColor3 = C.glow; side.BorderSizePixel = 0; side.ZIndex = 15
        Instance.new("UICorner", side).CornerRadius = UDim.new(1, 0)

        local lbl = Instance.new("TextLabel", c)
        lbl.Size = UDim2.new(1, -36, 1, 0); lbl.Position = UDim2.new(0, 14, 0, 0)
        lbl.BackgroundTransparency = 1; lbl.Text = icon .. "  " .. label
        lbl.TextColor3 = C.white; lbl.TextSize = 13; lbl.Font = Enum.Font.GothamBold
        lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 15

        local arr = Instance.new("TextLabel", c)
        arr.Size = UDim2.new(0, 22, 1, 0); arr.Position = UDim2.new(1, -24, 0, 0)
        arr.BackgroundTransparency = 1; arr.Text = ">"
        arr.TextColor3 = C.glow; arr.TextSize = 20; arr.Font = Enum.Font.GothamBold; arr.ZIndex = 15

        local btn = Instance.new("TextButton", c)
        btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1
        btn.Text = ""; btn.ZIndex = 16

        btn.MouseButton1Click:Connect(function()
            ripple(c, 16)
            tw(c, {BackgroundTransparency = 0.35}, 0.1)
            task.delay(0.18, function() tw(c, {BackgroundTransparency = 0.6}, 0.2) end)
            if cb then cb() end
        end)
        btn.MouseEnter:Connect(function() tw(c, {BackgroundTransparency = 0.45}, 0.12) end)
        btn.MouseLeave:Connect(function() tw(c, {BackgroundTransparency = 0.6},  0.12) end)
    end

    local function makeSlider(y, icon, label, min, max, default)
        local c = Instance.new("Frame", Scroll)
        c.Size = UDim2.new(1, -8, 0, 56); c.Position = UDim2.new(0, 4, 0, y)
        c.BackgroundColor3 = C.card; c.BackgroundTransparency = 0.4
        c.BorderSizePixel = 0; c.ZIndex = 14
        Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)
        local cs = Instance.new("UIStroke", c); cs.Color = C.dim; cs.Thickness = 1

        local side = Instance.new("Frame", c)
        side.Size = UDim2.new(0, 3, 0.6, 0); side.Position = UDim2.new(0, 0, 0.2, 0)
        side.BackgroundColor3 = C.blood; side.BorderSizePixel = 0; side.ZIndex = 15
        Instance.new("UICorner", side).CornerRadius = UDim.new(1, 0)

        local top = Instance.new("Frame", c)
        top.Size = UDim2.new(1, -16, 0, 22); top.Position = UDim2.new(0, 12, 0, 6)
        top.BackgroundTransparency = 1; top.ZIndex = 15

        local lbl = Instance.new("TextLabel", top)
        lbl.Size = UDim2.new(0.75, 0, 1, 0); lbl.BackgroundTransparency = 1
        lbl.Text = icon .. "  " .. label; lbl.TextColor3 = C.white; lbl.TextSize = 12
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 15

        local valLbl = Instance.new("TextLabel", top)
        valLbl.Size = UDim2.new(0.25, 0, 1, 0); valLbl.Position = UDim2.new(0.75, 0, 0, 0)
        valLbl.BackgroundTransparency = 1; valLbl.Text = tostring(default)
        valLbl.TextColor3 = C.glow; valLbl.TextSize = 12; valLbl.Font = Enum.Font.GothamBold
        valLbl.TextXAlignment = Enum.TextXAlignment.Right; valLbl.ZIndex = 15

        local track = Instance.new("Frame", c)
        track.Size = UDim2.new(1, -20, 0, 4); track.Position = UDim2.new(0, 12, 0, 40)
        track.BackgroundColor3 = C.dim; track.BackgroundTransparency = 0.2
        track.BorderSizePixel = 0; track.ZIndex = 15
        Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

        local pct = (default - min) / (max - min)
        local fill = Instance.new("Frame", track)
        fill.Size = UDim2.new(pct, 0, 1, 0); fill.BackgroundColor3 = C.red
        fill.BackgroundTransparency = 0.2; fill.BorderSizePixel = 0; fill.ZIndex = 16
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local thumb = Instance.new("Frame", track)
        thumb.Size = UDim2.new(0, 14, 0, 14); thumb.Position = UDim2.new(pct, -7, 0.5, -7)
        thumb.BackgroundColor3 = C.white; thumb.BorderSizePixel = 0; thumb.ZIndex = 17
        Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)
        local tStr = Instance.new("UIStroke", thumb); tStr.Color = C.glow; tStr.Thickness = 1.8

        local dragging = false
        thumb.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch) then
                local rel = math.clamp(
                    (i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                fill.Size = UDim2.new(rel, 0, 1, 0)
                thumb.Position = UDim2.new(rel, -7, 0.5, -7)
                valLbl.Text = tostring(math.floor(min + (max - min) * rel))
            end
        end)
    end

    -- Welcome card
    local welcome = Instance.new("Frame", Scroll)
    welcome.Size = UDim2.new(1, -8, 0, 60); welcome.Position = UDim2.new(0, 4, 0, 4)
    welcome.BackgroundColor3 = C.blood; welcome.BackgroundTransparency = 0.5
    welcome.BorderSizePixel = 0; welcome.ZIndex = 14; welcome.ClipsDescendants = true
    Instance.new("UICorner", welcome).CornerRadius = UDim.new(0, 10)
    local wStr = Instance.new("UIStroke", welcome)
    wStr.Color = C.glow; wStr.Thickness = 1.2; wStr.Transparency = 0.4

    local wT = Instance.new("TextLabel", welcome)
    wT.Size = UDim2.new(1, -14, 0, 26); wT.Position = UDim2.new(0, 12, 0, 6)
    wT.BackgroundTransparency = 1
    wT.Text = "  Welcome,  " .. Players.LocalPlayer.Name
    wT.TextColor3 = C.white; wT.TextSize = 14; wT.Font = Enum.Font.GothamBold
    wT.TextXAlignment = Enum.TextXAlignment.Left; wT.ZIndex = 15

    local wS = Instance.new("TextLabel", welcome)
    wS.Size = UDim2.new(1, -14, 0, 18); wS.Position = UDim2.new(0, 12, 0, 34)
    wS.BackgroundTransparency = 1; wS.Text = "HM  |  PREMIUM EDITION"
    wS.TextColor3 = C.glow; wS.TextSize = 11; wS.Font = Enum.Font.GothamMedium
    wS.TextXAlignment = Enum.TextXAlignment.Left; wS.ZIndex = 15

    -- ── Window drag ──
    local drag, ds, wp = false, nil, nil
    TitleBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = true; ds = i.Position; wp = Win.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - ds
            Win.Position = UDim2.new(wp.X.Scale, wp.X.Offset + d.X,
                                     wp.Y.Scale, wp.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)

    -- Minimize / Close
    local mini = false
    minBtn.MouseButton1Click:Connect(function()
        mini = not mini
        tw(Win, {Size = mini and UDim2.new(0, 420, 0, 50) or UDim2.new(0, 420, 0, 400)},
            0.35, Enum.EasingStyle.Back)
        minBtn.Text = mini and "[ ]" or "—"
        if mini then
            tw(pingLabel, {TextTransparency = 0, BackgroundTransparency = 0.35}, 0.3)
        else
            tw(pingLabel, {TextTransparency = 1, BackgroundTransparency = 1}, 0.2)
        end
    end)

    -- FPS & Ping updater
    task.spawn(function()
        local lp = game:GetService("Players").LocalPlayer
        while Win and Win.Parent do
            local ping = math.floor(lp:GetNetworkPing() * 1000)
            pingLabel.Text = "PING  " .. ping .. "ms"
            task.wait(0.5)
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        tw(Win, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1},
            0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.delay(0.3, function() Screen:Destroy() end)
    end)

    -- Dot pulse
    task.spawn(function()
        while dot and dot.Parent do
            tw(dot, {BackgroundTransparency = 0.8}, 0.8)
            task.wait(0.8)
            tw(dot, {BackgroundTransparency = 0},   0.8)
            task.wait(0.8)
        end
    end)

    -- ── Gradual appearance after intro ──
    Win.Size = UDim2.new(0, 420, 0, 400)

    -- Stage 1: Window background fades in
    tw(Win,      {BackgroundTransparency = 0.05}, 0.5, Enum.EasingStyle.Quart)
    tw(BG,       {ImageTransparency = 0.3},       0.6)
    tw(OV,       {BackgroundTransparency = 0.72}, 0.6)

    task.wait(0.3)

    -- Stage 2: Title bar appears
    tw(TitleBar, {BackgroundTransparency = 0.3},              0.4)
    tw(badge,    {BackgroundTransparency = 0.3},              0.4)
    tw(bStr,     {Transparency = 0.3},                       0.4)
    tw(badgeTxt, {TextTransparency = 0},                     0.4)
    tw(titleTxt, {TextTransparency = 0},                     0.4)
    tw(dot,      {BackgroundTransparency = 0},               0.4)
    tw(minBtn,   {BackgroundTransparency = 0.3, TextTransparency = 0}, 0.4)
    tw(closeBtn, {BackgroundTransparency = 0.3, TextTransparency = 0}, 0.4)

    task.wait(0.25)

    -- Stage 3: Divider and content
    tw(divLine, {BackgroundTransparency = 0.4}, 0.4)

    print("[HM] Premium UI — Ready!")
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━
-- INTRO
-- ━━━━━━━━━━━━━━━━━━━━━━━━

if game.CoreGui:FindFirstChild("HM_Intro") then
    game.CoreGui:FindFirstChild("HM_Intro"):Destroy()
end

local Screen = Instance.new("ScreenGui", game.CoreGui)
Screen.Name           = "HM_Intro"
Screen.ResetOnSpawn   = false
Screen.IgnoreGuiInset = true
Screen.DisplayOrder   = 999999

-- Full screen background
local Bg = Instance.new("Frame", Screen)
Bg.Size             = UDim2.new(1, 0, 1, 0)
Bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Bg.BorderSizePixel  = 0
Bg.ZIndex           = 1
Bg.ClipsDescendants = true

-- Cinematic red corner accents (L-shapes, inset 4px from screen edges)
local corners = {
    {0,  4,   0,  4,   false, false},
    {1, -44,  0,  4,   true,  false},
    {0,  4,   1, -6,   false, true },
    {1, -44,  1, -6,   true,  true },
}
for _, c in ipairs(corners) do
    local xS, xO, yS, yO, fx, fy = c[1],c[2],c[3],c[4],c[5],c[6]
    local h = Instance.new("Frame", Bg)
    h.Size = UDim2.new(0, 40, 0, 2)
    h.Position = UDim2.new(xS, xO, yS, yO)
    h.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    h.BackgroundTransparency = 0.25
    h.BorderSizePixel = 0; h.ZIndex = 2
    local v = Instance.new("Frame", Bg)
    v.Size = UDim2.new(0, 2, 0, 40)
    v.Position = UDim2.new(xS, xO, yS, yO + (fy and -38 or 2))
    v.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    v.BackgroundTransparency = 0.25
    v.BorderSizePixel = 0; v.ZIndex = 2
end

-- Thin horizontal lines (letterbox effect)
local function thinLine(yScale, yOffset)
    local l = Instance.new("Frame", Bg)
    l.Size = UDim2.new(1, 0, 0, 1)
    l.Position = UDim2.new(0, 0, yScale, yOffset)
    l.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    l.BackgroundTransparency = 0.55
    l.BorderSizePixel = 0; l.ZIndex = 2
end
thinLine(0, 28); thinLine(1, -29)

-- Scattered background particles
local dotPositions = {
    {0.12, 0.18}, {0.88, 0.22}, {0.08, 0.72}, {0.92, 0.68},
    {0.25, 0.90}, {0.75, 0.88}, {0.18, 0.45}, {0.82, 0.55},
    {0.40, 0.08}, {0.60, 0.92},
}
for _, d in ipairs(dotPositions) do
    local dot = Instance.new("Frame", Bg)
    dot.Size = UDim2.new(0, 3, 0, 3)
    dot.Position = UDim2.new(d[1], -1, d[2], -1)
    dot.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
    dot.BackgroundTransparency = 0.5
    dot.BorderSizePixel = 0; dot.ZIndex = 2
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
end

-- Subtle grid lines (3 vertical + 3 horizontal)
for i = 1, 3 do
    local vl = Instance.new("Frame", Bg)
    vl.Size = UDim2.new(0, 1, 1, 0)
    vl.Position = UDim2.new(i * 0.25, 0, 0, 0)
    vl.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    vl.BackgroundTransparency = 0.7
    vl.BorderSizePixel = 0; vl.ZIndex = 1

    local hl = Instance.new("Frame", Bg)
    hl.Size = UDim2.new(1, 0, 0, 1)
    hl.Position = UDim2.new(0, 0, i * 0.25, 0)
    hl.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    hl.BackgroundTransparency = 0.7
    hl.BorderSizePixel = 0; hl.ZIndex = 1
end

-- Red glow in center
local RedGlow = Instance.new("ImageLabel", Bg)
RedGlow.Size               = UDim2.new(0, 600, 0, 600)
RedGlow.Position           = UDim2.new(0.5, -300, 0.5, -300)
RedGlow.BackgroundTransparency = 1
RedGlow.Image              = "rbxasset://textures/ui/Scroll/scroll-middle.png"
RedGlow.ImageColor3        = Color3.fromRGB(160, 0, 0)
RedGlow.ImageTransparency  = 1
RedGlow.ZIndex             = 2

-- HM text shadow
local HMShadow = Instance.new("TextLabel", Bg)
HMShadow.Size               = UDim2.new(0, 340, 0, 120)
HMShadow.Position           = UDim2.new(0.5, -168, 0.5, -56)
HMShadow.BackgroundTransparency = 1
HMShadow.Text               = "HM"
HMShadow.TextColor3         = Color3.fromRGB(120, 0, 0)
HMShadow.TextTransparency   = 1
HMShadow.TextSize           = 92
HMShadow.Font               = Enum.Font.GothamBlack
HMShadow.ZIndex             = 3

-- HM text main
local HMLabel = Instance.new("TextLabel", Bg)
HMLabel.Size               = UDim2.new(0, 340, 0, 120)
HMLabel.Position           = UDim2.new(0.5, -170, 0.5, -58)
HMLabel.BackgroundTransparency = 1
HMLabel.Text               = "HM"
HMLabel.TextColor3         = Color3.fromRGB(255, 255, 255)
HMLabel.TextTransparency   = 1
HMLabel.TextSize           = 90
HMLabel.Font               = Enum.Font.GothamBlack
HMLabel.ZIndex             = 4

-- Underline for HM text
local Line = Instance.new("Frame", Bg)
Line.Size               = UDim2.new(0, 0, 0, 2)
Line.Position           = UDim2.new(0.5, 0, 0.5, 56)
Line.AnchorPoint        = Vector2.new(0.5, 0.5)
Line.BackgroundColor3   = Color3.fromRGB(200, 0, 0)
Line.BackgroundTransparency = 1
Line.BorderSizePixel    = 0
Line.ZIndex             = 4

-- Eye shadow ring
local EyeShadow = Instance.new("Frame", Bg)
EyeShadow.Size               = UDim2.new(0, 230, 0, 230)
EyeShadow.Position           = UDim2.new(0.5, 0, 0.5, 0)
EyeShadow.AnchorPoint        = Vector2.new(0.5, 0.5)
EyeShadow.BackgroundColor3   = Color3.fromRGB(0, 0, 0)
EyeShadow.BackgroundTransparency = 1
EyeShadow.BorderSizePixel    = 0
EyeShadow.ZIndex             = 3
Instance.new("UICorner", EyeShadow).CornerRadius = UDim.new(1, 0)
local shadowStroke = Instance.new("UIStroke", EyeShadow)
shadowStroke.Color       = Color3.fromRGB(50, 50, 50)
shadowStroke.Thickness   = 14
shadowStroke.Transparency = 1

-- Eye image (hidden until eyelids open)
local Eye = Instance.new("ImageLabel", Bg)
Eye.Size               = UDim2.new(0, 210, 0, 210)
Eye.Position           = UDim2.new(0.5, 0, 0.5, 0)
Eye.AnchorPoint        = Vector2.new(0.5, 0.5)
Eye.BackgroundTransparency = 1
Eye.Image              = "rbxthumb://type=Asset&id=7292869465&w=420&h=420"
Eye.ImageTransparency  = 1
Eye.ScaleType          = Enum.ScaleType.Fit
Eye.ZIndex             = 4

-- Top eyelid (starts off-screen above)
local TopLid = Instance.new("Frame", Bg)
TopLid.Size               = UDim2.new(1, 0, 0, 200)
TopLid.Position           = UDim2.new(0.5, 0, 0, -210)
TopLid.AnchorPoint        = Vector2.new(0.5, 1.0)
TopLid.BackgroundColor3   = Color3.fromRGB(0, 0, 0)
TopLid.BackgroundTransparency = 0
TopLid.BorderSizePixel    = 0
TopLid.ZIndex             = 6
Instance.new("UICorner", TopLid).CornerRadius = UDim.new(0, 22)

-- Bottom eyelid (starts off-screen below)
local BotLid = Instance.new("Frame", Bg)
BotLid.Size               = UDim2.new(1, 0, 0, 200)
BotLid.Position           = UDim2.new(0.5, 0, 1, 210)
BotLid.AnchorPoint        = Vector2.new(0.5, 0.0)
BotLid.BackgroundColor3   = Color3.fromRGB(0, 0, 0)
BotLid.BackgroundTransparency = 0
BotLid.BorderSizePixel    = 0
BotLid.ZIndex             = 6
Instance.new("UICorner", BotLid).CornerRadius = UDim.new(0, 22)

-- Dev label above eye
local DevLabel = Instance.new("TextLabel", Bg)
DevLabel.Size               = UDim2.new(0, 240, 0, 26)
DevLabel.Position           = UDim2.new(0.5, 0, 0.5, -128)
DevLabel.AnchorPoint        = Vector2.new(0.5, 0.5)
DevLabel.BackgroundTransparency = 1
DevLabel.Text               = "D E V   |   H M"
DevLabel.TextColor3         = Color3.fromRGB(210, 210, 210)
DevLabel.TextTransparency   = 1
DevLabel.TextSize           = 13
DevLabel.Font               = Enum.Font.GothamBold
DevLabel.ZIndex             = 8

-- Thin line below dev label
local DevLine = Instance.new("Frame", Bg)
DevLine.Size               = UDim2.new(0, 0, 0, 1)
DevLine.Position           = UDim2.new(0.5, 0, 0.5, -115)
DevLine.AnchorPoint        = Vector2.new(0.5, 0.5)
DevLine.BackgroundColor3   = Color3.fromRGB(180, 180, 180)
DevLine.BackgroundTransparency = 0.3
DevLine.BorderSizePixel    = 0
DevLine.ZIndex             = 8
Instance.new("UICorner", DevLine).CornerRadius = UDim.new(1, 0)

-- Sounds
local function newSound(id)
    local s = Instance.new("Sound", Screen)
    s.SoundId = "rbxassetid://" .. id
    s.Volume  = 1
    return s
end

local S0 = newSound("100857951036934")
local S1 = newSound("108120517724039")
local S2 = newSound("134103109747331")
local S3 = newSound("102742504905872")

-- Skip button
local Skip = Instance.new("TextButton", Screen)
Skip.Size               = UDim2.new(0, 85, 0, 28)
Skip.Position           = UDim2.new(1, -100, 1, -42)
Skip.BackgroundColor3   = Color3.fromRGB(10, 10, 10)
Skip.BackgroundTransparency = 0.4
Skip.Text               = "SKIP  >"
Skip.TextColor3         = Color3.fromRGB(200, 200, 200)
Skip.TextTransparency   = 1
Skip.TextSize           = 12
Skip.Font               = Enum.Font.GothamBold
Skip.BorderSizePixel    = 0
Skip.ZIndex             = 20
Instance.new("UICorner", Skip).CornerRadius = UDim.new(0, 6)
local skipStr = Instance.new("UIStroke", Skip)
skipStr.Color = Color3.fromRGB(180, 0, 0); skipStr.Thickness = 1; skipStr.Transparency = 1

-- ━━━━━━━━━━━━━━━━━━━━━━━━
-- End function
-- ━━━━━━━━━━━━━━━━━━━━━━━━
local finished = false
local FADE     = 0.55

local function endIntro()
    if finished then return end
    finished = true

    S0:Stop(); S1:Stop(); S2:Stop(); S3:Stop()

    -- All elements fade out simultaneously at the same duration
    for _, v in ipairs(Screen:GetDescendants()) do
        pcall(function()
            if v:IsA("TextButton") or v:IsA("TextLabel") then
                tw(v, {TextTransparency = 1, BackgroundTransparency = 1}, FADE, Enum.EasingStyle.Linear)
            elseif v:IsA("ImageLabel") then
                tw(v, {ImageTransparency = 1, BackgroundTransparency = 1}, FADE, Enum.EasingStyle.Linear)
            elseif v:IsA("Frame") then
                tw(v, {BackgroundTransparency = 1}, FADE, Enum.EasingStyle.Linear)
            elseif v:IsA("UIStroke") then
                tw(v, {Transparency = 1}, FADE, Enum.EasingStyle.Linear)
            end
        end)
    end

    task.wait(FADE + 0.05)
    Screen:Destroy()

    -- Launch HM UI after intro
    launchUI()
end

Skip.MouseButton1Click:Connect(endIntro)

-- ━━━━━━━━━━━━━━━━━━━━━━━━
-- Intro sequence
-- ━━━━━━━━━━━━━━━━━━━━━━━━
task.spawn(function()

    S0:Play()

    task.wait(0.4)
    tw(Skip,    {TextTransparency = 0.3}, 1.0)
    tw(skipStr, {Transparency = 0.3},     1.0)

    task.wait(0.1)
    tw(HMLabel,  {TextTransparency = 0},   1.4, Enum.EasingStyle.Quart)
    tw(HMShadow, {TextTransparency = 0.3}, 1.4, Enum.EasingStyle.Quart)
    tw(Line, {
        Size = UDim2.new(0, 110, 0, 2),
        BackgroundTransparency = 0.2
    }, 0.9, Enum.EasingStyle.Quart)
    tw(RedGlow, {ImageTransparency = 0.92}, 2.0)

    task.wait(2.8)
    if finished then return end
    tw(HMLabel,  {TextTransparency = 1}, 0.9, Enum.EasingStyle.Quart)
    tw(HMShadow, {TextTransparency = 1}, 0.9)
    tw(Line, {
        Size = UDim2.new(0, 0, 0, 2),
        BackgroundTransparency = 1
    }, 0.6, Enum.EasingStyle.Quart)

    task.wait(0.7)
    if finished then return end

    TopLid.Position = UDim2.new(0.5, 0, 0.5, 0)
    BotLid.Position = UDim2.new(0.5, 0, 0.5, 0)
    Eye.ImageTransparency = 0

    if finished then return end

    S1:Play()

    -- Eye rotation loop
    task.spawn(function()
        local rot = 0
        while not finished do
            rot = rot + 360
            tw(Eye, {Rotation = rot}, 3.5, Enum.EasingStyle.Linear)
            task.wait(3.5)
        end
    end)

    -- Open eyelids
    tw(TopLid, {Position = UDim2.new(0.5, 0, 0.5, -112)},
        1.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    tw(BotLid, {Position = UDim2.new(0.5, 0, 0.5,  112)},
        1.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

    tw(EyeShadow,    {BackgroundTransparency = 0.72}, 2.0, Enum.EasingStyle.Quart)
    tw(shadowStroke, {Transparency = 0.50},           2.0, Enum.EasingStyle.Quart)

    task.wait(1.4)
    if finished then return end
    tw(DevLabel, {TextTransparency = 0.08}, 1.0, Enum.EasingStyle.Quart)
    tw(DevLine,  {Size = UDim2.new(0, 130, 0, 1)}, 0.9, Enum.EasingStyle.Quart)
    tw(RedGlow,  {ImageTransparency = 0.88}, 1.8)

    task.wait(0.4)
    if finished then return end

    S2:Play()
    task.wait(0.15)
    if finished then return end
    S3:Play()

    task.wait(3.5)
    if finished then return end
    endIntro()
end)

print("[HM] Intro — Started")
