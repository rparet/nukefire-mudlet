if Nf.profile.bank == true then
    Nf.withdraw(matches[2])
else
    raiseGlobalEvent("withdraw", matches[2])
end
