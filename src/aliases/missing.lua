Nf.triggers.missing = tempRegexTrigger(
    "^You are wearing (\\d+) out of (\\d+) possible slots.",
    function()
        raiseEvent("missing", matches[2])
        raiseGlobalEvent("missing", matches[2])
    end, 1)
send("missing")
