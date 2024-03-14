function HealthHandler()
  local healthPercent = 100 * (msdp.HEALTH / msdp.HEALTH_MAX)
  setGauge("healthBar", healthPercent, 100)
  if healthPercent <= 80 then
    raiseGlobalEvent("heal", healthPercent)
    if not hasFocus() then
      raiseGlobalEvent("damage")
    end
  end
end
