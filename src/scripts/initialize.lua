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
-- opening move / attack - saved and settable per profile
Nf.profile.attack     = Nf.profile.attack or "gt attack not set!"
-- primary profile
Nf.profile.primary    = Nf.profile.primary or false
-- do auto attacks, etc. or not.
Nf.profile.autos      = Nf.profile.autos or true
Nf.target             = Nf.target or { name = "foo", type = "man" }
Nf.buttons            = Nf.buttons or {}

Nf.rooms              = Nf.rooms or {}
Nf.mission            = Nf.mission or {}
Nf.mission.steps      = Nf.mission.steps or {}
Nf.timers             = Nf.timers or {}
Nf.flags              = Nf.flags or {}
Nf.triggers           = Nf.triggers or {} -- temp triggers
Nf.lastCast           = Nf.lastCast or {}

Nf.inventory          = Nf.inventory or {}

Nf.grinding           = Nf.grinding or false
Nf.grindList          = Nf.grindList or {}
Nf.waitForMana        = Nf.waitForMana or false

Nf.logOut             = Nf.logOut or false

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


function initMSDP(_, protocol)
    if protocol == "MSDP" then
        sendMSDP("REPORT", "AFFECTS", "ALIGNMENT", "EXPERIENCE", "EXPERIENCE_MAX", "EXPERIENCE_TNL", "HEALTH",
            "HEALTH_MAX", "LEVEL", "RACE", "CLASS", "MANA", "MANA_MAX", "WIMPY", "PRACTICE", "MONEY", "MOVEMENT",
            "MOVEMENT_MAX", "HITROLL", "DAMROLL", "AC", "STR", "INT", "WIS", "DEX", "CON", "STR_PERM", "INT_PERM",
            "WIS_PERM", "DEX_PERM", "CON_PERM", "OPPONENT_HEALTH", "OPPONENT_HEALTH_MAX", "OPPONENT_LEVEL",
            "OPPONENT_NAME", "AREA_NAME", "ROOM_EXITS", "ROOM_NAME", "ROOM_VNUM")
        sendMSDP("XTERM_256_COLORS", "1")
    end
end

registerAnonymousEventHandler("sysProtocolEnabled", initMSDP)

function Nf.showButtons()
    if not Nf.ButtonBox then
        Nf.ButtonBox = Geyser.HBox:new({ x = "-30%", y = "-45%", width = "25%", height = "7.5%" })
    end


    local buttons = {
        ["attack"] = { clickCommand = "attack mob", msg = "<center>Attack</center>" },
        ["nova"] = { clickCommand = "nova", msg = "<center>Nova</center>" },
        ["torment"] = { clickCommand = ">Armitage torment mob", msg = "<center>Torment</center>" },
        ["doom"] = { clickCommand = ">Armitage sling 'doom' mob", msg = "<center>Doom</center>" },
        ["crippling"] = { clickCommand = ">Frontline crippling mob", msg = "<center>Crippling</center>" },
        ["shield"] = { clickCommand = ">Armitage sling 'shield of flames'", msg = "<center>Shield</center>" },
        ["radstorm"] = { clickCommand = "radstorm", msg = "<center>Radstorm</center>" },
        ["vomit"] = { clickCommand = "vomit", msg = "<center>Vomit</center>" },
        ["weaponthrow"] = { clickCommand = ">Frontline wt", msg = "<center>Throw</center>" }
    }

    for k, v in spairs(buttons) do
        local config = table.union(v, { style = [[ margin: 1px; background-color: blue; border: 1px solid white; ]] })
        Nf.buttons[k] = Nf.buttons[k] or Geyser.Button:new(config, Nf.ButtonBox)
    end
end

if not HMVBox then
    HMVBox = Geyser.VBox:new({
        x = "-30%",
        y = "-10%",
        width = "25%",
        height = "7.5%"
    })
end

hpBar = hpBar or Geyser.Gauge:new({
    name = "hpbar",
    height = "2.5%",
}, HMVBox)

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
hpBar:setText("<b>" .. getProfileName() .. "</b>")

manaBar = manaBar or Geyser.Gauge:new({
    name = "manabar",
    height = "2.5%",
}, HMVBox)
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
    height = "2.5%",
}, HMVBox)
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

-- Package dependencies

if not table.contains(getPackages(), "EMCOChat") then
    --tabbed chat
    function installedEMCOChat(_, name)
        if name ~= "EMCOChat" then return end
        -- config emcochat with Nukefire preferences.
        demonnic.helpers.resetToDefaults()
        demonnic.chat:removeTab("Local")
        demonnic.chat:removeTab("City")
        demonnic.chat:removeTab("OOC")
        demonnic.chat:addTab("Gossip")
        demonnic.chat:addTab("SkyNet")
        demonnic.chat:addTab("Auction")
        demonnic.container:move("70%", "0px")
        demonnic.helpers.save()
        demonnic.helpers.load()
    end

    registerAnonymousEventHandler("sysInstallPackage", installedEMCOChat)
    installPackage("https://github.com/demonnic/EMCO/releases/latest/download/EMCOChat.mpackage")
end

Nf.commandList = {
    ["wt"] = { class = "Ninja", cmd = "weaponThrow()" }
}

function Nf.postInstall(_, name)
    if name ~= "nukefire" then return end
    Nf.msg("Thanks for installing nukefire-mudlet!")
    Nf.msg("If you haven't already, make sure that MSDP is enabled in Mudlet's settings.")
    Nf.msg("Also be sure to run the commands: nf primary true and nf bank true on your main profile.")
end

registerAnonymousEventHandler("sysInstallPackage", Nf.postInstall)
