-- choose a level appropriate combat skill. uses MSDP

local function samurai(level)
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

  return skill
end


local function assassin(level)
  local skill = "circle" -- default skill

  if level < 5 then
    return
  elseif level < 22 then
    skill = "circle"
  elseif level < 40 then
    skill = "disembowel"
  else
    skill = "daggerdance"
  end

  return skill
end

local function ninja(level)
  local skill = "storm" -- default skill

  if level == 50 then
    skill = "storm"
  elseif level < 5 then
    skill = "strike"
  elseif level < 15 then
    skill = "spinkick"
  elseif level < 20 then
    skill = "circle"
  elseif level < 25 then
    skill = "groinrip"
  elseif level < 35 then
    skill = "dragonkick"
  else
    skill = "tigerpunch"
  end

  return skill
end

function combatSkill()
  if not Nf.inCombat then
    return
  end

  local level = tonumber(msdp.LEVEL)

  if msdp.CLASS == "Samurai" then
    send(samurai(level))
  elseif msdp.CLASS == "Assassin" then
    local skill = assassin(level)
    if skill then
      send(skill)
    end
  elseif msdp.CLASS == "Ninja" then
    local skill = ninja(level)
    if skill then
      send(skill)
    end
  end

  if Nf.timers.combatSkill then killTimer(Nf.timers.combatSkill) end
  Nf.timers.combatSkill = tempTimer(2, combatSkill)
end
