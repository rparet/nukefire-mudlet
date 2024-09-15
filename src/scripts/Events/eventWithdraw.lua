function Nf.withdraw(amount)
    local bag = Nf.profile.bag.one or "bag"
    send("get card " .. bag)
    send("withdraw " .. amount)
    send("balance")
    send("put card " .. bag)
end

function eventWithdraw(_, amount, profileName)
    if Nf.profile.bank ~= true then
        return
    else
        Nf.withdraw(amount)
        send("pay " .. profileName)
    end
end
