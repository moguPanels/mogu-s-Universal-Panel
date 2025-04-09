
-- Mogu's Universal Panel - Main Loader Script
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Mogu's Universal Panel",
   LoadingTitle = "Mogu's Loader",
   LoadingSubtitle = "Password Required",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "MoguControl",
      FileName = "UniversalSettings"
   },
   Discord = {
      Enabled = true,
      Invite = "Hn7tvHzb44",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Mogu's Key System",
      Subtitle = "Password",
      Note = "Join the Discord server to get the key. MCPMPU is the public key.",
      FileName = "MoguKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Administrator.ACC", "MCPMPU"}
   }
})

local UniversalTab = Window:CreateTab("Mogu's Universal Panel", nil)

local Games = {
   ["J - Jailbreak"] = "https://raw.githubusercontent.com/moguPanels/mogu-s-Universal-Panel/main/Jailbreak.lua" -- Replace this with actual Pastebin link later
}

for gameName, scriptURL in pairs(Games) do
   UniversalTab:CreateButton({
      Name = gameName,
      Callback = function()
         loadstring(game:HttpGet(scriptURL))()
      end
   })
end
