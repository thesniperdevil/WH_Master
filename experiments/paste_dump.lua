function red_duke_anc_monitor()
    core:add_listener(
        "red_duke_anc_monitor",
        "CharacterTurnStart",
        function(context)
            return context:character():character_subtype("wh_dlc05_vmp_red_duke"); -- Return the Red Duke when his turn starts
        end,
        function(context)
            if context:character():has_ancillary("wh_main_anc_armour_armour_of_fortune") then -- Checks if Red Duke has the Armour of fortune ancillary
                cm:force_remove_ancillary(cm:char_lookup_str(context:character()), "wh_main_anc_armour_armour_of_fortune"); -- If he does, it is removed...
                core:remove_listener("red_duke_anc_monitor"); -- ...and the listener is removed
            end;
        end,
        false
    );
end;
