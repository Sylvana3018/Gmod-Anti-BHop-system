util.AddNetworkString("BunnyHopWarning")

-- check jumps per sec
local MAX_JUMP_INTERVAL = 0.3

-- check speed while ground
local MAX_SPEED = 700

local jumpTimestamps = {}
local previousMovementState = {}

hook.Add("Move", "BunnyHop", function(ply, mv)
    if ply:IsOnGround() and mv:KeyDown(IN_JUMP) and not previousMovementState[ply] then
        local currentTime = CurTime()
        local lastJumpTime = jumpTimestamps[ply]

        if lastJumpTime and (currentTime - lastJumpTime) < MAX_JUMP_INTERVAL then
            net.Start("BunnyHopWarning")
            net.WriteString(ply:Nick())
            net.WriteString("Jumping too often")
            net.Broadcast()
        end

        local currentSpeed = mv:GetVelocity():Length()
        if currentSpeed > MAX_SPEED then
            net.Start("BunnyHopWarning")
            net.WriteString(ply:Nick())
            net.WriteString("too fast speed")
            net.Broadcast()
        end

        jumpTimestamps[ply] = currentTime
    end

    previousMovementState[ply] = mv:KeyDown(IN_JUMP)
end)
