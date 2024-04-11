-- choose a level appropriate combat skill. uses MSDP

function combatSkill()
  local called = 1
  if not Nf.inCombat then
    Nf.msg("combatSkill called, but not in combat. Called: " .. called)
    return
  end
  Nf.msg("Firing combatSkill. Called: " .. called)
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
  tempTimer(2, combatSkill)
  called = called + 1
end
