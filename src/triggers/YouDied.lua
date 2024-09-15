Nf.inCombat = false
Nf.hunting = false
if Nf.flags.heal then
    Nf.flags.heal = false
end
if Nf.flags.casting then
    Nf.flags.casting = false
end
if Nf.flags.utsu then
    Nf.flags.utsu = 0
end
Nf.flags.action = false

send("1")
Nf.getCorpse()
