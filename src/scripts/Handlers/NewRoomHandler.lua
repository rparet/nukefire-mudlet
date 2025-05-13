function NewRoomHandler()
    map.prompt.room = msdp.ROOM_NAME
    map.prompt.exits = msdp.ROOM_EXITS
    map.prompt.vnum = msdp.ROOM_VNUM
    map.prompt.hash = ""

    raiseEvent("onNewRoom", map.prompt.exits)
end
