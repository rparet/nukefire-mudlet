-- enable / disable class-specific aliases, triggers, and scripts
-- driven by msdp.CLASS, so it should work with longwalking, etc.

local function configClassScripts(class)
    local classes = { "Samurai", "Slinger", "Curist", "Primary" }
    local enableResult

    -- When called, turn on your scripts and turn off the rest.
    for k, v in pairs(classes) do
        if v == class then
            enableResult = enableScript(class)
            Nf.msg("Enabling " .. class .. ": " .. tostring(enableResult))
        elseif v == "Primary" and class == "Mutant" then
            enableResult = enableScript("Primary")
            Nf.msg("Enabling Primary: " .. tostring(enableResult))
        else
            enableResult = disableScript(v)
            Nf.msg("Disabling " .. v .. ": " .. tostring(enableResult))
        end
    end
end

function ClassHandler()
    Nf.msg("Setting class-specific scripts.")
    if not msdp.CLASS then
        return
    end

    configClassScripts(msdp.CLASS)

    -- if msdp.CLASS == "Mutant" then
    --     disableScript("Curist")
    --     disableScript("Samurai")
    --     disableScript("Slinger")
    --     --TODO - fix this so it can be a different primary screen, not just mutant
    --     enableScript("Primary")
    -- end

    -- if msdp.CLASS == "Curist" then
    --     enableScript("Curist")
    --     disableScript("Samurai")
    --     disableScript("Slinger")
    --     disableScript("Primary")
    -- end

    -- if msdp.CLASS == "Samurai" then
    --     enableScript("Samurai")
    --     disableScript("Curist")
    --     disableScript("Slinger")
    --     disableScript("Primary")
    -- end

    -- if msdp.CLASS == "Slinger" then
    --     enableScript("Slinger")
    --     disableScript("Curist")
    --     disableScript("Mutant")
    --     disableScript("Samurai")
    --     disableScript("Primary")
    -- end
end
