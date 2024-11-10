-- generic combat event loop. Will replace combatMagic and combatSkill eventually.
function Nf.combatLoop()
    if not Nf.inCombat then
        return
    end

    local level = tonumber(msdp.LEVEL)
    local opponentLevel = tonumber(msdp.OPPONENT_LEVEL)
    local skill = {}

    if Nf.flags.casting or Nf.flags.action then
        Nf.msg("Got to Nf.combatLoop but I've already taken my action, so sleeping.")
        if Nf.timers.combatLoop then killTimer(Nf.timers.combatLoop) end
        Nf.timers.combatLoop = tempTimer(2, Nf.combatLoop)
        return
    end

    if Nf.flags.lowMana then
        Nf.doSkills("combat", "skill")
    elseif Nf.flags.lowMove then
        Nf.doSkills("combat", "spell")
    else
        Nf.doSkills("combat")
    end

    -- restart the event loop after 2 seconds
    if Nf.timers.combatLoop then killTimer(Nf.timers.combatLoop) end
    Nf.timers.combatLoop = tempTimer(2, Nf.combatLoop)
end

-- perform a context-dependant skill or spell
-- options are: combat, buff, aoe, and opener
function Nf.doSkills(skillOption, type)
    local level = tonumber(msdp.LEVEL)
    local opponentLevel = tonumber(msdp.OPPONENT_LEVEL)
    local skills = {}

    local function get_highest_combat_skill(chLevel, skills_table, skillType)
        for _, entry in ipairs(skills_table) do
            if chLevel >= entry.level and entry.use == "combat" then
                if skillType and skillType == entry.type then
                    return entry.level, entry.name, entry.type
                elseif not skillType then
                    return entry.level, entry.name, entry.type
                end
            end
        end
        return {} -- Return empty table if no skill is available.
    end

    local function get_highest_aoe_skill(chLevel, skills_table)
        for _, entry in ipairs(skills_table) do
            if chLevel >= entry.level and entry.use == "aoe" then
                return entry.level, entry.name, entry.type
            end
        end
        return {} -- Return empty table if no skill is available.
    end

    local function get_available_buffs(chLevel, skills_table)
        local buffs = {}
        for _, entry in ipairs(skills_table) do
            if chLevel >= entry.level and entry.use == "buff" then
                table.insert(buffs, entry)
            end
        end
        return buffs
    end

    local function get_highest_opener_skill(chLevel, skills_table)
        for _, entry in ipairs(skills_table) do
            if chLevel >= entry.level and entry.use == "opener" then
                return entry.level, entry.name, entry.type
            end
        end
        return {} -- Return empty table if no skill is available.
    end

    -- actually perform the spell / skill
    local function doSkill(skill)
        if skill and skill.type == "spell" then
            send("sling '" .. skill.name .. "'")
            Nf.lastCast[skill.name] = getEpoch()
        elseif skill then
            send(skill.name)
        end
    end
    -- all skills/spells are local to this function
    local voidstriker_skills_table = {
        { level = 2,  name = "bonespur",     use = "combat",  type = "spell" },
        { level = 15, name = "grave grasp",  use = "combat",  type = "spell" },
        { level = 20, name = "nightfall",    use = "special", type = "skill" },
        { level = 25, name = "voidstep",     use = "buff",    type = "skill" },
        { level = 30, name = "pestilence",   use = "opener",  type = "spell" },
        { level = 35, name = "ravaged",      use = "aoe",     type = "spell" },
        { level = 40, name = "annihilate",   use = "combat",  type = "spell" },
        { level = 40, name = "eclipse form", use = "buff",    type = "spell" },
        { level = 40, name = "mark",         use = "opener",  type = "skill" },
        { level = 45, name = "eldritch cat", use = "aoe",     type = "spell" },
        { level = 47, name = "wraithfire",   use = "aoe",     type = "skill" },
        { level = 50, name = "voidpunch",    use = "combat",  type = "skill" },
        { level = 50, name = "voidwarp",     use = "special", type = "skill" }
    }
    table.sort(voidstriker_skills_table, function(a, b) return a.level > b.level end)

    if msdp.CLASS == "Voidstriker" and skillOption == "combat" then
        skills.level, skills.name, skills.type = get_highest_combat_skill(level, voidstriker_skills_table, type)
    elseif msdp.CLASS == "Voidstriker" and skillOption == "aoe" then
        skills.level, skills.name, skills.type = get_highest_aoe_skill(level, voidstriker_skills_table)
    elseif msdp.CLASS == "Voidstriker" and skillOption == "buff" then
        skills = get_available_buffs(level, voidstriker_skills_table)
    elseif msdp.CLASS == "Voidstriker" and skillOption == "opener" then
        skills.level, skills.name, skills.type = get_highest_opener_skill(level, voidstriker_skills_table)
    end

    if not next(skills) then
        return
    elseif skills.level then
        doSkill(skills)
    else
        for _, sk in ipairs(skills) do
            doSkill(sk)
        end
    end
end
