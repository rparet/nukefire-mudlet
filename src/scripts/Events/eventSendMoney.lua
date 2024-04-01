function eventSendMoney(_, profileName)
  if msdp.MONEY == nil then
    Nf.msg("No credits!")
  else
    send("pay " .. profileName)
  end
end
