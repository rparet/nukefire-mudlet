-- choose a level appropriate combat spell to sling. uses MSDP

function combatMagic()
    local level = tonumber(msdp.LEVEL)
    local spell = ""

    if level <= 2 then
        spell = "magic missle"
    elseif level <= 4 then
        spell = "chill touch"
    elseif level <= 6 then
        spell = "burning hands"
    elseif level <= 8 then
        spell = "shocking grasp"
    elseif level <= 10 then
        spell = "lightning bolt"
    elseif level <= 14 then
        spell = "color spray"
    elseif level <= 17 then
        spell = "fireball"
    elseif level <= 21 then
        spell = "calliope"
    elseif level <= 39 then
        spell = "disruption"
    elseif level >= 40 then
        spell = "disintegrate"
        -- handle phoenix nova separately
    end

    send("sling '" .. spell .. "'")
end
