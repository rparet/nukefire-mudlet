local mob = string.trim(multimatches[2]["mob"])
table.insert(map.prompt.mobs, mob)
db:add(Nf.db.characters, { name = mob })
setTriggerStayOpen("NfRoomName", 1)
