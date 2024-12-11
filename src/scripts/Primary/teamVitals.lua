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

    if event == "destroy" then -- TODO: box add and show if the profile comes back.
        Nf.profiles[profileName].box:hide()
        TeamBox:remove(Nf.profiles[profileName].box)
        TeamBox:organize()
        return
    end

    local events = { ["hp"] = "chartreuse", ["mana"] = "blue", ["move"] = "lightskyblue" }
    if not Nf.profiles[profileName] then
        Nf.profiles[profileName] = {}
        Nf.profiles[profileName].box = Geyser.VBox:new({ height = "7.5%" }, TeamBox)

        for k, v in pairs(events) do
            local barName = k .. "Bar"
            Nf.profiles[profileName][barName] = Geyser.Gauge:new({
                name = profileName .. barName,
                height = "2.5%",
            }, Nf.profiles[profileName].box)
            Nf.profiles[profileName][barName].front:setStyleSheet(
                [[background-color: ]] .. v .. [[;
                border-top: 0.1em black solid;
                border-left: 0.1em black solid;
                border-bottom: 0.1em black solid;
                border-radius: 0.7em;
                padding: 0.3em;
            ]])
            Nf.profiles[profileName][barName].back:setStyleSheet(
                [[background-color: black;
            border-width: 0.1em;
            border-color: black;
            border-style: solid;
            border-radius: 0.7em;
            padding: 0.3em;
        ]])
            Nf.profiles[profileName][barName]:setFgColor("black")
            Nf.profiles[profileName][barName]:setFontSize(18)
            Nf.profiles[profileName][barName]:setValue(100, 100, "<b>" .. profileName .. "</b>")
        end
    end

    local bar = event .. "Bar"

    Nf.profiles[profileName][event] = value
    Nf.profiles[profileName][bar]:setValue(value, 100)
end
