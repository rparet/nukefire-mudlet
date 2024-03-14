-- level appropriate heal. needs MSDP level attribute

function heal(profileName)
  local level = tonumber(msdp.LEVEL)
  local spell = "rejuv" -- default spell
  if level <= 8 then
    spell = "cure light"
  elseif level <= 11 then
    spell = "cure critic"
  elseif level <= 24 then
    spell = "heal"
  else
    spell = "rejuvinate"
  end

  send("sling '"..spell.."' "..profileName)
end