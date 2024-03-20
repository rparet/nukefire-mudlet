function sysSendOneProfile(_, text)
    local words = {}
    words[1], words[2] = text:match("(%w+)(.+)")
    local targetProfile = words[1]
    local command = words[2]
    -- strip leading and trailing whitespace
    command = string.gsub(command, '^%s*(.-)%s*$', '%1')
    if string.match(getProfileName(), "^" .. targetProfile .. "%w*") then
        expandAlias(command)
    end
end
