local function findAreaID(areaname)
    local list = getAreaTable()

    -- iterate over the list of areas, matching them with substring match.
    -- if we get match a single area, then return it's ID, otherwise return
    -- 'false' and a message that there are than one are matches
    local returnid, fullareaname
    for area, id in pairs(list) do
        if area:find(areaname, 1, true) then
            if returnid then return false, "more than one area matches" end
            returnid = id; fullareaname = area
        end
    end

    return returnid, fullareaname
end

function Nf.roomList(areaname)
    local id, msg = findAreaID(areaname)
    if id then
        local roomlist, endresult = getAreaRooms(id), {}
        -- obtain a room list for each of the room IDs we got
        for _, id in pairs(roomlist) do
            endresult[id] = getRoomName(id)
        end

        return endresult
    elseif not id and msg then
        echo("ID not found; " .. msg)
    else
        echo("No areas matched the query.")
    end
end

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
    { step = send,             args = { directions["montaire"] }, advance = true },
    --{ step = map.find_me,      args = { nil, nil, nil, true },    advance = true },
    { step = send,             args = { "look" },                 advance = true },
    { step = toggleHunting,    args = { true },                   advance = true },
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
    { step = toggleHunting,    args = { false },                  advance = true },
    { step = raiseGlobalEvent, args = { "escape" },               advance = true }
}
Nf.missions.ocp = {
    { step = send,             args = { directions["ocp"] }, advance = true },
    { step = send,             args = { "look" },            advance = true },
    { step = toggleHunting,    args = { true },              advance = true },
    { step = gotoRoom,         args = { "187" } },
    { step = gotoRoom,         args = { "191" } },
    { step = gotoRoom,         args = { "208" } },
    { step = gotoRoom,         args = { "204" } },
    { step = gotoRoom,         args = { "235" } },
    { step = gotoRoom,         args = { "231" } },
    { step = gotoRoom,         args = { "247" } },
    { step = toggleHunting,    args = { false },             advance = true },
    { step = raiseGlobalEvent, args = { "escape" },          advance = true }
}
Nf.missions.iog_jungle = {
    { step = send,          args = { directions["iog"] }, advance = true },
    { step = send,          args = { "look" },            advance = true },
    { step = toggleHunting, args = { true },              advance = true },
    { step = gotoRoom,      args = { "118" } },
    { step = gotoRoom,      args = { "414" } },
    { step = gotoRoom,      args = { "502" } },
    { step = gotoRoom,      args = { "96" } },
    { step = gotoRoom,      args = { "91" } },
    { step = toggleHunting, args = { false },             advance = true },
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
    { step = raiseGlobalEvent, args = { "escape" },                             advance = true }
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
    if not Nf.missions[mission] then
        Nf.msg("No mission '" .. mission .. "' found.")
        return
    end

    Nf.setMission(Nf.missions[mission])
    missionStopWatch = missionStopWatch or createStopWatch()
    missionExp = missionExp or tonumber(msdp.EXPERIENCE)
    if next(Nf.mission.steps) ~= nil then
        startStopWatch(missionStopWatch)
        local advance = Nf.mission.steps[1].advance or false
        if Nf.mission.steps[1].args then
            local args = Nf.mission.steps[1].args
            Nf.mission.steps[1].step(unpack(args))
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
            local args = unpack(Nf.mission.steps[1].args)
            Nf.mission.steps[1].step(args)
            table.remove(Nf.mission.steps, 1)
        else
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
    end
end

--registerAnonymousEventHandler("advanceMission", Nf.advanceMission)
registerNamedEventHandler(getProfileName(), "advanceMission", "advanceMission", Nf.advanceMission)

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
        raiseEvent("advanceMission")
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

function map.adddoorName(name, dir)
    if map.mapping then
        name = name or ""
        dir = dir or ""
        if (name == "") or (dir == "") then return end
        local exits = {
            north = "north",
            south = "south",
            east = "east",
            west = "west",
            up = "up",
            down = "down",
            n = "n",
            s = "s",
            e = "e",
            w = "w",
            u = "u",
            d = "d"
        }
        dir = string.lower(dir)
        if not exits[dir] then return end

        local dataKey = "doorname_" .. exits[dir]
        name = string.lower(name)
        if name == "door" then
            clearRoomUserDataItem(map.currentRoom, dataKey)
        else
            setRoomUserData(map.currentRoom, dataKey, name)
        end
        map.echo("Added " .. name .. " as a doorname for " .. dataKey .. " in roomID: " .. map.currentRoom)
    else
        map.echo("Not mapping", false, true)
    end
end

function map.getdoorName(roomID, dir)
    local doorkey = "doorname_" .. dir
    local doorname = getRoomUserData(roomID, doorkey)
    if doorname == "" then doorname = "door" end

    return doorname
end

-- get current room exit names, to see if doors are closed or not
function map.getExitName(dir)
    local exits = {
        north = "north",
        south = "south",
        east = "east",
        west = "west",
        up = "up",
        down = "down",
        n = "north",
        s = "south",
        e = "east",
        w = "west",
        u = "up",
        d = "down"
    }


    return map.prompt.exitNames[exits[dir]]
end

-- normally we can just send move commands as fast as possible, but when there are
-- doors to open, we need to wait for the scripts that check if they are open/closed to catch up
local function cont_walk(waited)
    if not Nf.walking then return end

    -- check to see if we are done
    if #map.walkDirs == 0 then
        Nf.walking = false
        speedWalkPath, speedWalkWeight = {}, {}
        -- if (next(map.prompt.mobs) ~= nil) and Nf.hunting then
        --     Nf.clearRoom()
        -- end
        -- if roomlist and next(roomlist) ~= nil then
        --     roomlist[map.currentRoom] = nil
        -- end
        raiseEvent("sysSpeedwalkFinished")
        return
    end

    if (next(map.prompt.mobs) ~= nil) and Nf.hunting then
        if Nf.walking then
            Nf.msg("Pausing speedwalk for combat")
            map.pauseSpeedwalk()
            Nf.walking = false
        end
        Nf.clearRoom()
        return
    end

    local wait = 0

    if string.starts(map.walkDirs[1], "open") and waited and waited > 0 then -- this was a timed command
        local fragment = {}
        for k, v in string.gmatch(map.walkDirs[1], "[^%s]+") do
            table.insert(fragment, k)
        end
        if string.match(map.getExitName(fragment[3]), "is closed") then
            send(map.walkDirs[1])
        else
            send(fragment[3])
        end
        table.remove(map.walkDirs, 1)
    elseif string.starts(map.walkDirs[1], "open") then -- first time, need to wait
        wait = 1
    elseif waited == 0 then                            -- just move, no delay
        if roomlist and next(roomlist) ~= nil then
            roomlist[map.currentRoom] = nil
        end
        send(table.remove(map.walkDirs, 1))
        if Nf.hunting then
            wait = 1
        end
    end



    -- send next command via tempTimer

    if Nf.timers.speedwalk then killTimer(Nf.timers.speedwalk) end
    Nf.timers.speedwalk = tempTimer(wait, function() cont_walk(wait) end)
end

function map.speedwalk(roomID, walkPath, walkDirs)
    Nf.msg("Using Nukefire speedwalk, destination room #" .. tostring(speedWalkPath[#speedWalkPath]))
    local exitmap = {
        n = 'north',
        ne = 'northeast',
        nw = 'northwest',
        e = 'east',
        w = 'west',
        s = 'south',
        se = 'southeast',
        sw = 'southwest',
        u = 'up',
        d = 'down',
        ["in"] = 'in',
        out = 'out',
        l = 'look',
        ed = 'eastdown',
        eu = 'eastup',
        nd = 'northdown',
        nu = 'northup',
        sd = 'southdown',
        su = 'southup',
        wd = 'westdown',
        wu = 'westup',
    }
    roomID = roomID or speedWalkPath[#speedWalkPath]
    getPath(map.currentRoom, roomID)
    walkPath = speedWalkPath
    walkDirs = speedWalkDir
    if #speedWalkPath == 0 then
        map.echo("No path to chosen room found.", false, true)
        return
    end
    table.insert(walkPath, 1, map.currentRoom)
    -- go through dirs to find doors that need opened, etc
    -- add in necessary extra commands to walkDirs table
    local k = 1
    repeat
        local id, dir = walkPath[k], walkDirs[k]
        if exitmap[dir] then
            local doors = getDoors(id)
            local door = doors[dir]
            if door and door > 1 then
                local doorname = map.getdoorName(id, dir)
                -- if locked, unlock door
                if door == 3 then
                    table.insert(walkPath, k, id)
                    table.insert(walkDirs, k, "unlock " .. doorname .. " " .. dir)
                    k = k + 1
                elseif door == 2 then
                    -- if closed, open door
                    table.insert(walkPath, k, id)
                    table.insert(walkDirs, k, "open " .. doorname .. " " .. dir)
                    k = k + 1
                end
            end
        end
        k = k + 1
    until k > #walkDirs
    -- perform walk
    Nf.walking = true
    map.walkDirs = walkDirs
    cont_walk()
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
        send("k mob")
        -- manually set inCombat here beacuse sometimes we kill mobs so quickly the msdp events don't
        -- come from the server.
        Nf.inCombat = true
        -- set a timer to check in on the room just in case the triggers don't fire.
        -- if Nf.timers.clearRoom then killTimer(Nf.timers.clearRoom) end
        -- Nf.timers.clearRoom = tempTimer(1, function() Nf.clearRoom() end)
        return
    end

    if (next(map.prompt.mobs) == nil) and Nf.onMission and not Nf.inCombat then -- room is clear, time to advance mission
        raiseEvent("advanceMission")
        return
    end

    Nf.msg("Got to the end of clearRoom with no conditions met and no timer! Please investigate.")
end
