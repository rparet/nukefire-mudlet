local type = matches[1] or nil

if type == "gac" then
    send("get all from all.corpse")
elseif type == "gar" then
    send("get all from all.remains")
elseif type == "gap" then -- pieces of eight on pirate island
    send("get all.piece from all.corpse")
end
