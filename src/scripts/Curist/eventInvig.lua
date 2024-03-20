function eventInvig(_, profileName)
  display("Caught event invig from " .. profileName)
  send("sling 'invig' " .. profileName)
end
