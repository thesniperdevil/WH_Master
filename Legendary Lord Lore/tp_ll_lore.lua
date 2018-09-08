
-- originally Vashanesh
-- turned to vamprisim in Lahmia
--Went to Kislev to learn how to control the ring from Nagash - took up the name Vladamir.
--went to Sylvania (he original saw this palce as a warrior in Seteps legions)
--in Sylvania came as prince vladamir and helped fight skaven during the black death.
-- maried Isabella in castle Drakenhof.
--siege of Altdorf.
core:add_listener(
    "vlad_kislev",

    "CharacterTurnStart",

    function(context) return context:character():get_forname() == VLAD_NAME and context:character():region():name() == VLAD_KISLEV end,
    
    function(context) 
        cm:show_message_event(
            VLAD_FACTION,
            "event_feed_strings_text_stec_event_feed_string_scripted_event_hochland_appeased_primary_detail",
            "event_feed_strings_text_stec_event_feed_string_scripted_event_hochland_appeased_secondary_detail",
            "event_feed_strings_text_stec_event_feed_string_scripted_event_hochland_appeased_flavour_text",
            true,
            591
        );
    end,
    
    true
);