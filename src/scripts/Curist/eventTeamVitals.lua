-- team vitals for curist / heretic healing calculations
function eventTeamVitals(event, value, profileName)
    if not Nf.profiles[profileName] then
        Nf.profiles[profileName] = {}
    end
    Nf.profiles[profileName][event] = value
end
