db:create("nukefire_items", {
       items = {
              vnum = 0,
              player_name = "",
              item_type = "",
              short_description = "",
              abilities = "",
              worn_locations = "",
              extra_flags = "",
              weight = 0,
              retail_value = 0,
              rent = 0,
              min_remorts = 0,
              ac_apply = 0,
              damage_dice = "",
              average_damage = 0,
              affects = "",
              timestamp = ""
       }
})

Nf.db = db:create("characters", {
       characters = {
              name = "",
              type = "",
              short_name = "",
              _unique = { "name" },
              _violations = "IGNORE"
       }

})
