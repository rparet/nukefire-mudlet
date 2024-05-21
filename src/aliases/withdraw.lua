local bag = Nf.profile.bag.one or "bag"
send("get card " .. bag)
send("withdraw " .. matches[2])
send("balance")
send("put card " .. bag)
