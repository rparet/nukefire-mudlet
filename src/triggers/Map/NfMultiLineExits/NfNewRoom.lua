if map.prompt.description then
    map.prompt.hash = md5.sumhexa(map.prompt.description)
end
raiseEvent("onNewRoom", matches[2] or "")
