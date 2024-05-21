function HealthHandler()
  if not msdp.HEALTH_MAX then
    return
  end

  local healthPercent = 100 * (msdp.HEALTH / msdp.HEALTH_MAX)
  hpBar:setValue(healthPercent, 100, "<b>" .. getProfileName() .. "</b>")
  raiseGlobalEvent("hp", healthPercent)
  if healthPercent <= 85 then
    if msdp.CLASS == "Curist" then
      raiseEvent("heal", healthPercent)
    else
      raiseGlobalEvent("heal", healthPercent)
    end
    if not hasFocus() then
      raiseGlobalEvent("damage")
    end
  end
end
