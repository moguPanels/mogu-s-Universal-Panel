
local games = {
    ["Jailbreak"] = "https://raw.githubusercontent.com/moguPanels/mogu-s-Universal-Panel/main/Jailbreak.lua",
    -- Add more games here
}

-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Create Chrome-style window
local Window = Rayfield:CreateWindow({
    Name = "Mogu's Universal Panel",
    LoadingTitle = "Loading Mogu's Panel...",
    ConfigurationSaving = {
        Enabled = false
    }
})

-- Create Game Selection Tab
local GameTab = Window:CreateTab("Select Game", 4483362458)

for gameName, scriptURL in pairs(games) do
    GameTab:CreateButton({
        Name = gameName,
        Callback = function()
            loadstring(game:HttpGet(scriptURL))()
        end,
    })
end

-- Create Database-style Key System
local KeyInput = ""
local PasswordInput = ""

Rayfield:Notify({
    Title = "Authentication",
    Content = "Please enter username and password to continue.",
    Duration = 6.5,
    Image = 4483362458,
    Actions = {
        Ignore = {
            Name = "Enter",
            Callback = function()
                local InputWindow = Rayfield:CreateWindow({
                    Name = "Database Login",
                    ConfigurationSaving = {
                        Enabled = false
                    }
                })

                local KeyTab = InputWindow:CreateTab("Login", 4483362458)
                KeyTab:CreateInput({
                    Name = "Username",
                    PlaceholderText = "Enter any name",
                    RemoveTextAfterFocusLost = false,
                    Callback = function(text)
                        KeyInput = text
                    end,
                })

                KeyTab:CreateInput({
                    Name = "Password",
                    PlaceholderText = "Enter password",
                    RemoveTextAfterFocusLost = false,
                    Callback = function(text)
                        PasswordInput = text
                    end,
                })

                KeyTab:CreateButton({
                    Name = "Login",
                    Callback = function()
                        -- Accept any input
                        Rayfield:Notify({
                            Title = "Login Successful",
                            Content = "Welcome, " .. KeyInput,
                            Duration = 4,
                            Image = 4483362458
                        })
                    end
                })
            end
        }
    }
})
