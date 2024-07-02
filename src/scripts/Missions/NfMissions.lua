-- edge traversal
function Nf.findEdges(roomlist)
    local edges = {}
    local x, y, z = getRoomCoordinates(map.currentRoom)
    for k, v in spairs(roomlist) do
        if #table.keys(getRoomExits(k)) == 1 then
            _, _, zz = getRoomCoordinates(k)
            if zz == z then
                edges[k] = v
            end
        end
    end
    return edges
end

local function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

function Nf.clearFloor()
    -- get all rooms in zone
    local roomlist = Nf.roomList(getRoomAreaName(getRoomArea(map.currentRoom)))
    -- get all edges on my level
    local edges = table.keys(Nf.findEdges(roomlist))
    -- build a random edge walk list
    shuffle(edges)
    -- set the global
    Nf.rooms = edges
    if not Nf.walking and Nf.rooms[1] ~= nil then
        gotoRoom(Nf.rooms[1])
    end
    -- when edge list is empty, decalare floor cleared
end

Nf.missions = Nf.missions or {}
Nf.missions.montaire = {
    { step = send,             args = { directions["montaire"] },             advance = true },
    { step = send,             args = { "look" },                             advance = true },
    { step = toggleHunting,    args = { true },                               advance = true },
    { step = gotoRoom,         args = { "787" } },
    { step = gotoRoom,         args = { "371" } },
    { step = gotoRoom,         args = { "368" } },
    { step = gotoRoom,         args = { "364" } },
    { step = gotoRoom,         args = { "363" } },
    { step = gotoRoom,         args = { "359" } },
    { step = gotoRoom,         args = { "356" } },
    { step = gotoRoom,         args = { "350" } },
    { step = gotoRoom,         args = { "352" } },
    { step = gotoRoom,         args = { "802" } },
    { step = gotoRoom,         args = { "795" } },
    { step = gotoRoom,         args = { "912" } },
    { step = gotoRoom,         args = { "792" } },
    { step = gotoRoom,         args = { "913" } },
    { step = toggleHunting,    args = { false },                              advance = true },
    { step = raiseGlobalEvent, args = { "escape" },                           advance = true },
    { step = raiseEvent,       args = { "sysManualLocationSetEvent", "281" }, advance = true }
}
Nf.missions.ocp = {
    { step = send,             args = { directions["ocp"] },                  advance = true },
    { step = send,             args = { "look" },                             advance = true },
    { step = toggleHunting,    args = { true },                               advance = true },
    { step = gotoRoom,         args = { "218" },                              name = "goto 218" },
    { step = gotoRoom,         args = { "214" },                              name = "goto 191" },
    { step = gotoRoom,         args = { "208" },                              name = "goto 208" },
    { step = gotoRoom,         args = { "204" },                              name = "goto 204" },
    { step = gotoRoom,         args = { "235" },                              name = "goto 235" },
    { step = gotoRoom,         args = { "231" },                              name = "goto 231" },
    { step = gotoRoom,         args = { "247" },                              name = "goto 247" },
    { step = gotoRoom,         args = { "252" },                              name = "goto 252" },
    { step = gotoRoom,         args = { "186" },                              name = "goto 186" },
    { step = gotoRoom,         args = { "265" },                              name = "goto 265" },
    { step = gotoRoom,         args = { "261" },                              name = "goto 261" },
    { step = gotoRoom,         args = { "278" },                              name = "goto 278" },
    { step = gotoRoom,         args = { "261" },                              name = "goto 261" },
    { step = gotoRoom,         args = { "271" },                              name = "goto 271" },
    { step = toggleHunting,    args = { false },                              advance = true },
    { step = raiseGlobalEvent, args = { "escape" },                           advance = true },
    { step = raiseEvent,       args = { "sysManualLocationSetEvent", "281" }, advance = true }
}
Nf.missions.iog_jungle = {
    { step = send,             args = { directions["iog"] },                  advance = true },
    { step = send,             args = { "look" },                             advance = true },
    { step = toggleHunting,    args = { true },                               advance = true },
    { step = gotoRoom,         args = { "118" } },
    { step = gotoRoom,         args = { "414" } },
    { step = gotoRoom,         args = { "502" } },
    { step = gotoRoom,         args = { "96" } },
    { step = gotoRoom,         args = { "91" } },
    { step = toggleHunting,    args = { false },                              advance = true },
    { step = raiseGlobalEvent, args = { "escape" },                           advance = true },
    { step = raiseEvent,       args = { "sysManualLocationSetEvent", "281" }, advance = true }
}
Nf.missions.iog_gems = {
    { step = send,             args = { directions["iog"] },                  advance = true },
    { step = send,             args = { "look" },                             advance = true },
    { step = toggleHunting,    args = { true },                               advance = true },
    { step = gotoRoom,         args = { "130" } },
    { step = gotoRoom,         args = { "132" } },
    { step = gotoRoom,         args = { "135" } },
    { step = gotoRoom,         args = { "129" } },
    { step = gotoRoom,         args = { "158" } },
    { step = toggleHunting,    args = { false },                              advance = true }, -- skip diamond
    { step = gotoRoom,         args = { "164" } },
    { step = toggleHunting,    args = { true },                               advance = true },
    { step = gotoRoom,         args = { "182" } },
    { step = gotoRoom,         args = { "183" } },
    { step = toggleHunting,    args = { false },                              advance = true },
    { step = raiseGlobalEvent, args = { "escape" },                           advance = true },
    { step = raiseEvent,       args = { "sysManualLocationSetEvent", "281" }, advance = true }
}

Nf.missions.orcs = {
    { step = send,             args = { directions["orcs"] },                 advance = true },
    { step = send,             args = { "look" },                             advance = true },
    { step = toggleHunting,    args = { true },                               advance = true },
    { step = gotoRoom,         args = { "1576" } },
    { step = gotoRoom,         args = { "1577" } },
    { step = gotoRoom,         args = { "1621" } },
    { step = gotoRoom,         args = { "1614" } },
    { step = gotoRoom,         args = { "1587" } },
    { step = gotoRoom,         args = { "1603" } },
    { step = gotoRoom,         args = { "1601" } },
    { step = gotoRoom,         args = { "1609" } },
    { step = gotoRoom,         args = { "1608" } },
    { step = gotoRoom,         args = { "1610" } },
    { step = gotoRoom,         args = { "1681" } },
    { step = gotoRoom,         args = { "1684" } },
    { step = gotoRoom,         args = { "1685" } },
    { step = toggleHunting,    args = { false },                              advance = true },
    { step = raiseGlobalEvent, args = { "escape" },                           advance = true },
    { step = raiseEvent,       args = { "sysManualLocationSetEvent", "281" }, advance = true }
}


Nf.missions.azer = {
    { step = send,             args = { "run 6ws2wnws2wn3ws5wn8w6w18sws3wsu" }, advance = true },
    { step = send,             args = { "look" },                               advance = true },
    { step = toggleHunting,    args = { true },                                 advance = true },
    { step = gotoRoom,         args = { "302" } },
    { step = gotoRoom,         args = { "314" } },
    { step = gotoRoom,         args = { "311" } },
    { step = gotoRoom,         args = { "38" } },
    { step = gotoRoom,         args = { "12" } },
    { step = gotoRoom,         args = { "437" } },
    { step = gotoRoom,         args = { "441" } },
    { step = gotoRoom,         args = { "442" } },
    { step = gotoRoom,         args = { "426" } },
    { step = gotoRoom,         args = { "415" } },
    { step = gotoRoom,         args = { "430" } },
    { step = gotoRoom,         args = { "27" } },
    { step = gotoRoom,         args = { "28" } },
    { step = gotoRoom,         args = { "316" } },
    { step = gotoRoom,         args = { "36" } },
    { step = gotoRoom,         args = { "37" } },
    { step = gotoRoom,         args = { "42" } },
    { step = gotoRoom,         args = { "46" } },
    { step = gotoRoom,         args = { "48" } },
    { step = gotoRoom,         args = { "50" } },
    { step = gotoRoom,         args = { "52" } },
    { step = gotoRoom,         args = { "53" } },
    { step = gotoRoom,         args = { "78" } },
    { step = gotoRoom,         args = { "86" } },
    { step = toggleHunting,    args = { false },                                advance = true },
    { step = raiseGlobalEvent, args = { "escape" },                             advance = true },
    { step = raiseEvent,       args = { "sysManualLocationSetEvent", "281" },   advance = true }
}

Nf.missions.bgf = {
    { step = send,             args = { directions["bgf"] },                  advance = true },
    { step = send,             args = { "look" },                             advance = true },
    { step = toggleHunting,    args = { true },                               advance = true },
    { step = gotoRoom,         args = { "1463" } },
    { step = gotoRoom,         args = { "1470" } },
    { step = gotoRoom,         args = { "1476" } },
    { step = gotoRoom,         args = { "1478" } },
    { step = gotoRoom,         args = { "1442" } },
    { step = gotoRoom,         args = { "1488" } },
    { step = toggleHunting,    args = { false },                              advance = true },
    { step = raiseGlobalEvent, args = { "escape" },                           advance = true },
    { step = raiseEvent,       args = { "sysManualLocationSetEvent", "281" }, advance = true }
}

Nf.missions.dktown = {
    { step = send,             args = { directions["dktown"] },               advance = true },
    { step = send,             args = { "look" },                             advance = true },
    { step = gotoRoom,         args = { "664" } },
    { step = send,             args = { "inv" },                              advance = true },
    { step = expandAlias,      args = { "sellinv" },                          advance = true },
    { step = send,             args = { "get all from aero" },                advance = true },
    { step = send,             args = { "inv" },                              advance = true },
    { step = expandAlias,      args = { "sellinv" },                          advance = true },
    { step = gotoRoom,         args = { "668" } },
    { step = send,             args = { "inv" },                              advance = true },
    { step = expandAlias,      args = { "sellinv" },                          advance = true },
    { step = send,             args = { "get all from aero" },                advance = true },
    { step = send,             args = { "inv" },                              advance = true },
    { step = expandAlias,      args = { "sellinv" },                          advance = true },
    { step = gotoRoom,         args = { "667" } },
    { step = send,             args = { "inv" },                              advance = true },
    { step = expandAlias,      args = { "sellinv" },                          advance = true },
    { step = send,             args = { "get all from aero" },                advance = true },
    { step = send,             args = { "inv" },                              advance = true },
    { step = expandAlias,      args = { "sellinv" },                          advance = true },
    { step = raiseGlobalEvent, args = { "escape" },                           advance = true },
    { step = raiseEvent,       args = { "sysManualLocationSetEvent", "281" }, advance = true },
}

function Nf.setMission(mission)
    if not mission then
        Nf.mission.steps = {}
        Nf.msg("setMission called with no mission steps!")
        return
    else
        Nf.mission.steps = table.deepcopy(mission)
    end
end

function Nf.startMission(mission)
    if mission == "stop" then
        Nf.mission.steps = {}
        Nf.walking = false
        map.stopSpeedwalk()
        Nf.hunting = false
        return
    end
    if not Nf.missions[mission] then
        Nf.msg("No mission '" .. mission .. "' found.")
        return
    end

    if map.currentRoom ~= 294 then -- G0
        gotoRoom(294)
        tempTimer(2, function() Nf.startMission(mission) end)
        return
    end

    Nf.setMission(Nf.missions[mission])
    missionStopWatch = missionStopWatch or createStopWatch()
    missionExp = tonumber(msdp.EXPERIENCE)
    if next(Nf.mission.steps) ~= nil then
        startStopWatch(missionStopWatch)
        local advance = Nf.mission.steps[1].advance or false
        if Nf.mission.steps[1].args then
            if Nf.mission.steps[1].name then
                Nf.msg("Mission step: " .. Nf.mission.steps[1].name)
            end

            Nf.mission.steps[1].step(unpack(Nf.mission.steps[1].args))
            table.remove(Nf.mission.steps, 1)
        else
            Nf.mission.steps[1].step()
            table.remove(Nf.mission.steps, 1)
        end
        if advance then
            tempTimer(1, function()
                Nf.msg("Raising advanceMission post mission start")
                raiseEvent("advanceMission")
            end)
        end
    else
        Nf.msg("Mission steps not set!")
    end
end

function Nf.advanceMission() -- move the mission up a step, or complete.
    if Nf.inCombat then
        -- Nf.msg("advanceMission called but we're in combat, so sleeping.")
        -- if Nf.timers.advanceMission then killTimer(Nf.timers.advanceMission) end
        -- Nf.timers.advanceMission = tempTimer(2, function() Nf.advanceMission() end)
        Nf.msg("Tried to advance mission but we are in combat, so aborting and waiting for signal.")
        return
    end

    if Nf.walking or (speedWalkDir and #speedWalkDir ~= 0) then
        Nf.msg("Tried to advance mission, but on a speedwalk or speed walk paused, so aborting and waiting for signal.")
        return
    end

    if (next(map.prompt.mobs) ~= nil) and Nf.hunting then
        Nf.msg("advanceMission called but there are mobs in the room, so handing off to clearRoom")
        Nf.clearRoom()
        --if Nf.timers.advanceMission then killTimer(Nf.timers.advanceMission) end
        --Nf.timers.advanceMission = tempTimer(2, function() Nf.advanceMission() end)
        return
    end

    -- TODO reimplement zone clearing using Nf.rooms
    -- if next(Nf.rooms) ~= nil then
    --     table.remove(Nf.rooms, 1)
    -- end
    -- if next(Nf.rooms) ~= nil then
    --     gotoRoom(Nf.rooms[1])
    --     return
    -- end

    -- finished this step of the mission
    if next(Nf.mission.steps) ~= nil then
        local advance = Nf.mission.steps[1].advance or false
        if Nf.mission.steps[1].args then
            if Nf.mission.steps[1].name then
                Nf.msg("Mission step: " .. Nf.mission.steps[1].name)
            end

            Nf.mission.steps[1].step(unpack(Nf.mission.steps[1].args))
            table.remove(Nf.mission.steps, 1)
        else
            if Nf.mission.steps[1].name then
                Nf.msg("Mission step (no args): " .. Nf.mission.steps[1].name)
            end
            Nf.mission.steps[1].step()
            table.remove(Nf.mission.steps, 1)
        end
        if advance then -- need a way to reliably trigger the next step that's not from sysSpeedwalkFinished
            tempTimer(1, function()
                Nf.msg("Raising advance - queuing next mission step")
                -- could also just call the function I guess.
                raiseEvent("advanceMission")
            end)
        end
    else -- mission over, log the report.
        if getStopWatchTime(missionStopWatch) > 0 then
            local missionTime = stopStopWatch(missionStopWatch)
            local xpGained = tonumber(msdp.EXPERIENCE) - missionExp
            local xpPerSecond = xpGained / missionTime
            Nf.msg("Completed the mission in " .. tostring(missionTime) .. " seconds.")
            Nf.msg("XP gained: " .. tostring(xpGained) .. " / " .. xpPerSecond .. " per second.")
            resetStopWatch(missionStopWatch)
            missionExp = 0
        end

        raiseEvent("missionComplete")
        raiseGlobalEvent("missionComplete")
    end
end

registerNamedEventHandler(getProfileName(), "advanceMission", "advanceMission", Nf.advanceMission)

-- try to recover from a failed move on a speedwalk
function Nf.tryResumeSpeedwalk()
    Nf.msg("Trying to resume speedwalk from a failed state.")
    if Nf.inCombat then return end
    if Nf.walking then return end

    map.resumeSpeedwalk()
    Nf.walking = true
end

function Nf.postSpeedwalk()
    -- speedwalk has ended, but need to make sure we aren't in combat
    -- and clean up the mobs in the room before
    -- advancing the mission step.

    if Nf.inCombat then
        Nf.msg("postSpeedwalk called but we're in combat, so letting combat triggers handle advanceMission")
        -- tempTimer(2, function() Nf.postSpeedwalk() end)
        return
    elseif (next(map.prompt.mobs) ~= nil) and Nf.hunting then
        Nf.msg("postSpeedwalk called with mobs in the room, so letting clearRoom handle advanceMission")
        Nf.clearRoom()
        -- tempTimer(2, function() Nf.postSpeedwalk() end)
        return
    else -- we can advance the mission
        Nf.walking = false
        if Nf.onMission() then
            Nf.msg("Raising advanceMission from postSpeedwalk")
            raiseEvent("advanceMission")
        end
    end
end

--registerAnonymousEventHandler("sysSpeedwalkFinished", Nf.postSpeedwalk)
registerNamedEventHandler(getProfileName(), "postSpeedwalk", "sysSpeedwalkFinished", Nf.postSpeedwalk)

function Nf.onMission()
    if next(Nf.mission.steps) ~= nil then
        return true
    else
        return false
    end
end

-- Nf.walking  - currently actively speedwalking, not paused
-- should mirror the walking local in map
-- if speedwalking is paused, need to check #speedWalkDir ~= 0 to
-- see if we are in the middle of a speedwalk routine.
function Nf.clearRoom()
    -- don't clear if speedwalk is up
    if Nf.walking then
        Nf.msg("clearRoom called but we're in the middle of a speedwalk, so doing nothing.")
        return
    end

    -- ready to clear the room, but already fighting due to aggro, missed trigger, etc.
    if Nf.inCombat then
        Nf.msg("clearRoom called but already fighting, so sleeping.")
        if Nf.timers.clearRoom then killTimer(Nf.timers.clearRoom) end
        Nf.timers.clearRoom = tempTimer(1, function() Nf.clearRoom() end)
        return
    end

    -- start combat if there are mobs to kill.
    if not Nf.inCombat and (next(map.prompt.mobs) ~= nil) then
        Nf.msg("Sending kill command for " .. map.prompt.mobs[1])
        Nf.attack("mob")
        -- manually set inCombat here beacuse sometimes we kill mobs so quickly the msdp events don't
        -- come from the server.
        Nf.inCombat = true
        -- set a timer to check in on the room just in case the triggers don't fire.
        -- if Nf.timers.clearRoom then killTimer(Nf.timers.clearRoom) end
        -- Nf.timers.clearRoom = tempTimer(1, function() Nf.clearRoom() end)
        return
    end

    if (next(map.prompt.mobs) == nil) and Nf.onMission() and not Nf.inCombat then -- room is clear, time to advance mission
        Nf.msg("Raising advanceMission from clearRoom")
        raiseEvent("advanceMission")
        return
    end

    Nf.msg("Got to the end of clearRoom with no conditions met and no timer! Please investigate.")
end

local missionList = { "azer", "montaire", "iog_jungle", "iog_gems", "bgf" }

-- only call via raiseEvent
function Nf.grind(event)
    Nf.msg("Nf.grind triggered with event: " .. tostring(event))
    if Nf.onMission() then return end
    if not Nf.grinding then return end

    if next(Nf.grindList) == nil then
        Nf.grindList = table.deepcopy(missionList)
    end

    local ready = function()
        if (event == "manaReady") or (event == nil) then
            return true
        end

        if (event == "missionComplete") and (Nf.waitForMana == false) then
            return true
        end

        return false
    end

    if ready() then
        -- wake everyone up
        raiseGlobalEvent("sysSendAllProfiles", "wake ; stand")
        local k, mission = next(Nf.grindList)
        tempTimer(2, function()
            Nf.startMission(mission)
            table.remove(Nf.grindList, 1)
        end)
    end
end

registerNamedEventHandler(getProfileName(), "grindEventMana", "manaReady", Nf.grind)
registerNamedEventHandler(getProfileName(), "grindEventMission", "missionComplete", Nf.grind)
