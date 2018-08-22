require("stec_project/vassal_object");--will need to change this for pack file
require("stec_project/stec_archive/elector_appeasement");--will need to change this for pack file
eom = _G.eom 
---------------------------------------------------------------
--Setting up vassal table and entering in core empire vassals.
local empire_vassal_table = {}--: vector<VRM>

local hochland = vassal_object_manager.new("wh_main_emp_hochland", "wh_main_emp_empire", "wh_main_hochland", "tp_vas_anc_hochland", "wh_main_hochland_hergig", {"wh_main_hochland_hergig","wh_main_hochland_brass_keep"},580,512, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
table.insert(empire_vassal_table, hochland);
local averland = vassal_object_manager.new("wh_main_emp_averland", "wh_main_emp_empire", "wh_main_averland", "tp_vas_anc_averland","wh_main_averland_averheim", {"wh_main_averland_averheim","wh_main_averland_grenzstadt"}, 558, 438, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
table.insert(empire_vassal_table, averland);
local wissenland = vassal_object_manager.new( "wh_main_emp_wissenland", "wh_main_emp_empire", "wh_main_wissenland", "tp_vas_anc_wissenland","wh_main_wissenland_nuln", {"wh_main_wissenland_nuln","wh_main_wissenland_pfeildorf","wh_main_wissenland_wissenburg"}, 519, 408, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
table.insert(empire_vassal_table, wissenland);
local stirland = vassal_object_manager.new("wh_main_emp_stirland", "wh_main_emp_empire", "wh_main_stirland", "tp_vas_anc_stirland", "wh_main_stirland_wurtbad", {"wh_main_stirland_wurtbad","wh_main_stirland_the_moot"}, 565, 436, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
table.insert(empire_vassal_table, stirland);
local ostland = vassal_object_manager.new("wh_main_emp_ostland", "wh_main_emp_empire", "wh_main_ostland", "tp_vas_anc_ostland", "wh_main_ostland_wolfenburg", {"wh_main_ostland_wolfenburg","wh_main_ostland_norden"}, 600, 546, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
table.insert(empire_vassal_table, ostland);
local middenland = vassal_object_manager.new("wh_main_emp_middenland", "wh_main_emp_empire", "wh_main_middenland", "tp_vas_anc_middenland","wh_main_middenland_middenheim", {"wh_main_middenland_middenheim","wh_main_middenland_carroburg", "wh_main_middenland_weismund"}, 519, 516, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
table.insert(empire_vassal_table, middenland);
local nordland = vassal_object_manager.new("wh_main_emp_nordland", "wh_main_emp_empire", "wh_main_nordland", "tp_vas_anc_nordland", "wh_main_nordland_salzenmund", {"wh_main_nordland_salzenmund","wh_main_nordland_dietershafen"}, 519, 550, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
table.insert(empire_vassal_table, nordland);
local ostermark = vassal_object_manager.new("wh_main_emp_ostermark", "wh_main_emp_empire", "wh_main_ostermark", "tp_vas_anc_ostermark", "wh_main_ostermark_bechafen", {"wh_main_ostermark_bechafen","wh_main_ostermark_essen"}, 650, 516, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
table.insert(empire_vassal_table, ostermark);
local talabecland = vassal_object_manager.new("wh_main_emp_talabecland", "wh_main_emp_empire", "wh_main_talabecland", "tp_vas_anc_talabecland", "wh_main_talabecland_talabheim", {"wh_main_talabecland_talabheim","wh_main_talabecland_kemperbad"}, 590, 486, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
table.insert(empire_vassal_table, talabecland);
local reikland = vassal_object_manager.new("wh_main_emp_empire", "wh_main_emp_empire", "wh_main_reikland", "nil", "wh_main_reikland_altdorf", {"wh_main_reikland_altdorf","wh_main_reikland_eilhart", "wh_main_reikland_helmgart", "wh_main_reikland_grunburg"}, 486, 438, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
table.insert(empire_vassal_table, reikland);
-- note Reikland is the overlord, but is added to ensure reikland provinces can be managed in case vassals control them!

--FUNCTIONS

---------------------------------------------------------------
--  LISTENER FUNCTIONS

-- Listener adds ancillary to characters on turn start assuming objectives are compelted.
function vassal_ancillary_listener()
	core:add_listener(
		"ancillary_listener",
		"CharacterTurnStart", 
		function(context) return context:character():faction():name() == "wh_main_emp_empire" end,
        function(context)
                local current_province = context:character():region():province_name();
                local char_str = cm:char_lookup_str(context:character())

			for i=1, #empire_vassal_table do
                local temp = empire_vassal_table[i];
                local temp_province = temp.vassal_province;
                local temp_ancillary = temp.ancillary_name;
                

                if temp:condition_check() and (current_province == temp_province) then
                    
                    if not context:character():has_ancillary(temp_ancillary) then
                        cm:force_add_and_equip_ancillary(char_str, temp_ancillary);
                    end;

                end;
                
			end;	
		end,
	true
	);
end;

--Listener changes ownership of settlment if conditions are met on sacking.
function vassal_sack_listener()
    core:add_listener(
		"sack_listener_emp",
		"CharacterSackedSettlement", 
		function(context) return context:character():faction():name() == "wh_main_emp_empire" end,
		function(context)
            local this_region = context:character():region():name();
                        
            for i = 1, #empire_vassal_table do
			
				if empire_vassal_table[i]:region_list(this_region) then
                    local vassal_name = empire_vassal_table[i].vassal_name;

                    cm:transfer_region_to_faction(this_region, vassal_name);

                    if eom then
                        eom:get_elector(vassal_name):change_loyalty(10)
                    end

				end;
			end;
		end,
	true
	);
end;

-- Listener ammends the vassal effect on faction turn start assuming objectives are completed. (calls a function defined under OTHER FUNCTIONS)
function vassal_effect_listener()
    core:add_listener(
        "overlord_emp_turn",
        "FactionTurnStart",
        function(context) return context:faction():is_human() end,
        function(context)
            local counter = 0
            local this_faction = context:faction():name();
                
            for i =1, #empire_vassal_table do 
                local temp = empire_vassal_table[i];
               
                    if temp:condition_check() then
                        counter = counter + 1
                    end;
            end;
            
            tp_emp_effect_manager(counter, this_faction);
           
        end,
    true);
end;

-- Listener for the two region dilemmas. Will gift all regions to rightful owners depending on who owns them. Will also ressurect factions if they are dead.
function stec_dilemma_listener()
    core:add_listener(
        "stec_dilemma_listener",
        "DilemmaChoiceMadeEvent", 
        function(context) return (context:dilemma() == "vas_reg_main_emp_respect_borders" and context:choice() == 0) or (context:dilemma() == "vas_reg_main_emp_vassal_respect" and context:choice() == 0) end, 
        function(context)
            local temp_bool = true
            
            if context:dilemma() == "vas_reg_main_emp_respect_borders" then
                temp_bool = true
            elseif context:dilemma() == "vas_reg_main_emp_vassal_respect" then
                temp_bool = false
            end;
            
            for i=1, #empire_vassal_table do
                if empire_vassal_table[i]:emergence_check(temp_bool) then
                    empire_vassal_table[i]:emerging_army();
                end;
                cm:callback(function() empire_vassal_table[i]:region_transfer(temp_bool); end, 0.5); --callback gives time for army to spawn before region transfers.
            end;
    
        end,
        true
    );
end;

-- Dilemma countdown currently set to get 2 dilemmas every 20 turns!
function stec_dielmma_trigger()
    local dilemma_countdown = 20;

    core:add_listener(
        "countdown_FactionTurnStart",
        "FactionTurnStart",
        function(context)
            return context:faction():name() == "wh_main_emp_empire"; --overlord faction
        end,
        function(context)
        
            dilemma_countdown = dilemma_countdown - 1;
            
            if dilemma_countdown <= 0 then
                dilemma_countdown = 20;
                return;
            elseif dilemma_countdown == 15 then
                cm:trigger_dilemma("wh_main_emp_empire", "vas_reg_main_emp_respect_borders", true);
            elseif dilemma_countdown == 5 then
                cm:trigger_dilemma("wh_main_emp_empire", "vas_reg_main_emp_vassal_respect", true);
            end;
        end,
        true
    );
end;

-- function for use with EOM - forces vassaling when someone is at max loyalty at the satrt of Empire turn.
function force_make_vassal()
    core:add_listener(
    "EOM_loyalty_listener", 
    "FactionTurnStart", 
    function(context) return context:faction():name() == "wh_main_emp_empire" end, 
        function(context) 
            for i=1, #empire_vassal_table do
                local this_vassal = empire_vassal_table[i].vassal_name;
                --local this_is_vassal = empire_vassal_table[i].is_vassal_of("wh_main_emp_empire");
            
                if eom:get_elector(this_vassal):loyalty() > 99 and eom:get_elector(this_vassal):status() == "normal" then
                    cm:force_make_vassal("wh_main_emp_empire",this_vassal);
                --else ifeom:get_elector(this_vassal):loyalty() < 10 and this_is_vassal then
                    --do somehting to make vassal secceed.
                end;
            end;
        end, 
        true
    );
end;


--This Listener is EOM dependent - checks to see if Vlad is an elector - if so, adds a new record to the table, else (if sylvania isnt an elector) creates a listener for the dilemma that can make Vlad official.
function stec_vlad_listener()
        if eom:get_elector("wh_main_vmp_schwartzhafen"):status() == "normal" then
            table.insert(empire_vassal_table, stec_vampire);
        elseif eom:get_elector("wh_main_emp_sylvania"):status() ~= "normal" then
            core:add_listener(
                "EOM_vlad_listener", 
                "DilemmaChoiceMade", 
                function(context) return (context:dilemma() == "eom_vampire_war_4" and context:choice() == 0) end, 
                function(context) 
                    table.insert(empire_vassal_table, stec_vampire);
                end, 
                false
            );
        end;
end;
    
-- This listener is EOM deendant - checks to see if Sylvania is an official elector - if so, adds a new record to the table, else (if vlad isnt an elector) creates a listner for the dilemma that can make Sylvania official.
function stec_sylvania_listener()
        if eom:get_elector("wh_main_emp_sylvania"):status() == "normal" then
            table.insert(empire_vassal_table, stec_sylvania);
        elseif eom:get_elector("wh_main_vmp_schwartzhafen"):status() ~= "normal" then
        core:add_listener(
            "EOM_sylvania_listener", 
            "DilemmaChoiceMade", 
            function(context) return (context:dilemma() == "eom_vampire_war_5" and context:choice() == 1) end, 
            function(context) 
                table.insert(empire_vassal_table, stec_sylvania);           
            end, 
            false
        );
        end;
end;

-- This listener is EOM deendant - checks to see if Marienburg is an official elector - if so, adds a new record to the table, else creates a listner for the dilemma that can make Marienburg official.
--NEED DILEMMA NAME AND CHOICE
function stec_marienburg_listener()
    if eom:get_elector("wh_main_emp_marienburg"):status() == "normal" then
        table.insert(empire_vassal_table, stec_marienburg);
    else
        core:add_listener(
            "EOM_marienburg_listener", 
            "DilemmaChoiceMade", 
            function(context) return (context:dilemma() == "xxxxxxxxxxxxxxxx" and context:choice() == 1) end, 
            function(context) 
                table.insert(empire_vassal_table, stec_marienburg);           
            end, 
            false
        );
    end;
end;

---------------------------------------------------------------
--  OTHER FUNCTIONS

--This function manages vassal effects, it will always remove the current level effect and apply the most up to date version.
    --v function(counter: integer, overlord: string)
    function tp_emp_effect_manager(counter, overlord)
    -- Stores the effect levels. Currently capped at 10 vassals. To change this, add more effect levels and remove the this_counter check below.
    local tp_emp_effects = {
        "vas_eff_emp_effect_1",
        "vas_eff_emp_effect_2",
        "vas_eff_emp_effect_3",
        "vas_eff_emp_effect_4",
        "vas_eff_emp_effect_5",
        "vas_eff_emp_effect_6", 
        "vas_eff_emp_effect_7",
        "vas_eff_emp_effect_8",
        "vas_eff_emp_effect_9",
        "vas_eff_emp_effect_10"
    }--:vector<string>
    --this makes sure any additional vassals from EOM dont kill this mod.
    local this_counter = tonumber(counter);--# assume this_counter: integer
    if this_counter > 10 then this_counter = 10 end; 
        
    local new_effect = tp_emp_effects[this_counter];
    --Removes all current effects.
    for i = 1, #tp_emp_effects do
        local this_effect = tp_emp_effects[i];
        cm:remove_effect_bundle(this_effect, overlord);
    end;
    --then applies the correct level of effect.	
    cm:apply_effect_bundle(new_effect, overlord,0);
end;

---------------------------------------------------------------
-- Function intitiates mod - detects for Empire of Man.
function stec_master()

    -- listeners that always run go here.
    cm:force_diplomacy("culture:wh_main_emp_empire", "culture:wh_main_emp_empire", "vassal", true, true, false); --allows Empire to vassal other empire provinces
    vassal_ancillary_listener();
    vassal_sack_listener();

    -- This detects for "Empire OF Man" Mod by Drunbk Flamingo. If that mod is present this mod will adapt and become a submod.
    if eom then
        eom:set_core_data("tweaker_no_full_loyalty_events", true); --disables EOM confederating stuff.
        force_make_vassal();
         stec_marienburg = vassal_object_manager.new("wh_main_emp_marienburg", "wh_main_emp_empire", "wh_main_the_wasteland", "xxx", "wh_main_the_wasteland_marienburg", {"wh_main_the_wasteland_gorssel", "wh_main_the_wasteland_marienburg"},000,000, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
         stec_sylvania = vassal_object_manager.new("wh_main_emp_sylvania", "wh_main_emp_empire", "wh_main_western_sylvania", "xxx", "wh_main_western_sylvania_castle_templehof", {"wh_main_western_sylvania_castle_templehof", "wh_main_western_sylvania_fort_oberstyre","wh_main_western_sylvania_schwartzhafen", "wh_main_eastern_sylvania_castle_drakenhof","wh_main_eastern_sylvania_eschen","wh_main_eastern_sylvania_waldenhof"}, 000, 000, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
         stec_vampire = vassal_object_manager.new("wh_main_vmp_schwartzhafen","wh_main_emp_empire", "wh_main_eastern_sylvania", "xxx", "wh_main_eastern_sylvania_castle_frakenhof", {"wh_main_western_sylvania_castle_templehof", "wh_main_western_sylvania_fort_oberstyre","wh_main_western_sylvania_schwartzhafen", "wh_main_eastern_sylvania_castle_drakenhof","wh_main_eastern_sylvania_eschen","wh_main_eastern_sylvania_waldenhof"}, 000, 000,"wh_main_emp_art_mortar,wh_main_vmp_inf_grave_guard_1,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_cav_black_knights_0,wh_main_vmp_mon_dire_wolves,wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_fell_bats");
        -- need to get XY co-ords for new factions. Create ancillary too.
       
        stec_vlad_listener();
        stec_sylvania_listener();

-- If no EOM then do this.
    else
        elector_appeasement_listeners()
    end;
end;



--TO DO
-- get the kailua definitions for EOM lua stuff.
--creation of new ancillaries for vlad/ sylvania/ marienburg
--testing uughghghghghghghg