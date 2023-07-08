local bHopEnabled = false

-- Testing anti-bhop system
-- You can delete this commands
concommand.Add("bhop_enable", function()
    bHopEnabled = true
    print("BunnyHop on")
end)

concommand.Add("bhop_disable", function()
    bHopEnabled = false
    print("BunnyHop off")
end)

hook.Add("CreateMove", "BunnyHop", function(cmd)
    if bHopEnabled and LocalPlayer():IsOnGround() then
        cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_JUMP))
    end
end)

net.Receive("BunnyHopWarning", function()
    local playerName = net.ReadString()
    local violationType = net.ReadString()

    chat.AddText(Color(255, 0, 0), "[Nyx]: Player ", playerName, " is suspected of using BunnyHop (" .. violationType .. ")
end)
