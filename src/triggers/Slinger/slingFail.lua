Nf.msg("Caught failed sling attempt. Clearing state and temp triggers.")


if Nf.flags.casting then
    Nf.flags.casting = false
end

if Nf.triggers.casting then
    killTrigger(Nf.triggers.casting)
end
