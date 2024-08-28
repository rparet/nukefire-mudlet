function gagLine(originalLine)
    if getCurrentLine() == originalLine then
        deleteLine()
    end
end

gag = getCurrentLine()
tempLineTrigger(1, 1, function() gagLine(gag) end)
