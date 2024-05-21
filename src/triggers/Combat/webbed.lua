if string.match(matches[1], "STUCK") then
    -- send("gt Webbed")
elseif string.match(matches[1], "dissolves") then
    send("gt Unwebbed")
end
