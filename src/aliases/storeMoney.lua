if msdp.MONEY == nil then
    display("No credits!")
    return
end
send("get card blast")
send("deposit " .. msdp.MONEY)
send("balance")
send("put card blast")
