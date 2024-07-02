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
    skill = "legsweep"
  else
    skill = "tigerpunch"
  end

  return skill
end

local function knight(level)
  if level < 6 then
    return nil
  elseif level < 15 then
    return "bash"
  else
    return "flurry"
  end
end

local function heretic(level)
  if level < 25 then
    return
  elseif level < 39 then
    return "cleave"
  else
    return "smite"
  end
end

local function mutant(level)
  local skill = "emit" -- default skill

  if level < 3 then
    return
  elseif level < 13 then
    skill = "emit"
  elseif level < 15 then
    skill = "psionicwave"
  elseif level < 25 then
    skill = "psiattack"
  else
    if level < 50 then
      skill = "psiblast"
    else
      skill = "mindcrush"
    end

    return skill
  end
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
  elseif msdp.CLASS == "Mutant" then
    local skill = mutant(level)
    if skill then
      send(skill)
    end
  elseif msdp.CLASS == "Knight" then
    local skill = knight(level)
    if skill then
      send(skill)
    end
  elseif msdp.CLASS == "Heretic" then
    local skill = heretic(level)
    if skill then
      send(skill)
    end
  end

  if Nf.timers.combatSkill then killTimer(Nf.timers.combatSkill) end
  Nf.timers.combatSkill = tempTimer(4, combatSkill)
end
