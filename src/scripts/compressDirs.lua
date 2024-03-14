-- go from n;n;w;s to 2nws, etc.
function compressDirs(input)
    local result = "" -- This will hold the final string
    local count = 1 -- Initialize count of characters
    local length = #input -- Get the length of the input string
    local fmt = input:gsub(";", "")

    for i = 1, length do
        local char = fmt:sub(i, i)
        if char == ';' then
            -- Skip semicolons
        elseif i == length or (char ~= fmt:sub(i + 1, i + 1)) then
            -- If it's the end of the string or the next character is different,
            -- append the count (if > 1) and the character, then reset the count
            result = result .. (count > 1 and tostring(count) or '') .. char
            count = 1
        else
            -- If the current character is the same as the next, increment the count
            count = count + 1
        end
    end


    return result
end