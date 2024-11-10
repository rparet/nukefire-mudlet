Nf.inCombat = false
Nf.setFlag("fighting", false)
Nf.hunting = false
if Nf.flags.heal then
    Nf.setFlag("heal", false)
end
if Nf.flags.casting then
    Nf.setFlag("casting", false)
end
if Nf.flags.utsu then
    Nf.flags.utsu = 0
end

Nf.setFlag("action", false)
if Nf.flags.invig then
    Nf.setFlag("invig", false)
end

send("1")
Nf.getCorpse()
