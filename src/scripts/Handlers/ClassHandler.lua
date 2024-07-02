-- enable / disable class-specific aliases, triggers, and scripts
-- driven by msdp.CLASS, so it should work with longwalking, etc.

local function configClassScripts(class)
    local classes = { "Samurai", "Slinger", "Curist", "Primary", "Knight", "Heretic" }
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
    --handle special case for Knights and Heretics to get Curist stuff..
    if class == "Knight" or class == "Heretic" then
        Nf.msg("Enabling select Curist scripts for " .. class)
        enableScript("Curist")
    end
end

function ClassHandler()
    Nf.msg("Setting class-specific scripts.")
    if not msdp.CLASS then
        return
    end

    configClassScripts(msdp.CLASS)
end
