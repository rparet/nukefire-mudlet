-- sling a spell event, with optional targets. not to be used for self buffs
function samurai(event, skill, target, profileName)
    display("Caught event samurai with skill " .. skill)

    if target ~= "" then
        send(skill .. " " .. target)
    else
        send(skill)
    end
end
