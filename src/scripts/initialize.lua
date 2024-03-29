-- Baseline setup functions

msdp = msdp or {}

-- namespace everything global (eventually) into a Nukefire (Nf) table
Nf = Nf or {}

Nf.inCombat = Nf.inCombat or false


function initMSDP(_, protocol)
    if protocol == "MSDP" then
        sendMSDP("REPORT", "AFFECTS", "ALIGNMENT", "EXPERIENCE", "EXPERIENCE_MAX", "EXPERIENCE_TNL", "HEALTH",
            "HEALTH_MAX", "LEVEL", "RACE", "CLASS", "MANA", "MANA_MAX", "WIMPY", "PRACTICE", "MONEY", "MOVEMENT",
            "MOVEMENT_MAX", "HITROLL", "DAMROLL", "AC", "STR", "INT", "WIS", "DEX", "CON", "STR_PERM", "INT_PERM",
            "WIS_PERM", "DEX_PERM", "CON_PERM", "OPPONENT_HEALTH", "OPPONENT_HEALTH_MAX", "OPPONENT_LEVEL",
            "OPPONENT_NAME")
    end
end

registerAnonymousEventHandler("sysProtocolEnabled", initMSDP)


hpBar = Geyser.Gauge:new({
    name = "hpbar",
    x = "50%",
    y = "85%",
    width = "25%",
    height = "2.5%",
})

hpBar.front:setStyleSheet(
    [[background-color: chartreuse;
    border-top: 1px black solid;
    border-left: 1px black solid;
    border-bottom: 1px black solid;
    border-radius: 7;
    padding: 3px;
]])
hpBar.back:setStyleSheet(
    [[background-color: black;
    border-width: 1px;
    border-color: black;
    border-style: solid;
    border-radius: 7;
    padding: 3px;
]])

manaBar = Geyser.Gauge:new({
    name = "manabar",
    x = "50%",
    y = "82.5%",
    width = "25%",
    height = "2.5%",
})
manaBar.front:setStyleSheet(
    [[background-color: blue;
    border-top: 1px black solid;
    border-left: 1px black solid;
    border-bottom: 1px black solid;
    border-radius: 7;
    padding: 3px;
]])
manaBar.back:setStyleSheet(
    [[background-color: black;
    border-width: 1px;
    border-color: black;
    border-style: solid;
    border-radius: 7;
    padding: 3px;
]])



moveBar = Geyser.Gauge:new({
    name = "movebar",
    x = "50%",
    y = "80%",
    width = "25%",
    height = "2.5%",
})
moveBar.front:setStyleSheet(
    [[background-color: lightskyblue;
    border-top: 1px black solid;
    border-left: 1px black solid;
    border-bottom: 1px black solid;
    border-radius: 7;
    padding: 3px;
]])
moveBar.back:setStyleSheet(
    [[background-color: black;
    border-width: 1px;
    border-color: black;
    border-style: solid;
    border-radius: 7;
    padding: 3px;
]])
