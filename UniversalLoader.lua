
-- Mogu's Universal Panel: Chrome-Styled UI Loader with Animation, Glow, and Database Key UI

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Browser-like Window with Tabs and URL
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "https://mogu.panel/loader",
    LoadingTitle = "Loading mogu's Panel...",
    LoadingSubtitle = "Initializing Chrome Interface",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MoguPanel",
        FileName = "LoaderSettings"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = true,
    KeySettings = {
        Title = "Secure Access Panel",
        Subtitle = "Database Authentication Required",
        Note = "Enter any username and a password.",
        FileName = "MoguKeySystem",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = "password" -- Accepts any user, but key must be 'password'
    }
})

-- Animate the Control Panel Logo and Title
do
    local function jumbledText(target, label)
        local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*"
        local iterations = 15
        local delay = 0.05

        for i = 1, iterations do
            local text = ""
            for j = 1, #target do
                if j <= i then
                    text = text .. target:sub(j, j)
                else
                    text = text .. charset:sub(math.random(1, #charset), math.random(1, #charset))
                end
            end
            label:Set(text)
            wait(delay)
        end
        label:Set(target)
    end

    local TitleTab = Window:CreateTab("mogu's Panel", nil)
    jumbledText("mogu's Panel", TitleTab)
end

-- Dynamic Tab URL System
local function updateURL(gameName)
    Window:SetName("https://" .. gameName .. "/moguu_ControlPanel")
end

-- Undo/Redo Mechanism (basic)
local undoStack, redoStack = {}, {}
local function addTab(tab)
    table.insert(undoStack, tab)
    redoStack = {}
end

local function undoTab()
    if #undoStack > 0 then
        local last = table.remove(undoStack)
        table.insert(redoStack, last)
        last:Destroy()
    end
end

local function redoTab()
    if #redoStack > 0 then
        local restore = table.remove(redoStack)
        table.insert(undoStack, restore)
    end
end

-- Tab Controls UI
local ControlTab = Window:CreateTab("Tab Manager", nil)
ControlTab:CreateButton({
    Name = "Undo Last Tab",
    Callback = undoTab
})
ControlTab:CreateButton({
    Name = "Redo Last Tab",
    Callback = redoTab
})

-- Load Jailbreak Panel
if game.PlaceId == 606849621 then
    updateURL("jailbreak")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/moguPanels/mogu-s-Universal-Panel/refs/heads/main/Jailbreak.lua"))()
else
    local tab = Window:CreateTab("Game Not Supported", nil)
    tab:CreateParagraph({Title = "Oops!", Content = "This game is not yet supported."})
end

