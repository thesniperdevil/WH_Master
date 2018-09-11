--------------------------------------------------------------
-- Defining the lua object and it's functions that manages the events.
--------------------------------------------------------------

local tp_event_key = {}; --blank object
local event_table = {}; --table holds object instances

function tp_event_key.new(event_key, event_character, event_region, event_pic, event_faction)
    local self = {}
    setmetatable(self, {__index = tp_event_key});
    --# assume self: VRM
    self.event_key = event_key;
    self.event_character = event_character;
    self.event_region = event_region;
    self.event_pic = event_pic;
    self.event_faction = event_faction;
    table.insert(event_table, self); --adds instance to holding table.
    out("LL_L: New event object entered: "..self.event_key);
    return self;
end;


function tp_event_key.listener_setup(self)
    -- Check to see if event has already occured.
    if get_saved_value(self.event_key.."_occured") == true then
        out("LL_L: "..self.event_key.."has already occured");
        return; 
    end;
    -- Creating listener
    core:add_listener(
        self.event_key,
        "CharacterTurnStart",
        function(context) return (context:character():get_forname() == self.event_character and context:character():region():name() == self.event_region) end,
            function(context) 
                cm:show_message_event(
                    self.event_faction,
                    "event_feed_strings_text_title_event"..self.event_key,
                    "event_feed_strings_text_sub_title_event"..self.event_key,
                    "event_feed_strings_text_description_event"..self.event_key,
                    true,
                    self.event_pic
                );
                cm:set_saved_value(self.event_key.."_occured", true);
            end,
        true
    );
end;

--------------------------------------------------------------
-- Creating each instance of the event object.
--------------------------------------------------------------
local vlad_kislev = tp_event_key.new("vlad_lamia","names_name_2147345130", "wh2_main_devils_backbone_lahmia", 591, "wh_main_vmp_schwartzhafen");


function tp_start_listeners()
    for i=1, #event_table do
        local this_instance = event_table[i];
        this_instance:listener_setup();
    end;
end;

events.FirstTickAfterWorldCreated[#events.FirstTickAfterWorldCreated+1] = function()
	tp_start_listeners();
end;



-- script ends
