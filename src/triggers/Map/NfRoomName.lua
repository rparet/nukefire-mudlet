map.prompt.room = multimatches[2][2]
map.prompt.mobs = {} -- rebuild each time we trigger the room name
map.prompt.env = multimatches[2]["env"] or ""
map.prompt.description = nil
map.prompt.hash = nil
map.prompt.objs = {}
