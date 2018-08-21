---------------------------------------------------------------- 
---- Script Reaction by thesniperdevil--
---------------------------------------------------------------- 

-- This script demonstrates how you can detect other mod scripts and adapt your own scripts to reposnd to their presence.

-- Here I define a variable as nil. This will be redfined later.
local mod_checker_interface = nil;

---------------------------------------------------------------- 
-- Here I define the mod scripts I want to detect the trick here is to reference the lua script name - but exclude the .lua
local mod_1_mortal = "col_trade"; -- this is the script I use in Colonial Trade (col_trade.lua)
local mod_2_mortal = "tp_vas"; --this is a prefix I use for a number of scripts I have created as part of a vassal mechanic: tp_vas_effects.lua, tp_vas_ancillaries.lua and so on.

---------------------------------------------------------------- 
-- This is the function that activates the script It MUST be the same as your lua file name.. I'd recommend you use yourModName_reaction_script
function my_script_reactor()     
    mod_checker_interface = cm.get_game_interface(); -- we redefine this now because initially we cannot guarantee the game interface has been loaded.

    -- Getting a comma separated list of lua files in the main_warhammer/mod/ directory e.g. "col_trade, tp_vas_ancillaries, tp_vas_effects"
    local mod_list_mortal = mod_checker_interface:filesystem_lookup("/script/campaign/main_warhammer/mod/","*.lua");     

        
    if string.find(mod_list_mortal, mod_1_mortal) then -- Checks to see if the list of lua files contains "col_trade" 
        out("TEST: trade mod detected");
        --require(whatever script)
    end;     
    if string.find(mod_list_mortal, mod_2_mortal) then -- Checks to see if the list of lua files contains "tp_vas"    
        out("TEST: Vassal scripts detected");
        --require(whatever script) 
    end; 
end;