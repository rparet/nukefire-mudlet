function OpponentHandler(event)
    if event == "msdp.OPPONENT_LEVEL" then
        local level = tonumber(msdp.OPPONENT_LEVEL)
        if level > 0 then
            display("[Notice] Combat entered")
        else
            display("[Notice] Combat ended")
        end
    end
end
