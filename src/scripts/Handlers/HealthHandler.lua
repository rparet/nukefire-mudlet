function HealthHandler()
  if not msdp.HEALTH_MAX then
    return
  end

  local healthPercent = 100 * (msdp.HEALTH / msdp.HEALTH_MAX)
  hpBar:setValue(healthPercent, 100)
  if healthPercent <= 80 then
    raiseGlobalEvent("heal", healthPercent)
    if not hasFocus() then
      raiseGlobalEvent("damage")
    end
  end
end
