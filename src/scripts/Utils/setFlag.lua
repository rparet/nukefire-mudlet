function Nf.setFlag(flag, value)
    Nf.flags[flag] = value
    if not hasFocus() then
        raiseGlobalEvent("setflag", flag, value)
    end
end
