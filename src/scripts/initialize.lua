-- Baseline setup functions

msdp                  = msdp or {}
map                   = map or {}

-- namespace everything global (eventually) into a Nukefire (Nf) table
Nf                    = Nf or {}

Nf.inCombat           = Nf.inCombat or false
Nf.hunting            = Nf.hunting or false
Nf.walking            = Nf.walking or false

Nf.profile            = Nf.profile or {}
Nf.profile.customWear = Nf.profile.customWear or {}

Nf.rooms              = Nf.rooms or {}
Nf.mission            = Nf.mission or {}
Nf.mission.steps      = Nf.mission.steps or {}
Nf.timers             = Nf.timers or {}
Nf.flags              = Nf.flags or {}

Nf.inventory          = Nf.inventory or {}

Nf.grinding           = Nf.grinding or false
Nf.grindList          = Nf.grindList or {}
Nf.waitForMana        = Nf.waitForMana or false

Nf.logout             = Nf.logout or false

Nf.debug              = Nf.debug or function(message) end


Nf.profiles = Nf.profiles or {}

-- save and load profile-configurable variables (bag names, etc.)
function Nf.save()
    local location = getMudletHomeDir() .. "/" .. getProfileName() .. ".lua"
    table.save(location, Nf.profile)
end

function Nf.load()
    local location = getMudletHomeDir() .. "/" .. getProfileName() .. ".lua"
    if io.exists(location) then
        table.load(location, Nf.profile)
    end
end

registerNamedEventHandler(getProfileName(), "loadEvent", "sysLoadEvent", Nf.load)
registerNamedEventHandler(getProfileName(), "loadClassHandler", "sysInstall", ClassHandler)

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


hpBar = hpBar or Geyser.Gauge:new({
    name = "hpbar",
    --    x = "50%",
    --    y = "85%",
    x = "-30%",
    y = "-5%",
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

hpBar:setFgColor("black")
hpBar:setFontSize(18)

manaBar = manaBar or Geyser.Gauge:new({
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



moveBar = moveBar or Geyser.Gauge:new({
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
