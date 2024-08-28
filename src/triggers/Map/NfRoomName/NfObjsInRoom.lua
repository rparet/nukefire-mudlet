-- this is mostly to put them somewhere so that their existence doesn't break finding mobs in the room.
if selectSection(0, 1) then
    if isAnsiFgColor(6) then                            --dark green
        table.insert(map.prompt.objs, getCurrentLine()) -- todo, deal with stacked objects if you need to.
        setTriggerStayOpen("NfRoomName", 1)
    end
end
