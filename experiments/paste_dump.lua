--------------------------------------------------------------

-- Defining the lua object and it's functions that manages the events.

--------------------------------------------------------------



local tp_event_key = {}; --# assume tp_event_key: EO --blank object

local event_table = {}--: vector<EO>--table holds object instances



--v function(event_key: string, event_character: string, event_region: string, event_pic: number, event_faction: string)--> EO

function tp_event_key.new(event_key, event_character, event_region, event_pic, event_faction)

    local self = {}

    setmetatable(self, {__index = tp_event_key});

    --# assume self: EO

    self.event_key = event_key;

    self.event_character = event_character;

    self.event_region = event_region;

    self.event_pic = event_pic;

    self.event_faction = event_faction;

    table.insert(event_table, self); --adds instance to holding table.

    out("LL_L: New event object entered: "..self.event_key);

    return self;

end;



--v function(self: EO)

function tp_event_key.listener_setup(self)

    -- Check to see if event has already occured.

    if cm:get_saved_value(self.event_key.."_occured") == true then

        out("LL_L: "..self.event_key.."has already occured");

        return; 

    end;

    out("LL_L: Listener set up for "..self.event_key);

    -- Creating listener

    core:add_listener(

        self.event_key,

        "CharacterTurnStart", 

        function(context) return (context:character():faction():is_human() and context:character():region():name() == self.event_region) end,

            function(context)

                local this_char_name = context:character():get_forename();

                out("LL_L: hopefully"..this_char_name.." is the same as "..self.event_character)



                if this_char_name == self.event_character then

                    out("LL_L: message going out for"..self.event_key);



                    cm:show_message_event(

                        self.event_faction,

                        "event_feed_strings_text_"..self.event_key.."_title", -- eg "Lore of Vlad"

                        "event_feed_strings_text_"..self.event_key.."_subtitle", -- eg "The Rebirth of Vashanesh"

                        "event_feed_strings_text_"..self.event_key.."_description", --eg "Vashanesh entered the city of Lahmia a man and left an undead monster of awesome"

                        true,

                        self.event_pic

                    );

                    cm:set_saved_value(self.event_key.."_occured", true); -- remembering that this event has occured.]]

                end;

            end,

        false

    );

end;



--------------------------------------------------------------

-- Creating each instance of the event object.

--------------------------------------------------------------

local vlad_lahmia = tp_event_key.new("vlad_lahmia","names_name_2147345130", "wh_main_eastern_sylvania_castle_drakenhof", 900, "wh_main_vmp_schwartzhafen");

--made the region drakenhof for testing needs to be reverted to Lahmia

function tp_start_listeners()

    for i=1, #event_table do

        local this_instance = event_table[i];

        out("LL_L: Initiating "..this_instance.event_key);

        this_instance:listener_setup();

    end;

end;



events.FirstTickAfterWorldCreated[#events.FirstTickAfterWorldCreated+1] = function()

    out("LL_L: Script Initiating");

	tp_start_listeners();

end;







-- script ends