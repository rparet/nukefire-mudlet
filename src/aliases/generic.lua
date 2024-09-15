if msdp.CLASS == Nf.commandList[matches[2]].class then
    raiseEvent("genericCommand", matches[2], matches[3] or "")
else
    raiseGlobalEvent("genericCommand", matches[2], matches[3] or "")
end
