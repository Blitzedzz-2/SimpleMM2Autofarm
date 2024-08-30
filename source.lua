local AutoFarmModule = {
    options = {
        Fling = true,
        UnlockFPS = true,
        TweenTime = 4.5,
    }
}

local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local isFarming = false
local hasSentMessages = false
function AutoFarmModule.startAutoFarm()
    if isFarming then return end
    isFarming = true

    local player = Players.LocalPlayer

    local function waitForRespawn()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        humanoid.Died:Connect(function()
            isFarming = false
            hasSentMessages = false
            player.CharacterAdded:Wait()
            AutoFarmModule.startAutoFarm()
        end)

        return character
    end

    while isFarming do
        local character = waitForRespawn()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local normal = game.Workspace:WaitForChild("Normal")
        local container = normal:WaitForChild("CoinContainer")
        local coins = container:GetChildren()

        local visibleCoins = {}

        for _, coin in ipairs(coins) do
            if coin.Transparency > 0 then
                table.insert(visibleCoins, coin)
            end
        end

        if #visibleCoins == 0 then
            print("No visible coins found")
            wait(1)
            continue
        end

        table.sort(visibleCoins, function(a, b)
            return (humanoidRootPart.Position - a.Position).Magnitude < (humanoidRootPart.Position - b.Position).Magnitude
        end)

        local tweenInfo = TweenInfo.new(
            AutoFarmModule.options.TweenTime,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        )

        for _, coin in ipairs(visibleCoins) do
            if not container.Parent or not isFarming then
                print("Stopping loop due to missing container or farming state")
                break
            end

            local goal = { CFrame = coin.CFrame }
            local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
            tween:Play()
            tween.Completed:Wait()

            wait(0.3)
        end

        if AutoFarmModule.options.Fling then
            local speaker = game.Players.LocalPlayer
            local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")

            local function getRoot(char)
                return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
            end

            if humanoid then
                humanoid.Died:Connect(function()
                    walkflinging = false
                    if Noclipping then
                        Noclipping:Disconnect()
                    end
                    Clip = true
                end)
            end

            Clip = false
            wait(0.1)

            local function NoclipLoop()
                if Clip == false and speaker.Character ~= nil then
                    for _, child in pairs(speaker.Character:GetDescendants()) do
                        if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                            child.CanCollide = false
                        end
                    end
                end
            end
            Noclipping = RunService.Stepped:Connect(NoclipLoop)
            walkflinging = true

            repeat
                RunService.Heartbeat:Wait()
                local character = speaker.Character
                local root = getRoot(character)
                local vel, movel = nil, 0.1

                while not (character and character.Parent and root and root.Parent) do
                    RunService.Heartbeat:Wait()
                    character = speaker.Character
                    root = getRoot(character)
                end

                vel = root.Velocity
                root.Velocity = vel * 1000000 + Vector3.new(0, 1000000, 0)
                RunService.RenderStepped:Wait()

                if character and character.Parent and root and root.Parent then
                    root.Velocity = vel
                end

                RunService.Stepped:Wait()
                if character and character.Parent and root and root.Parent then
                    root.Velocity = vel + Vector3.new(0, movel, 0)
                    movel = movel * -1
                end
            until walkflinging == false
        end
    end
end

function AutoFarmModule.Init()
	loadstring("\9\32\32\32\32\112\114\105\110\116\40\34\77\97\100\101\32\98\121\32\98\108\105\116\122\101\100\122\122\34\41\10\9\10")()
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
	
    end)
    if AutoFarmModule.options.UnlockFPS then
repeat task.wait() until game:IsLoaded();

getgenv().boostFPS = true

local vim = game:GetService("VirtualInputManager")
setfpscap(5000)

game.DescendantAdded:Connect(function(d)
  if d.Name == "MainView" and d.Parent.Name == "DevConsoleUI" and boostFPS then
      task.wait()
      local screen = d.Parent.Parent.Parent
      screen.Enabled = false;
  end
end)

vim:SendKeyEvent(true, "F9", 0, game)    
wait()
vim:SendKeyEvent(false, "F9", 0, game)  
loadstring("\9\32\32\32\32\112\114\105\110\116\40\34\77\97\100\101\32\98\121\32\98\108\105\116\122\101\100\122\122\34\41\10\9\10")()
while true do
  task.wait()
  if not boostFPS then
      continue;
  end
 

  warn("")
 
  if not game:GetService("CoreGui"):FindFirstChild("DevConsoleUI", true):FindFirstChild("MainView") then
       vim:SendKeyEvent(true, "F9", 0, game)    
        wait()
        vim:SendKeyEvent(false, "F9", 0, game)  
        continue
    end
end
    end
    if game.PlaceId == 142823291 then
        AutoFarmModule.startAutoFarm()
	
    else
        print("Wrong game")
    end
end
loadstring("\9\32\32\32\32\112\114\105\110\116\40\34\77\97\100\101\32\98\121\32\98\108\105\116\122\101\100\122\122\34\41\10\9\10")()
return AutoFarmModule
