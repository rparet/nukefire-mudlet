Nf.msg("Caught failed action attempt. Clearing state and temp triggers.")
if Nf.flags.action then
    Nf.flags.action = false
end

if Nf.triggers.action then
    killTrigger(Nf.triggers.action)
end
