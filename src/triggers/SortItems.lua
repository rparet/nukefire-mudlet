Nf.profile.bag = Nf.profile.bag or {}
local bag1 = Nf.profile.bag.one or "bag"
local bag2 = Nf.profile.bag.two or "bag"
local bag3 = Nf.profile.bag.three or "bag"



function Nf.sortItems(item, multibag)
  if (isInEqTable(item)) then
    return
  end

  if item.short_description == nil then
    return
  end

  local keywords = string.split(item.short_description, " ")
  -- for keyword in rex.split(item.short_description, " ") do
  --   table.insert(keywords, keyword)
  -- end
  -- lastKw = table.remove(keywords)

  if not keywords then return end

  if (item.item_type == "FOOD" or item.item_type == "DRUG"
        or item.item_type == "LIQ CONTAINER") then
    send("drop " .. keywords[#keywords])
  end

  if item.item_type == "KEY" then
    send("give " .. keywords[#keywords] .. " " .. Group[1])
  end

  if multibag then
    if (item.item_type == "ARMOR") then
      send("put " .. keywords[#keywords] .. " " .. bag1)
    elseif (item.item_type == "WEAPON") then
      send("put " .. keywords[#keywords] .. " " .. bag2)
    elseif (item.item_type == "WORN" or item.item_type == "TREASURE" or
          item.item_type == "WAND" or item.item_type == "POTION" or
          item.item_type == "STAFF") then
      send("put " .. keywords[#keywords] .. " " .. bag3)
    end
  else -- just stick everything in 1 treasure bag
    send("put " .. keywords[#keywords] .. " " .. bag2)
  end
end

if (string.find(multimatches[2].item, "credits")) then
  return
else
  Nf.sortItems(getItem(multimatches[2].item), false)
end
