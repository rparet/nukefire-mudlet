if string.find(matches[1], "gossips") then
    demonnic.chat:append("Gossip")
elseif string.find(matches[1], "telepaths") then
    demonnic.chat:append("Tells")
elseif string.find(matches[1], "Group") then
    demonnic.chat:append("Group")
elseif string.find(matches[1], "Skynet") then
    demonnic.chat:append("Skynet")
elseif string.find(matches[1], "auctions") then
    demonnic.chat:append("Auction")
end
