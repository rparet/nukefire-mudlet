if msdp.MONEY == nil then
    Nf.msg("No credits!")
    return
end
local bag = Nf.profile.bag.one or "bag"
send("get card " .. bag)
send("deposit " .. msdp.MONEY)
send("balance")
send("put card " .. bag)
