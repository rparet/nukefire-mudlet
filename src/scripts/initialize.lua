-- Baseline setup functions

msdp = msdp or {}
gaugesTable = gaugesTable or {}


-- setup roles to avoid hardcoding profile names
-- change these to match your characters
tank = tank or "Straylight"
healer = healer or "Armitage"
dps = dps or "Frontline"


local function initMSDP(_, protocol)
    if protocol == "MSDP" then
        sendMSDP("REPORT", "AFFECTS", "ALIGNMENT", "EXPERIENCE", "EXPERIENCE_MAX", "EXPERIENCE_TNL", "HEALTH",
            "HEALTH_MAX", "LEVEL", "RACE", "CLASS", "MANA", "MANA_MAX", "WIMPY", "PRACTICE", "MONEY", "MOVEMENT",
            "MOVEMENT_MAX", "HITROLL", "DAMROLL", "AC", "STR", "INT", "WIS", "DEX", "CON", "STR_PERM", "INT_PERM",
            "WIS_PERM", "DEX_PERM", "CON_PERM", "OPPONENT_HEALTH", "OPPONENT_HEALTH_MAX", "OPPONENT_LEVEL",
            "OPPONENT_NAME")
    end
end

registerAnonymousEventHandler("sysProtocolEnabled", initMSDP)

if not gaugesTable.healthBar then
    createGauge("healthBar", 400, 20, 1150, 875, nil, "green")
end
if not gaugesTable.manaBar then
    createGauge("manaBar", 400, 20, 1150, 855, nil, "blue")
end
if not gaugesTable.moveBar then
    createGauge("moveBar", 400, 20, 1150, 835, nil, "light_sky_blue")
end
