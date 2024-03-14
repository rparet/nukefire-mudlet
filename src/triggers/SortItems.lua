local bag1 = "willy"
local bag2 = "willy"
local bag3 = "willy"



function sortItems(item)
  if (isInEqTable(item)) then
    return
  end

  if item.short_description == nil then
    return
  end

  local keywords = {}
  for keyword in rex.split(item.short_description, " ") do
    table.insert(keywords, keyword)
  end
  lastKw = table.remove(keywords)
  if (item.item_type == "FOOD" or item.item_type == "DRUG"
        or item.item_type == "LIQ CONTAINER") then
    send("drop " .. lastKw)
  elseif (item.item_type == "ARMOR") then
    send("put " .. lastKw .. " " .. bag1)
  elseif (item.item_type == "WEAPON") then
    send("put " .. lastKw .. " " .. bag2)
  elseif (item.item_type == "WORN" or item.item_type == "TREASURE" or
        item.item_type == "WAND" or item.item_type == "POTION" or
        item.item_type == "STAFF") then
    send("put " .. lastKw .. " " .. bag3)
  end
end

if (string.find(multimatches[2].item, "credits")) then
  return
else
  sortItems(getItem(multimatches[2].item))
end
