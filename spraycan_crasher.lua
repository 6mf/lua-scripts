
--[[
                    _            _      _  _    ___   ___   ___ ____  
                   | |          | |   _| || |_ / _ \ / _ \ / _ \___ \ 
__      ____ _ _ __| | ___   ___| | _|_  __  _| | | | | | | | | |__) |
\ \ /\ / / _` | '__| |/ _ \ / __| |/ /_| || |_| | | | | | | | | |__ < 
 \ V  V / (_| | |  | | (_) | (__|   <|_  __  _| |_| | |_| | |_| |__) |
  \_/\_/ \__,_|_|  |_|\___/ \___|_|\_\ |_||_|  \___/ \___/ \___/____/ 
    DONT TOUCH ANYTHING BELOW UNLESS YOU KNOW WHAT YOU'RE DOING.

]]

itemCount = 0
getgenv().groupid = nil
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
local getGroups = game:GetService("GroupService"):GetGroupsAsync(game.Players.LocalPlayer.UserId)
if unpack(getGroups) == nil then
    warn('no groups'); return
else
	for _, groupInfo in pairs(getGroups) do
	    if _ == 1 then
            getgenv().groupid = groupInfo.Id
        end
	end
end
function equipall()
    for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA"Tool" and v.Name == "[SprayCan]" then
            v.Parent = game.Players.LocalPlayer.Character
        end
    end
end

repeat
    task.wait()
    game:GetService("ReplicatedStorage").MainEvent:FireServer("JoinCrew", getgenv().groupid)        --// join crew
    repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChild'[SprayCan]'; task.wait()   --// wait for tool to be added
    itemCount = itemCount + 1; print(itemCount)                                                     --// add count
    equipall()
until itemCount >= 900

--// the reset (crash)
for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v:IsA("BasePart") then
        v:Destroy()
    end
end
