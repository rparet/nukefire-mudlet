if not Nf.inventory.inscribe then return end

for k, _ in pairs(Nf.inventory.inscribe) do
    if k == getProfileName() then return end
    send("give all." .. k .. " " .. k)
end
