Nf.msg("Caught failed action attempt. Clearing state and temp triggers.")
if Nf.flags.action then
    Nf.flags.action = false
end

if Nf.flags.heal then
    Nf.flags.heal = false
end

if Nf.flags.casting then
    Nf.flags.casting = false
end

if Nf.triggers.action then
    killTrigger(Nf.triggers.action)
end

if Nf.triggers.casting then
    killTrigger(Nf.triggers.casting)
end
