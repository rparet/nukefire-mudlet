-- enable / disable class-specific aliases, triggers, and scripts
-- driven by msdp.CLASS, so it should work with longwalking, etc.

local function configClassScripts(class)
    local classes = { "Samurai", "Slinger", "Curist", "Knight", "Heretic", "Ninja" }
    local enableResult

    -- When called, turn on your scripts and turn off the rest.
    for k, v in pairs(classes) do
        if v == class then
            enableResult = enableScript(class)
            Nf.msg("Enabling " .. class .. ": " .. tostring(enableResult))
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
    local enableResult
    Nf.msg("Setting profile-specific scripts")
    if Nf.profile.primary then
        Nf.showButtons()
        enableResult = enableScript("Primary")
        Nf.msg("Enabling Primary: " .. tostring(enableResult))
    else
        enableResult = disableScript("Primary")
        Nf.msg("Disabling Primary: " .. tostring(enableResult))
    end

    Nf.msg("Setting class-specific scripts")
    if not msdp.CLASS then
        return
    end

    configClassScripts(msdp.CLASS)
end

registerNamedEventHandler(getProfileName(), "loadClassHandler", "sysInstall", ClassHandler)
