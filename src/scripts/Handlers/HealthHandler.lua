function HealthHandler()
 healthPercent = 100 * (msdp.HEALTH / msdp.HEALTH_MAX)
 setGauge("healthBar", healthPercent, 100)
 if healthPercent <= 80 then
   raiseGlobalEvent("heal", healthPercent) 
 end
end