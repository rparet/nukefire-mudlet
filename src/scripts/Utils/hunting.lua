function toggleHunting(toggle)
    if toggle then
        Nf.msg("Toggled hunting to " .. (toggle == true and 'on' or 'off'))
        Nf.hunting = toggle
        return
    end
    if Nf.hunting then
        Nf.msg("Toggled hunting off.")
        Nf.hunting = false
    else
        Nf.msg("Toggled hunting on.")
        Nf.hunting = true
    end
end
