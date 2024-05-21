function showItem(obj)
  if next(obj) == nil then
    cecho("NfConsole", "Object not found")
    return
  end
  cecho("NfConsole",
    "\n" .. obj.short_description .. " " .. obj.abilities .. "Weight: " .. obj.weight .. " Value: " ..
    obj.retail_value .. "")
  if obj.damage_dice ~= "" then
    cecho("NfConsole", "\nDamage dice: " .. obj.damage_dice .. "")
    cecho("NfConsole", "\nAverage damage: " .. obj.average_damage .. "")
  end
  cecho("NfConsole", "\n" .. obj.affects .. "")
  cecho("NfConsole", "\nExtra: " .. obj.extra_flags)
  cecho("NfConsole", "\nType: " .. obj.item_type .. " Worn: " .. obj.worn_locations .. "")
  cecho("NfConsole", " Ac-apply: " .. obj.ac_apply .. "")
  cecho("NfConsole", "\nMin remorts: " .. obj.min_remorts .. "")
  cecho("NfConsole", "\r\n")
end

-- getItem, db helper function
function getItem(description)
  local query = description
  local mydb = db:get_database("nukefireitems")
  local results = db:fetch(mydb.items, db:eq(mydb.items.short_description, query))
  return results[1] or {}
end

function compare(obj)
  -- remove TAKE from string
  local worn = string.gsub(obj.worn_locations, "^TAKE%s*(.-)%s*$", "%1")
  local wornItems = getEquipmentByPosition(worn)
  if next(wornItems) ~= nil then
    cecho("NfConsole", "\n<blue>By comparison, you're wearing:\n")
    for _, description in ipairs(wornItems) do
      -- don't show if you are comparing the same items
      if description ~= obj.description then
        local item = getItem(description)
        showItem(item)
      end
    end
  end
end

-- fetchItem is what triggers use to get items from the game
function fetchItem(description)
  cecho("NfConsole", "\n<blue>Identifying " .. description .. "...\n")
  local item = getItem(description)
  showItem(item)
  if item.worn ~= "" and item.item_type ~= "IMPLANT" then
    compare(item)
  end
end
