-- for each event, keep track of profile vitals in Nf.profile.profileName
function teamVitals(event, value, profileName)
    if not Nf.profiles[profileName] then
        Nf.profiles[profileName] = {}
    end

    local bar = event .. "Bar"

    if not Nf.profiles[profileName][bar] then
        Nf.profiles[profileName][bar] = Geyser.Gauge:new({
            name = bar,
            x = "50%",
            y = "85%",
            width = "25%",
            height = "2.5%",
        })

        Nf.profiles[profileName][bar][front]:setStyleSheet(
            [[background-color: chartreuse;
            border-top: 1px black solid;
            border-left: 1px black solid;
            border-bottom: 1px black solid;
            border-radius: 7;
            padding: 3px;
        ]])
        Nf.profiles[profileName][bar][back]:setStyleSheet(
            [[background-color: black;
            border-width: 1px;
            border-color: black;
            border-style: solid;
            border-radius: 7;
            padding: 3px;
        ]])
    end

    Nf.profiles[profileName][event] = value
end
