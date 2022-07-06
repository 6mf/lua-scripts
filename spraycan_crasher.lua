itemCount = 0
getgenv().groupid = nil

--// get first group to auto set
local getGroups = game:GetService("GroupService"):GetGroupsAsync(game.Players.LocalPlayer.UserId)
if unpack(getGroups) == nil then
    warn('no groups')
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
until itemCount >= 1000

--// the reset (crash)
for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v:IsA("BasePart") then
        v:Destroy()
    end
end
