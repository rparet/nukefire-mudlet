-- master nf config command

local valid_options = { "primary", "bank", "attack" }
local valid_options_string = table.concat(valid_options, ", ")
local option = matches[2]
local value = matches[3]

if not table.contains(valid_options, option) then
    display("Tried to change a config value that does not exist: valid options are " .. valid_options_string)
    return
end

if option == "primary" then
    local val = (value and string.lower(value)) == "true" and true or false
    Nf.profile.primary = val
    Nf.msg("Primary set to: " .. tostring(val))
    Nf.save()
elseif option == "bank" then
    local val = (value and string.lower(value)) == "true" and true or false
    Nf.profile.bank = val
    Nf.msg("Is this character the bank set to: " .. tostring(val))
    Nf.save()
elseif option == "attack" then
    if not value then
        Nf.msg("Current attack: " .. Nf.profile.attack)
        return
    else
        Nf.profile.attack = value
        Nf.msg("Attack set to: " .. value)
        Nf.save()
    end
end
