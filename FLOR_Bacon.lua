local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local VirtualUser = game:GetService("VirtualUser")

-- Auto Tech Meow Loop
_G.AutoTechMeow = true

task.spawn(function()
    while _G.AutoTechMeow and task.wait(0.1) do
        pcall(function()
            local Root = Character:FindFirstChild("HumanoidRootPart")
            local Hum = Character:FindFirstChildOfClass("Humanoid")
            
            if Hum and Hum.Health > 0 and Root then
                -- Tìm kẻ địch gần nhất để thực hiện combo/tech
                local Target = nil
                local MaxDist = 50
                
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local pHum = p.Character:FindFirstChildOfClass("Humanoid")
                        if pHum and pHum.Health > 0 then
                            local Dist = (p.Character.HumanoidRootPart.Position - Root.Position).Magnitude
                            if Dist < MaxDist then
                                MaxDist = Dist
                                Target = p.Character
                            end
                        end
                    end
                end
                
                -- Thực hiện đòn đánh tự động khi có mục tiêu
                if Target then
                    Root.CFrame = CFrame.new(Root.Position, Vector3.new(Target.HumanoidRootPart.Position.X, Root.Position.Y, Target.HumanoidRootPart.Position.Z))
                    VirtualUser:CaptureController()
                    VirtualUser:Button1Down(Vector2.new(0,0))
                end
            end
        end)
    end
end)
