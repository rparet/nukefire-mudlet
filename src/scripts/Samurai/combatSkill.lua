-- choose a level appropriate combat skill. uses MSDP

function combatSkill()
  local level = tonumber(msdp.LEVEL)
  local skill = "flurry" -- default skill

  if level <= 6 then
    skill = "kick"
  elseif level <= 19 then
    skill = "bash"
  elseif level <= 21 then
    skill = "grapple"
  else
    skill = "flurry"
  end

  send(skill)
end
