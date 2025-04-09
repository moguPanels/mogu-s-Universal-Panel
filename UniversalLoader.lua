loadstring(game:HttpGet("https://raw.githubusercontent.com/moguPanels/mogu-s-Universal-Panel/main/UniversalLoader.lua"))()

-- UI Libraries
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()

-- Animate Logo
local function AnimateLogo()
    local logo = Instance.new("ImageLabel")
    logo.Image = "rbxassetid://YOUR_LOGO_IMAGE_ID" -- Replace with uploaded train panel logo asset
    logo.Size = UDim2.new(0, 120, 0, 120)
    logo.Position = UDim2.new(0.5, -60, 0.1, -60)
    logo.AnchorPoint = Vector2.new(0.5, 0.5)
    logo.BackgroundTransparency = 1
    logo.Parent = Rayfield.Main
    logo.Rotation = 0

    task.spawn(function()
        while wait() do
            logo.Rotation += 1
            logo.ImageColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        end
    end)
end

-- Jumbled Text Animation
local function AnimateTitle()
    local title = Rayfield.Title
    local realText = "mogu's Panel"
    local chars = {"@", "#", "$", "%", "&", "*", "!", "?", "Z", "K", "9"}

    task.spawn(function()
        for i = 1, #realText do
            for _ = 1, 5 do
                title.Text = realText:sub(1, i - 1) .. chars[math.random(1, #chars)] .. realText:sub(i + 1)
                wait(0.05)
            end
            title.Text = realText:sub(1, i)
        end
    end)
end

-- Stylized Key UI
Rayfield:CreateKeySystem({
    Title = "Access Database",
    Subtitle = "Secure Chrome Panel Login",
    Note = "Enter username and password to proceed.",
    SaveKey = true,
    GrabKeyFromSite = false,
    KeyInput = true,
    Key = "mogupanel", -- can be anything; not validated
    KeyUI = {
        PlaceholderText = "Username",
        PasswordPlaceholder = "Password",
        AcceptsRandomUsername = true
    },
    OnSuccess = function()
        -- Load Universal Panel
    end
})

-- Main Panel w/ URL bar
local Window = Rayfield:CreateWindow({
    Name = "https://mogu.universal/panel",
    LoadingTitle = "mogu's Panel",
    LoadingSubtitle = "Initializing Chrome-style UI...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MoguUniversalPanel",
        FileName = "ControlPanelConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },
    KeySystem = false
})

-- Undo/Redo Tab Logic (pseudo, to be implemented in next update)
-- Store opened/closed tabs in stack tables, simulate browser-like navigation

-- Example Jailbreak Button
local GamesTab = Window:CreateTab("Universal", 4483362458)
GamesTab:CreateButton({
    Name = "Jailbreak",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/moguPanels/mogu-s-Universal-Panel/Jailbreak.lua"))()
    end
})
