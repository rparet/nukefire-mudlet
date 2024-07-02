-- for each event, keep track of profile vitals in Nf.profile.profileName
function teamVitals(event, value, profileName)
    --TODO: Move all of this setup stuff into its own function
    if not TeamBox then
        -- HMV for Team
        TeamBox = Geyser.VBox:new({
            x = "-30%",
            y = "-35%",
            width = "25%",
            height = "22.5%"
        })
    end

    local events = { ["hp"] = "chartreuse", ["mana"] = "blue", ["move"] = "lightskyblue" }
    if not Nf.profiles[profileName] then
        Nf.profiles[profileName] = {}

        for k, v in pairs(events) do
            local barName = k .. "Bar"
            Nf.profiles[profileName][barName] = Geyser.Gauge:new({
                name = profileName .. barName,
                height = "2.5%",
            }, TeamBox)
            Nf.profiles[profileName][barName].front:setStyleSheet(
                [[background-color: ]] .. v .. [[;
                border-top: 1px black solid;
                border-left: 1px black solid;
                border-bottom: 1px black solid;
                border-radius: 7;
                padding: 3px;
            ]])
            Nf.profiles[profileName][barName].back:setStyleSheet(
                [[background-color: black;
            border-width: 1px;
            border-color: black;
            border-style: solid;
            border-radius: 7;
            padding: 3px;
        ]])
            Nf.profiles[profileName][barName]:setFgColor("black")
            Nf.profiles[profileName][barName]:setFontSize(18)
            Nf.profiles[profileName][barName]:setValue(100, 100, "<b>" .. profileName .. "</b>")
        end
    end

    local bar = event .. "Bar"

    Nf.profiles[profileName][event] = value
    Nf.profiles[profileName][bar]:setValue(value, 100, "<b>" .. profileName .. "</b>")
end
