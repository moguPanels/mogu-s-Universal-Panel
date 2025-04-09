
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/moguPanels/mogu-s-Universal-Panel/main/Rayfield.lua"))()

local MainUI = Rayfield:CreateWindow({
    Name = "Mogu's Universal Panel",
    LoadingTitle = "Mogu Hub",
    LoadingSubtitle = "Universal Loader",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MoguHub",
        FileName = "UniversalConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "Hn7tvHzb44",
        RememberJoins = true
    },
    KeySystem = false
})

local authenticated = false
local username = "Guest Account"
local password = "MCPMPU"

local KeyTab = MainUI:CreateTab("Authentication", 4483362458)

KeyTab:CreateParagraph({
    Title = "Login Required",
    Content = "Join the Discord server to get the password (key).\nEnter any username."
})

KeyTab:CreateInput({
    Name = "Username",
    PlaceholderText = "Enter any username",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        username = (text ~= "" and text) or "Guest Account"
    end,
})

KeyTab:CreateInput({
    Name = "Password (Key)",
    PlaceholderText = "Found in Discord server",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        password = (text ~= "" and text) or "MCPMPU"
    end,
})

KeyTab:CreateButton({
    Name = "Login",
    Callback = function()
        if password == "MCPMPU" then
            Rayfield:Notify({
                Title = "Success",
                Content = "Welcome, " .. (username or "Guest Account") .. "!",
                Duration = 4
            })
            authenticated = true
            GameTab:Show()
        else
            Rayfield:Notify({
                Title = "Invalid Key",
                Content = "Get the correct key from the Discord server.",
                Duration = 5
            })
        end
    end,
})

local GameTab = MainUI:CreateTab("Select Game", 4483362458)
GameTab:Hide()

GameTab:CreateParagraph({
    Title = "Game Selector",
    Content = "Pick a game to load its control panel."
})

GameTab:CreateButton({
    Name = "Jailbreak",
    Callback = function()
        Rayfield:Notify({
            Title = "Loading",
            Content = "Launching Jailbreak panel...",
            Duration = 3
        })
        loadstring(game:HttpGet("https://raw.githubusercontent.com/moguPanels/mogu-s-Universal-Panel/main/Jailbreak.lua"))()
    end,
})
