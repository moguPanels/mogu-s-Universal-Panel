-- Mogu's Panel: Jailbreak Script

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
   Name = "mogu's Panel",
   LoadingTitle = "mogu's Panel",
   LoadingSubtitle = "by Administrator.ACC",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "mogusPanel",
      FileName = "mogu_UI"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false
})

local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 200},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})

PlayerTab:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().NoClip = Value
        game:GetService("RunService").Stepped:Connect(function()
            if getgenv().NoClip then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end,
})

PlayerTab:CreateButton({
    Name = "Fly",
    Callback = function()
        local UIS = game:GetService("UserInputService")
        local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        local BV = Instance.new("BodyVelocity", HRP)
        BV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        BV.Velocity = Vector3.new()
        UIS.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Space then
                BV.Velocity = Vector3.new(0, 100, 0)
            elseif input.KeyCode == Enum.KeyCode.LeftShift then
                BV.Velocity = Vector3.new(0, -100, 0)
            end
        end)
        UIS.InputEnded:Connect(function()
            BV.Velocity = Vector3.new(0, 0, 0)
        end)
    end,
})

local AutoTab = Window:CreateTab("Auto", 4483362458)

AutoTab:CreateButton({
    Name = "Auto Robbery",
    Callback = function()
        for _, team in pairs(game:GetService("Teams"):GetChildren()) do
            if team.Name == "Criminal" then
                game.Players.LocalPlayer.Team = team
            end
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1360, 0, -1600) -- Teleport to jewelry
    end,
})

AutoTab:CreateButton({
    Name = "Auto Arrest",
    Callback = function()
        for _, team in pairs(game:GetService("Teams"):GetChildren()) do
            if team.Name == "Police" then
                game.Players.LocalPlayer.Team = team
            end
        end
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr.Team.Name == "Criminal" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
            end
        end
    end,
})

local WeaponTab = Window:CreateTab("Weapons", 4483362458)

WeaponTab:CreateDropdown({
    Name = "Equip Weapon",
    Options = {"AK-47", "Pistol", "Shotgun", "Uzi", "Sniper"},
    CurrentOption = "AK-47",
    Callback = function(Value)
        local gunShop = workspace:FindFirstChild("GunShop") or workspace
        for _, item in pairs(gunShop:GetDescendants()) do
            if item:IsA("Tool") and item.Name == Value then
                item.Parent = game.Players.LocalPlayer.Backpack
            end
        end
    end,
})
