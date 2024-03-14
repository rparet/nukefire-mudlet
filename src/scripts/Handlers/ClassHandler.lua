-- enable / disable class-specific aliases, triggers, and scripts
-- driven by msdp.CLASS, so it should work with longwalking, etc.

if not msdp.CLASS then
    return
end

if msdp.CLASS == "Mutant" then
    disableScript("Curist")
    disableScript("Samurai")
    --TODO - fix this so it can be a different primary screen, not just mutant
    enableScript("Primary")
end

if msdp.CLASS == "Curist" then
    enableScript("Curist")
    disableScript("Samurai")
    disableScript("Primary")
end

if msdp.CLASS == "Samurai" then
    enableScript("Samurai")
    disableScript("Curist")
    disableScript("Primary")
end
