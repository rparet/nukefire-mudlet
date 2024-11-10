Nf.msg("Caught failed action attempt. Clearing state and temp triggers.")
if Nf.flags.action then
    Nf.setFlag("action", false)
end

if Nf.flags.heal then
    Nf.setFlag("heal", false)
end

if Nf.flags.casting then
    Nf.setFlag("casting", false)
end

if Nf.flags.fighting then
    Nf.setFlag("fighting", false)
end

if Nf.flags.heal then
    Nf.setFlag("invig", false)
end

if Nf.triggers.action then
    killTrigger(Nf.triggers.action)
end

if Nf.triggers.casting then
    killTrigger(Nf.triggers.casting)
end
