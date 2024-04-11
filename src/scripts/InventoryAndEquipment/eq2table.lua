eqTable = {}
eqPositionTable = {
    ["<encircling body>"] = "ENCIRCLING",
    ["<overshield>"] = "OVERSHIELD",
    ["<accessory>"] = "ACCESSORY",
    ["<affixed to armor>"] = "AFFIX",
    ["<buckled on left knee>"] = "KNEE",
    ["<buckled on right knee>"] = "KNEE",
    ["<hung on waist>"] = "HUNG",
    ["<pierced labret>"] = "PIERCING",
    ["<pierced right eyebrow>"] = "PIERCING",
    ["<pierced left brow>"] = "PIERCING",
    ["<pierced left earlobe>"] = "PIERCING",
    ["<wielded>"] = "WIELD",
    ["<worn about body>"] = "ABOUT",
    ["<worn about waist>"] = "WAIST",
    ["<worn around neck>"] = "NECK",
    ["<worn around wrist>"] = "WRIST",
    ["<worn as shield>"] = "SHIELD",
    ["<worn in left ear>"] = "EAR",
    ["<worn in right ear>"] = "EAR",
    ["<worn on arms>"] = "ARMS",
    ["<worn on back>"] = "BACK",
    ["<worn on body>"] = "BODY",
    ["<worn on face>"] = "FACE",
    ["<worn on feet>"] = "FEET",
    ["<worn on finger>"] = "FINGER",
    ["<worn on hands>"] = "HANDS",
    ["<worn on head>"] = "HEAD",
    ["<worn on legs>"] = "LEGS",
    ["<dual wielded>"] = "DUAL_WIELD",
    ["<used as light>"] = "LIGHT",
    ["<pierced lower lip>"] = "PIERCING",
    ["<pierced nose>"] = "PIERCING",
    ["<pierced septum>"] = "PIERCING",
    ["<pierced right nostril>"] = "PIERCING",
    ["<adorned to headwear>"] = "ADORNED",
    ["<strapped to right shoulder>"] = "SHOULDER",
    ["<strapped to left shoulder>"] = "SHOULDER",
    ["<worn on thumb>"] = "THUMB",
    ["<riding>"] = "RIDING"
}

-- Initialize the secondary index for positions
eqPositionIndex = {}

-- Function to add equipment to the table and update the position index
function eq2table(position, description)
    local wornPosition = eqPositionTable[position]
    -- Add or update the main equipment table
    eqTable[description] = wornPosition

    -- Update the secondary index
    if not eqPositionIndex[wornPosition] then
        eqPositionIndex[wornPosition] = {}
    end
    table.insert(eqPositionIndex[wornPosition], description)
end

-- Function to get all equipment by a specific position
function getEquipmentByPosition(position)
    return eqPositionIndex[position] or {}
end
