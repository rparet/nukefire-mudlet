function HealthHandler()
  if not msdp.HEALTH_MAX then
    return
  end

  -- round down to whole #
  local healthPercent = math.ceil((100 * (msdp.HEALTH / msdp.HEALTH_MAX)) - .5)

  hpBar:setValue(healthPercent, 100, "<b>" .. getProfileName() .. " - " .. healthPercent .. "% </b>")
  raiseGlobalEvent("hp", healthPercent)
  if healthPercent <= 85 then
    if msdp.CLASS == "Curist" or msdp.CLASS == "Heretic" then
      raiseEvent("heal", healthPercent)
    else
      raiseGlobalEvent("heal", healthPercent)
    end
    if not hasFocus() then
      raiseGlobalEvent("damage")
    end
  end
end
