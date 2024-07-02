function eventShapeshift(_, profileName)
    if profileName then
        display("Caught event shapeshift from " .. profileName)
        send("sling 'shapeshift' " .. profileName)
    else
        send("sling 'shapeshift'")
    end
end
