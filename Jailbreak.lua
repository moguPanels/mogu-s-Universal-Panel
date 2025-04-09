-- Jailbreak Script Panel for Mogu's Control Panel

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Utility Functions
local function JoinTeam(teamName)
    for _, team in pairs(Teams:GetChildren()) do
        if team.Name == teamName then
            LocalPlayer.Team = team
        end
    end
end

local function TeleportTo(position)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- WalkSpeed & JumpPower Initialization
getgenv().WalkSpeed = 16
getgenv().JumpPower = 50

-- Fly Logic
getgenv().Flying = false
local function Fly()
    if not LocalPlayer.Character then return end

    local Char = LocalPlayer.Character
    local HRP = Char:WaitForChild("HumanoidRootPart")
    local BV = Instance.new("BodyVelocity")
    BV.Velocity = Vector3.new(0, 0, 0)
    BV.MaxForce = Vector3.new(100000, 100000, 100000)
    BV.Parent = HRP
    getgenv().Flying = true

    UserInputService.InputBegan:Connect(function(input)
        if not getgenv().Flying then return end
        if input.KeyCode == Enum.KeyCode.Space then
            BV.Velocity = Vector3.new(0, 100, 0)
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            BV.Velocity = Vector3.new(0, -100, 0)
        end
    end)

    UserInputService.InputEnded:Connect(function()
        if BV then
            BV.Velocity = Vector3.new(0, 0, 0)
        end
    end)
end

-- NoClip Function
getgenv().NoClip = false
local function EnableNoClip()
    getgenv().NoClip = true
    RunService.Stepped:Connect(function()
        if getgenv().NoClip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- Auto Robbery
local function AutoRob()
    JoinTeam("Criminal")
    task.wait(1)
    TeleportTo(Vector3.new(1360, 0, -1600)) -- Jewelry Store
end

-- Auto Arrest
local function AutoArrest()
    JoinTeam("Police")
    task.wait(1)
    for _, crim in pairs(Players:GetPlayers()) do
        if crim.Team and crim.Team.Name == "Criminal" and crim.Character then
            TeleportTo(crim.Character.HumanoidRootPart.Position)
            break
        end
    end
end

-- Equip Weapon by Name
local function EquipWeapon(weaponName)
    local gunShop = workspace:FindFirstChild("GunShop") or workspace
    for _, item in pairs(gunShop:GetDescendants()) do
        if item:IsA("Tool") and item.Name == weaponName then
            item.Parent = LocalPlayer.Backpack
        end
    end
end

-- Weapon List (Add more as needed)
local weapons = {
    "AK-47",
    "Pistol",
    "Shotgun",
    "Revolver",
    "Sniper",
    "Uzi",
    "Flintlock",
    "Plasma Pistol",
    "Rifle",
    "Forcefield Launcher"
}

-- Teleport Locations
local teleportLocations = {
    ["Jewelry Store"] = Vector3.new(1360, 0, -1600),
    ["Bank"] = Vector3.new(250, 0, -1100),
    ["Museum"] = Vector3.new(1160, 100, 1200),
    ["Criminal Base"] = Vector3.new(2150, 50, 500),
    ["Police Station"] = Vector3.new(-1300, 0, 800),
}

-- Exported API for Rayfield buttons
return {
    WalkSpeed = function(value) LocalPlayer.Character.Humanoid.WalkSpeed = value end,
    JumpPower = function(value) LocalPlayer.Character.Humanoid.JumpPower = value end,
    Fly = Fly,
    NoClip = EnableNoClip,
    AutoRob = AutoRob,
    AutoArrest = AutoArrest,
    Teleport = function(name) if teleportLocations[name] then TeleportTo(teleportLocations[name]) end end,
    EquipWeapon = EquipWeapon,
    GetWeapons = function() return weapons end,
    GetTeleports = function() return teleportLocations end
}
