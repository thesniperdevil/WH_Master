-------------------------------------------------------------------------------
-----------Summon the Elector Counts Mod - by theSniperDevil-------------------
-------------------------------------------------------------------------------
--this script deals with appeasing the counts.


local STEC_FACTIONEMPIRE = "wh_main_emp_empire"

local AVER_APPEASED = false; --# assume AVER_APPEASED: boolean
local HOCH_APPEASED = false; --# assume HOCH_APPEASED: boolean
local MID_APPEASED = false; --# assume MID_APPEASED: boolean
local NORD_APPEASED = false; --# assume NORD_APPEASED: boolean
local OSTER_APPEASED = false; --# assume OSTER_APPEASED: boolean
local OST_APPEASED = false; --# assume OST_APPEASED: boolean
local STIR_APPEASED = false; --# assume STIR_APPEASED: boolean
local TAL_APPEASED = false; --# assume TAL_APPEASED: boolean
local WIS_APPEASED = false; --# assume WIS_APPEASED: boolean
		

function elector_appeasement_listeners()
	
-------------------------------------------------------------------------------
-- on FACTION TURN END for Empire, check to see what Empire factions have died and change appeasement back to true (in preparation for possible faction resurrection).


	core:add_listener(
	"factionChecker",
	"FactionTurnEnd",
	function(context) return context:faction():name() == STEC_FACTIONEMPIRE end,
	function(context)
	
			local factionTal = cm:model():world():faction_by_key("wh_main_emp_talabecland");
			local factionWis = cm:model():world():faction_by_key("wh_main_emp_wissenland");
			local factionOst = cm:model():world():faction_by_key("wh_main_emp_ostland");
			local factionMid = cm:model():world():faction_by_key("wh_main_emp_middenland");
			local factionStir = cm:model():world():faction_by_key("wh_main_emp_stirland");
			local factionOster = cm:model():world():faction_by_key("wh_main_emp_ostermark");
			local factionNord = cm:model():world():faction_by_key("wh_main_emp_nordland");		
			local factionHoch = cm:model():world():faction_by_key("wh_main_emp_hochland");
			local factionAver = cm:model():world():faction_by_key("wh_main_emp_averland");
			out("STEC:TURN END: Checking to see if there are any dead factions");
		
		if factionTal:is_dead() == true then
			TAL_APPEASED = false;
			out("STEC: Talabecland is dead - it's no longer appeased");
		end
		if factionWis:is_dead() == true then
			WIS_APPEASED = false;
			out("STEC: Wissenland is dead - it's no longer appeased");		
		end
		if factionOst:is_dead() == true then
			OST_APPEASED = false;
			out("STEC: Ostland is dead - it's no longer appeased");
		end
		if factionMid:is_dead() == true then
			MID_APPEASED = false;
			out("STEC: Middenland is dead - it's no longer appeased");
		end
		if factionStir:is_dead() == true then
			STIR_APPEASED = false;
			out("STEC: Stirland is dead - it's no longer appeased");
		end
		if factionOster:is_dead() == true then
			OSTER_APPEASED = false;
			out("STEC: Ostermark is dead - it's no longer appeased");
		end
		if factionNord:is_dead() == true then
			NORD_APPEASED = false;
			out("STEC: Nordland is dead - it's no longer appeased");
		end
		if factionHoch:is_dead() == true then
			HOCH_APPEASED = false;
			out("STEC: Hochland is dead - it's no longer appeased");
		end
		if factionAver:is_dead() == true then
			AVER_APPEASED = false;
			out("STEC: Averland is dead - it's no longer appeased");
		end
	end,
	true
	);


-------------------------------------------------------------------------------
-- function monitors for empire occupation of entire Reikland.

	core:add_listener(
		"empire_occupy_reikland_monitor",
		"GarrisonOccupiedEvent",
		function(context) return context:character():region():province_name() == "wh_main_reikland"
		end,
		function(context)
			out("STEC OCCUPIED EVENT: reikland has been occupied - checks occur")
			local char = context:character();
								
			if  char:faction():name() == STEC_FACTIONEMPIRE	and cm:get_faction(STEC_FACTIONEMPIRE):holds_entire_province("wh_main_reikland", true) then -- if character occupying is empire & they own all of reikland.
				cm:show_message_event(
					STEC_FACTIONEMPIRE,
					"event_feed_strings_text_stec_event_feed_string_scripted_event_reikland_unified_primary_detail",
					"event_feed_strings_text_stec_event_feed_string_scripted_event_reikland_unified_secondary_detail",
					"event_feed_strings_text_stec_event_feed_string_scripted_event_reikland_unified_flavour_text",
					true,
					591
				);
				out("STEC: Reikland is unified - message presented")
			end;
		end,
	false
	);
		

-------------------------------------------------------------------------------
-- Start of FACTION TURN checks for divine sanction technology STIRLAND -- for testing use "tech_emp_barracks_1" in place of "tech_emp_worship_2"


	core:add_listener(
	"reasearchCheckTwo",
	"FactionTurnStart",
	function(context) return context:faction():name() == STEC_FACTIONEMPIRE and STIR_APPEASED == false end,
	function(context)
	
		local stirAlive = cm:model():world():faction_by_key("wh_main_emp_stirland");
		out("STEC: TURN START IS STIRLAND DEAD? "..tostring(stirAlive:is_dead()).."checking for worship research")
		
		if stirAlive:is_dead() == false and context:faction():has_technology("tech_emp_worship_2") then
		
			cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_stirland");
			cm:show_message_event(
			STEC_FACTIONEMPIRE,
			"event_feed_strings_text_stec_event_feed_string_scripted_event_stirland_appeased_primary_detail",
			"event_feed_strings_text_stec_event_feed_string_scripted_event_stirland_appeased_secondary_detail",
			"event_feed_strings_text_stec_event_feed_string_scripted_event_stirland_appeased_flavour_text",
			true,
			591
		);
		STIR_APPEASED = true;
		out("STEC: STIRLAND APPEASED "..tostring(STIR_APPEASED))
		end;
	end,
	true
	);


-------------------------------------------------------------------------------
-- Start of FACTION TURN checks for Sea Charts technology NORDLAND -- for testing use "tech_emp_barracks_1" in place of "tech_emp_port_3"


	core:add_listener(
	"reasearchCheck",
	"FactionTurnStart",
	function(context) return context:faction():name() == STEC_FACTIONEMPIRE and NORD_APPEASED == false end,
	function(context)
	
		local nordAlive = cm:model():world():faction_by_key("wh_main_emp_nordland");
		out("STEC: TURN START IS NORDLAND DEAD? "..tostring(nordAlive:is_dead()).."checking for sea charts research")
		
		if nordAlive:is_dead() == false and context:faction():has_technology("tech_emp_port_3") then
			cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_nordland");
			cm:show_message_event(
			STEC_FACTIONEMPIRE,
			"event_feed_strings_text_stec_event_feed_string_scripted_event_nordland_appeased_primary_detail",
			"event_feed_strings_text_stec_event_feed_string_scripted_event_nordland_appeased_secondary_detail",
			"event_feed_strings_text_stec_event_feed_string_scripted_event_nordland_appeased_flavour_text",
			true,
			591
		);
		NORD_APPEASED = true;
		out("STEC: NORDLAND APPEASED, varaible is "..tostring(NORD_APPEASED))
		end;
	end,
	true
	);


-------------------------------------------------------------------------------
-- After a BATTLE END, checks if empire LL defeated the beastmen. HOCHLAND -- for testing use "wh_main_sc_emp_empire" instead of "wh_dlc03_sc_bst_beastmen"


	core:add_listener(
		"hochland_appease",
		"CharacterCompletedBattle",
		function(context) return context:character():faction():name() == STEC_FACTIONEMPIRE and context:character():has_military_force() == true and context:pending_battle():defender():faction():subculture() == "wh_dlc03_sc_bst_beastmen" end,

		function(context)
		
			local hochAlive = cm:model():world():faction_by_key("wh_main_emp_hochland");
			local char = context:character()
			out("STEC: BATTLE COMPLETE IS HOCHLAND DEAD? "..tostring(hochAlive:is_dead()).."checking for LL")
			
			if (char:get_forename() == "names_name_2147343849" or char:get_forename() == "names_name_2147343922" or char:get_forename() == "names_name_2147358013") and HOCH_APPEASED == false and hochAlive:is_dead() == false then
			cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_hochland");
			cm:show_message_event(
				STEC_FACTIONEMPIRE,
				"event_feed_strings_text_stec_event_feed_string_scripted_event_hochland_appeased_primary_detail",
				"event_feed_strings_text_stec_event_feed_string_scripted_event_hochland_appeased_secondary_detail",
				"event_feed_strings_text_stec_event_feed_string_scripted_event_hochland_appeased_flavour_text",
				true,
				591
			);
			HOCH_APPEASED = true;
			out("STEC: HOCHLAND APPEASED, varaible is "..tostring(HOCH_APPEASED))
			end
		end,
	true
	);

-------------------------------------------------------------------------------
-- After a BATTLE END, checks if empire LL defeated the nords. OSTLAND -- for testing use "wh_main_sc_emp_empire" instead of "wh_main_sc_nor_norsca"


	core:add_listener(
		"ostland_appease",
		"CharacterCompletedBattle",
		function(context) return context:character():faction():name() == STEC_FACTIONEMPIRE and context:character():has_military_force() == true and context:pending_battle():defender():faction():subculture() == "wh_main_sc_nor_norsca" end,

		function(context)
		
			local ostAlive = cm:model():world():faction_by_key("wh_main_emp_ostland");
			local char = context:character()
			out("STEC: BATTLE COMPLETE IS OSTLAND DEAD? "..tostring(ostAlive:is_dead()).."Checking for LL")
			
			if (char:get_forename() == "names_name_2147343849" or char:get_forename() == "names_name_2147343922" or char:get_forename() == "names_name_2147358013") and OST_APPEASED == false and ostAlive:is_dead() == false then
				cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_ostland");
			cm:show_message_event(
				STEC_FACTIONEMPIRE,
				"event_feed_strings_text_stec_event_feed_string_scripted_event_ostland_appeased_primary_detail",
				"event_feed_strings_text_stec_event_feed_string_scripted_event_ostland_appeased_secondary_detail",
				"event_feed_strings_text_stec_event_feed_string_scripted_event_ostland_appeased_flavour_text",
				true,
				591
			);
			OST_APPEASED = true;
			out("STEC: OSTLAND APPEASED, varaible is "..tostring(OST_APPEASED))
			end
		end,
	true
	);


-------------------------------------------------------------------------------
-- Start of FACTION TURN checks to see if LL is over level 20. MIDDENLAND -- for testing use level 2 instead of 20.


	core:add_listener(
	"LL_rank_monitor",
	"FactionTurnStart",
	function(context) return context:faction():name() == STEC_FACTIONEMPIRE and MID_APPEASED == false end,
	function(context)
	
		local char_list = context:faction():character_list()
		local midAlive = cm:model():world():faction_by_key("wh_main_emp_middenland");
		out("STEC: TURN START IS MIDDENLAND DEAD? "..tostring(midAlive:is_dead()).." check check LL");
		
		if midAlive:is_dead() == false then
			for i = 0, char_list:num_items()-1 do
			
				local current_char = char_list:item_at(i)
				local char_name = current_char:get_forename()
				out("STEC: CHeck Hero"..tostring(char_name))
				
				if (char_name == "names_name_2147343849" or char_name == "names_name_2147343922" or char_name == "names_name_2147358013") and current_char:rank() > 20 then
					cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_middenland");
					cm:show_message_event(
						STEC_FACTIONEMPIRE,
						"event_feed_strings_text_stec_event_feed_string_scripted_event_middenland_appeased_primary_detail",
						"event_feed_strings_text_stec_event_feed_string_scripted_event_middenland_appeased_secondary_detail",
						"event_feed_strings_text_stec_event_feed_string_scripted_event_middenland_appeased_flavour_text",
						true,
						591
					);
					MID_APPEASED = true;
					out("STEC: MIDDENLAND APPEASED, variable is "..tostring(MID_APPEASED))
				end;
			end;
		end;
	end,
	true
	);


-------------------------------------------------------------------------------
-- start of FACTION TURN checks to see if Altdorf city is level 4 or 5. --for testing use lvl 2 not 4.


	core:add_listener(
	"AltdorfDevelopment",
	"FactionTurnStart",
	function(context) return context:faction():name() == STEC_FACTIONEMPIRE and TAL_APPEASED == false end,
	function(context)
	
		local altdorfFour = context:faction():home_region():building_exists("wh_main_special_settlement_altdorf_4_emp")
		local altdorfFive = context:faction():home_region():building_exists("wh_main_special_settlement_altdorf_5_emp")
		local talAlive = cm:model():world():faction_by_key("wh_main_emp_talabecland");
		out("STEC: TURN START IS TALABEC DEAD? "..tostring(talAlive:is_dead()).."checking for Altdorf level")
		
		if talAlive:is_dead() == false and (altdorfFour == true or altdorfFive == true) then
			cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_talabecland");
					cm:show_message_event(
						STEC_FACTIONEMPIRE,
						"event_feed_strings_text_stec_event_feed_string_scripted_event_talabecland_appeased_primary_detail",
						"event_feed_strings_text_stec_event_feed_string_scripted_event_talabecland_appeased_secondary_detail",
						"event_feed_strings_text_stec_event_feed_string_scripted_event_talabecland_appeased_flavour_text",
						true,
						591
					);
					TAL_APPEASED = true;
					out("STEC: TALABECLAND APPEASED, variable is "..tostring(TAL_APPEASED));
		end;

	end,
	true
	);


-------------------------------------------------------------------------------
-- start of FACTION TURN checks to see if any Empire regions have a level 3 forge built. --for testing use "wh_main_emp_barracks_1" instead of "wh_main_emp_forges_3"


	core:add_listener(
	"EngineerDevelopment",
	"FactionTurnStart",
	function(context) return context:faction():name() == STEC_FACTIONEMPIRE and WIS_APPEASED == false end,
	function(context)
	
		out("STEC: TURN START wissenburg appeasement monitor fired searching regions for forge.")
		local region_list = context:faction():region_list();
		local wisAlive = cm:model():world():faction_by_key("wh_main_emp_wissenland");

		if wisAlive:is_dead() == false then
			for i = 0, region_list:num_items()-1 do
			
				local current_region = region_list:item_at(i)
				local forges_built = current_region:building_exists("wh_main_emp_forges_3")				
				out("STEC: region: "..tostring(current_region).."has forge? "..tostring(forges_built));
				
				if forges_built == true and WIS_APPEASED == false then -- this check occurs again in case multiple regions have the forge when the loop begins.
					out("STEC: forge is built appeasement occurs")
					cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_wissenland");
					cm:show_message_event(
						STEC_FACTIONEMPIRE,
						"event_feed_strings_text_stec_event_feed_string_scripted_event_wissenland_appeased_primary_detail",
						"event_feed_strings_text_stec_event_feed_string_scripted_event_wissenland_appeased_secondary_detail",
						"event_feed_strings_text_stec_event_feed_string_scripted_event_wissenland_appeased_flavour_text",
						true,
						591
					);
					WIS_APPEASED = true;	
					out("STEC: WISSENLAND APPEASED, variable is"..tostring(WIS_APPEASED));
				end;
				
			end;
		end;
	end,
	true
	);


-------------------------------------------------------------------------------
-- on CHAR TURN START check for Captain presence in Averheim AVERLAND --for testing, comment out the character type.


	core:add_listener(
		"averland_appease",
		"CharacterTurnStart",
		function(context) return context:character():character_type("champion") and context:character():has_region() and context:character():faction():name() == STEC_FACTIONEMPIRE and AVER_APPEASED ==false
		end,
	function(context)
	
			local averAlive = cm:model():world():faction_by_key("wh_main_emp_averland");
			local location = context:character():region():name()
			out("STEC: CHAR TURN START IS AVERLAND DEAD?"..tostring(averAlive:is_dead()).."AND IS APPEASED?"..tostring(AVER_APPEASED))	
			
			if  location == "wh_main_averland_averheim" and averAlive:is_dead() == false then
				cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_averland");
					cm:show_message_event(
						STEC_FACTIONEMPIRE,
						"event_feed_strings_text_stec_event_feed_string_scripted_event_averland_appeased_primary_detail",
						"event_feed_strings_text_stec_event_feed_string_scripted_event_averland_appeased_secondary_detail",
						"event_feed_strings_text_stec_event_feed_string_scripted_event_averland_appeased_flavour_text",
						true,
						591
					);
			AVER_APPEASED = true;
			out("STEC: AVERLAND APPEASEMENT COMPLETE, varaible is "..tostring(AVER_APPEASED))
			end;
	end,
	true
	);


-------------------------------------------------------------------------------
-- on CHAR TURN START check for Witch Hunter presence in bechhafen OSTERMARK --for testing, comment out the character type.


	core:add_listener(
		"ostermark_appease",
		"CharacterTurnStart",
		function(context) return context:character():character_type("spy") and context:character():has_region() and context:character():faction():name() == STEC_FACTIONEMPIRE and OSTER_APPEASED == false
		end,
	function(context)
	
			local osterAlive = cm:model():world():faction_by_key("wh_main_emp_ostermark");
			local location = context:character():region():name()
			out("STEC: CHAR TURN START IS OSTERMARK DEAD? "..tostring(osterAlive:is_dead()).."AND IS APPEASED?"..tostring(OSTER_APPEASED))
			
			if  location == "wh_main_ostermark_bechafen" and osterAlive:is_dead() == false then
				cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_ostermark");
					cm:show_message_event(
						STEC_FACTIONEMPIRE,
						"event_feed_strings_text_stec_event_feed_string_scripted_event_ostermark_appeased_primary_detail",
						"event_feed_strings_text_stec_event_feed_string_scripted_event_ostermark_appeased_secondary_detail",
						"event_feed_strings_text_stec_event_feed_string_scripted_event_ostermark_appeased_flavour_text",
						true,
						591
					);
				OSTER_APPEASED = true;
				out("STEC: OSTERMARK APPEASEMENT COMPLETE, varaible is "..tostring(OSTER_APPEASED))
			end;
	end,
	true
	);

end;
-------------------------------------------------------------------------------
--Saving & loading (ensures variables are remembered across saving/loading)

cm:add_saving_game_callback(
	function(context)
		out("===STEC: SAVING===")
		cm:save_named_value("AVER_APPEASED", AVER_APPEASED, context);
		cm:save_named_value("HOCH_APPEASED", HOCH_APPEASED, context);
		cm:save_named_value("MID_APPEASED", MID_APPEASED, context);
		cm:save_named_value("NORD_APPEASED", NORD_APPEASED, context);
		cm:save_named_value("OSTER_APPEASED", OSTER_APPEASED, context);
		cm:save_named_value("OST_APPEASED", OST_APPEASED, context);
		cm:save_named_value("STIR_APPEASED", STIR_APPEASED, context);
		cm:save_named_value("TAL_APPEASED", TAL_APPEASED, context);
		cm:save_named_value("WIS_APPEASED", WIS_APPEASED, context);
	end
);

cm:add_loading_game_callback(
	function(context)
		out("===STEC: LOADING===")
		AVER_APPEASED = cm:load_named_value("AVER_APPEASED", false, context);
		HOCH_APPEASED = cm:load_named_value("HOCH_APPEASED", false, context);
		MID_APPEASED = cm:load_named_value("MID_APPEASED", false, context);
		NORD_APPEASED = cm:load_named_value("NORD_APPEASED", false, context);
		OSTER_APPEASED = cm:load_named_value("OSTER_APPEASED", false, context);
		OST_APPEASED = cm:load_named_value("OST_APPEASED", false, context);
		STIR_APPEASED = cm:load_named_value("STIR_APPEASED", false, context);
		TAL_APPEASED = cm:load_named_value("TAL_APPEASED", false, context);
		WIS_APPEASED = cm:load_named_value("WIS_APPEASED", false, context);		
	end
);

--script ends