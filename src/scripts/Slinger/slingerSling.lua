-- sling a spell event, with optional targets. not to be used for self buffs
function slingerSling(event, spell, target, profileName)
    display("Caught event slinger with spell " .. spell)

    if target ~= "" then
        send("sling '" .. spell .. "' " .. target)
    else
        send("sling '" .. spell .. "'")
    end
end
