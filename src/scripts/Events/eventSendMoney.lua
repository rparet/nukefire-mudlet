function eventSendMoney(_, unused, profileName)
  if msdp.MONEY == nil then
    display("No credits set!")
  else
    send("give " .. msdp.MONEY .. " credits " .. profileName)
  end
end
