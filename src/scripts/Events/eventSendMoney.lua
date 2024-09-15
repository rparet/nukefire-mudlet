function eventSendMoney(_, profileName)
  if msdp.MONEY == "0" then
    Nf.msg("No credits!")
  else
    send("pay " .. profileName)
  end
end
