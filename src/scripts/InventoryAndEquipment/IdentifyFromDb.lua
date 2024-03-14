function showItem(obj)
  if next(obj) == nil then
    cecho("HelloWorld", "Object not found")
    return
  end
  cecho("HelloWorld", "\n"..obj.short_description.." "..obj.abilities.."Weight: "..obj.weight.." Value: "..obj.retail_value.."")
  if obj.damage_dice ~= "" then
   cecho("HelloWorld", "\nDamage dice: "..obj.damage_dice.."")
   cecho("HelloWorld", "\nAverage damage: "..obj.average_damage.."")
  end
  cecho("HelloWorld", "\n"..obj.affects.."")
  cecho("HelloWorld", "\nExtra: "..obj.extra_flags)
  cecho("HelloWorld", "\nType: "..obj.item_type.." Worn: "..obj.worn_locations.."")
  cecho("HelloWorld", " Ac-apply: "..obj.ac_apply.."")
  cecho("HelloWorld", "\nMin remorts: "..obj.min_remorts.."")
  cecho("HelloWorld", "\r\n")
end

-- getItem, db helper function
function getItem(description)
  local query = description
  local mydb = db:get_database("tdome")
  local results = db:fetch(mydb.tdome, db:eq(mydb.tdome.short_description,query))
  return results[1] or {}
end

function compare(obj)
 -- remove TAKE from string
 local worn = string.gsub(obj.worn_locations, "^TAKE%s*(.-)%s*$", "%1")
 local wornItems = getEquipmentByPosition(worn)
 if next(wornItems) ~= nil then
   cecho("HelloWorld", "\n<blue>By comparison, you're wearing:\n") 
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
  cecho("HelloWorld", "\n<blue>Identifying "..description.."...\n")
  local item = getItem(description)
  showItem(item)
  if item.worn ~= "" and item.item_type ~= "IMPLANT" then
    compare(item)
  end
end