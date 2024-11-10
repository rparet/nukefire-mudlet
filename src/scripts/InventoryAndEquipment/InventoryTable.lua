function Nf.setInventory(description)
    local object = getItem(description)

    if next(object) == nil then return end

    local item = { description, object.item_type }

    if not Nf.inventory[object.item_type] then
        Nf.inventory[object.item_type] = {}
    end

    table.insert(Nf.inventory[object.item_type], description)
end

function Nf.sellInventory(type)
    if not Nf.inventory[type] then return end

    for k, v in pairs(Nf.inventory[type]) do
        local keywords = string.split(v, " ")
        if keywords then
            send("sell 100 " .. keywords[#keywords])
        end
    end
end

-- Add names of inscribed eq to inventory
function Nf.setInventoryInscribe(inscribe)
    if not Nf.inventory.inscribe then
        Nf.inventory.inscribe = {}
    end

    if not Nf.inventory.inscribe[inscribe] then
        Nf.inventory.inscribe[inscribe] = 1
    end
end
