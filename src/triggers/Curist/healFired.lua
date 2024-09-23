if (msdp.CLASS == "Heretic" or msdp.CLASS == "Curist") and Nf.flags.heal == true then
    Nf.msg("Heal fired successfully")
    Nf.setFlag("heal", false)
end
