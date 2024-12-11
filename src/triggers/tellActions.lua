local valid_options = { "sum", "vwarp", }

if not table.contains(valid_options, matches.command) then
    return
end

if matches.command == "sum" then
    send("sling 'summon' " .. matches.target)
elseif matches.command == "vwarp" then
    local target = ""
    if matches.alttarget ~= "" then
        target = matches.alttarget
    else
        target = matches.target
    end
    send("voidwarp " .. target)
end
