--Script by theSniperDevil--
-- This script allows the player some options to manage regions owned by them/ their vassals to help restore them to rightful owners.
--It utilises an object which means you can use this script and define your own vassals and ther egions they should own.
-- Note this script uses Kailua comment parsing for VS code.

-----------------------
-- Building the object and it's functions. - Consider these templates that are used later on.
-----------------------
local vassal_region_manager = {} --# assume vassal_region_manager: VRM

--this is a constructor function. It is used to define a new object. The objectha a few arguments from the vassal name to details about spawning an army.
--v function(vassal_name: string, vassal_overlord: string, home_province: string, home_captial: string, home_regions: vector<string>, army_x: number, army_y: number, unit_list: string) --> VRM
function vassal_region_manager.new(vassal_name, vassal_overlord, home_province, home_captial, home_regions, army_x, army_y, unit_list)
    local self = {}
    setmetatable(self, {__index = vassal_region_manager});
    --# assume self: VRM
    self.vassal_name = vassal_name;
    self.vassal_overlord = vassal_overlord;
    self.home_province = home_province;
    self.home_capital = home_captial;
    self.home_regions = home_regions;
    self.army_x = army_x;
    self.army_y = army_y;
    self.unit_list = unit_list;
    
    out("TP_VAS: New faction object entered "..tostring(self.vassal_name));
    return self;
end;

-- function here checks to see if a given province is rightfully owned by a vassal object. (note it's called sack_check because it is only called by a sack event later on.)
--v function(self: VRM, this_province: string) --> boolean
function vassal_region_manager.sack_check(self, this_province)
	out("TP_VAS: sack check function called for "..tostring(self.vassal_name));
	out("TP_VAS: do these match?"..tostring(this_province).." and "..tostring(self.home_province));

	if this_province == self.home_province then
		out("TP_VAS: Province matches a defined object");
		return true
	else
		out("TP_VAS: Province is not defined in object");
		return false
	end;
end;

-- function here transfers a given region to the faction in the vassal object. Again, only called by the sack event.
--v function(self: VRM, this_region: CA_REGION)
function vassal_region_manager.sack_transfer(self, this_region)
	out("TP_VAS: checks passed, transfering region.");
	local this_region_name = this_region:name();
	local this_owner = self.vassal_name;
	
	cm:transfer_region_to_faction(this_region_name, this_owner);
end;


-- function spawns an army in the home region of the vassal object.
--v function(self: VRM) 
function vassal_region_manager.emerging_army(self)
	out("TP_VAS: Army spawning for "..tostring(self.vassal_name));
	local home_capital = tostring(self.home_capital);
	local x = self.army_x	
	local y = self.army_y
	local vassal_name = self.vassal_name
	local unit_list = self.unit_list


	cm:create_force(
		vassal_name,
		unit_list,
		home_capital,
		x,
		y,
		true,
		true,
		function(cqi --: CA_CQI
		)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true);
		end
	);

end;

-- function checks to see if a vassal object faction is dead and if it's capital is owned by another vassal.
--v function(self: VRM) --> boolean
function vassal_region_manager.emergence_check_v(self)
	out("TP_VAS: Checking if".. tostring(self.vassal_name) .."needs army for emerging.");
	local this_vassal_interface = cm:model():world():faction_by_key(self.vassal_name);
	local this_overlord_interface = cm:model():world():faction_by_key(self.vassal_overlord);
	local this_capital_interface = cm:get_region(self.home_capital)

	if this_vassal_interface:is_dead() and this_capital_interface:owning_faction():is_vassal_of(this_overlord_interface) then
		out("TP_VAS: Army emergence can occur.");
		return true
	else
		out("TP_VAS: Army emergence cannot occur");
		return false
	end;
end;

-- function checks to see if a given vassal object is dead and if it's capital is owned by it's overlord.
--v function(self: VRM) --> boolean
function vassal_region_manager.emergence_check_o(self)
	out("TP_VAS: Checking if".. tostring(self.vassal_name) .."needs army for emerging.");
	local this_vassal_interface = cm:model():world():faction_by_key(self.vassal_name);
	local this_capital_interface = cm:get_region(self.home_capital)
	
	if this_vassal_interface:is_dead() and this_capital_interface:owning_faction():name() == self.vassal_overlord then
		out("TP_VAS: Army emergence can occur.");
		return true
	else
		out("TP_VAS: Army emergence cannot occur");
		return false
	end;
end;

-- function goes through each home region of a vassal object and checks to see if it is currently owned by another vassal then transfers that region.
	--v function(self: VRM)
	function vassal_region_manager.region_transfer_v(self)
		
		for i = 1, #self.home_regions do
			out("TP_VAS: region "..tostring(self.home_regions[i]));
			local this_region = cm:get_region(self.home_regions[i]);
			local this_overlord_interface = cm:model():world():faction_by_key(self.vassal_overlord);
			local owner_check = this_region:owning_faction():is_vassal_of(this_overlord_interface);

			if owner_check == true then
				cm:transfer_region_to_faction(self.home_regions[i], self.vassal_name);
				out("TP_VAS: check Passed, transferring now.");
			end
		end;
	end;

-- function goes through each home region of a vassal object and checks to see if it is currently owned by overlord then transfers that region.
	--v function(self: VRM)
	function vassal_region_manager.region_transfer_o(self)
		
		for i = 1, #self.home_regions do
			out("TP_VAS: region "..tostring(self.home_regions[i]));
			local this_region = cm:get_region(self.home_regions[i]);
			local this_region_owner = this_region:owning_faction():name();

			if this_region_owner == self.vassal_overlord then
				cm:transfer_region_to_faction(self.home_regions[i], self.vassal_name);
				out("TP_VAS: check Passed, transferring now.");
			end;
		end;
	end;


-----------------------
-- Object Definitions Ends 
-----------------------
---------------------------------------------
-----------------------
-- EMPIRE VASSAL OBJECT DEFINITIONS
-----------------------

-- create objects here. (vassal name, its rightful overlord, vassals province, province capital, a lsit of regions in that province (include capital), x co ords, y co ords, list of units) - last three are for spawning armies. 
local hochland = vassal_region_manager.new("wh_main_emp_hochland", "wh_main_emp_empire", "wh_main_hochland", "wh_main_hochland_hergig", {"wh_main_hochland_hergig","wh_main_hochland_brass_keep"},580,512, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
local averland = vassal_region_manager.new("wh_main_emp_averland", "wh_main_emp_empire", "wh_main_averland", "wh_main_averland_averheim", {"wh_main_averland_averheim","wh_main_averland_grenzstadt"}, 558, 438, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
local wissenland = vassal_region_manager.new( "wh_main_emp_wissenland", "wh_main_emp_empire", "wh_main_wissenland", "wh_main_wissenland_nuln", {"wh_main_wissenland_nuln","wh_main_wissenland_pfeildorf","wh_main_wissenland_wissenburg"}, 519, 408, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
local stirland = vassal_region_manager.new("wh_main_emp_stirland", "wh_main_emp_empire", "wh_main_stirland", "wh_main_stirland_wurtbad", {"wh_main_stirland_wurtbad","wh_main_stirland_the_moot"}, 565, 436, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
local ostland = vassal_region_manager.new("wh_main_emp_ostland", "wh_main_emp_empire", "wh_main_ostland", "wh_main_ostland_wolfenburg", {"wh_main_ostland_wolfenburg","wh_main_ostland_norden"}, 600, 546, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
local middenland = vassal_region_manager.new("wh_main_emp_middenland", "wh_main_emp_empire", "wh_main_middenland", "wh_main_middenland_middenheim", {"wh_main_middenland_middenheim","wh_main_middenland_carroburg", "wh_main_middenland_weismund"}, 519, 516, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
local nordland = vassal_region_manager.new("wh_main_emp_nordland", "wh_main_emp_empire", "wh_main_nordland", "wh_main_nordland_salzenmund", {"wh_main_nordland_salzenmund","wh_main_nordland_dietershafen"}, 519, 550, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
local ostermark = vassal_region_manager.new("wh_main_emp_ostermark", "wh_main_emp_empire", "wh_main_ostermark", "wh_main_ostermark_bechafen", {"wh_main_ostermark_bechafen","wh_main_ostermark_essen"}, 650, 516, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
local talabecland = vassal_region_manager.new("wh_main_emp_talabecland", "wh_main_emp_empire", "wh_main_talabecland", "wh_main_talabecland_talabheim", {"wh_main_talabecland_talabheim","wh_main_talabecland_kemperbad"}, 590, 486, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
local reikland = vassal_region_manager.new("wh_main_emp_empire", "wh_main_emp_empire", "wh_main_reikland", "wh_main_reikland_altdorf", {"wh_main_reikland_altdorf","wh_main_reikland_eilhart", "wh_main_reikland_helmgart", "wh_main_reikland_grunburg"}, 486, 438, "wh_main_emp_art_mortar,wh_main_emp_inf_greatswords,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_cav_empire_knights,wh_main_emp_cav_outriders_0,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen");
-- note Reikland is the overlord, but is added to ensure reikland provinces can be managed in case vassals control them!

local vassal_list = {
	hochland,
	averland,
	wissenland,
	stirland,
	ostland,
	middenland,
	nordland,
	ostermark,
	talabecland,
	reikland
} --:vector<VRM>
--add each object into this table. Many functions cycle through this table to check the obejcts.

-----------------------
-- Building Listeners
-----------------------

-- This Listener fires when the empire sacks a region and then checks against all object instances to see if we should return this region to an original owner. WORKS FINE

	core:add_listener(
		"sack_listener_Emp",
		"CharacterSackedSettlement", 
		function(context) return context:character():faction():name() == "wh_main_emp_empire" end, -- this check is best made without object. create a fresh listener for each "overlord" you may have.
		function(context)
			local this_region = context:character():region();
			local region_province = this_region:province_name();
			out("TP_VAS: sack detected:"..tostring(region_province));
			
			for i = 1, #vassal_list do
			out("TP_VAS: looping"..tostring(vassal_list[i]));
				if vassal_list[i]:sack_check(region_province) then -- note these functions were defined as part of the object.
					vassal_list[i]:sack_transfer(this_region);
				end;
			end;
		end,
	true
	);

-- This listener checks for one of two region trasnfer dilemmas and then trasnfers regions from the overlord/ or its vassals to rightful owners.

	core:add_listener(
		"empire_dilemmas_listener",
		"DilemmaChoiceMadeEvent",
		function(context) return (context:dilemma() == "vas_reg_main_emp_respect_borders" and context:choice() == 0) or (context:dilemma() == "vas_reg_main_emp_vassal_respect" and context:choice() == 0) end,
		function(context)
			out("TP_VAS: dilemma occurred.");
			
			if context:dilemma() == "vas_reg_main_emp_respect_borders" then
				out("TP_VAS: Reikland return dilemma detected, loop through all vassal objects");
				for i=1, #vassal_list do
					out("TP_VAS: Currently "..tostring(vassal_list[i].vassal_name));	
					if vassal_list[i]:emergence_check_o() then
						vassal_list[i]:emerging_army();
					end;
					out("TP_VAS: Army spawning completed, doing region transfer for "..tostring(vassal_list[i].vassal_name));
					cm:callback(function() vassal_list[i]:region_transfer_o(); end, 0.5); --callback gives time for army to spawn before region transfers.
				end;
				
			elseif context:dilemma() == "vas_reg_main_emp_vassal_respect" then
				out("TP_VAS: Vassals return dilemma detected, loop through all vassal objects");
				for i=1, #vassal_list do
					out("TP_VAS: Currently "..tostring(vassal_list[i].vassal_name));
					if vassal_list[i]:emergence_check_v() then
						vassal_list[i]:emerging_army();
					end;
					out("TP_VAS: Army spawning completed, doing region transfer for "..tostring(vassal_list[i].vassal_name));
					cm:callback(function() vassal_list[i]:region_transfer_v(); end, 0.5); --callback gives time for army to spawn before region transfers.
				end;

			end;
			
		end,
		true
	);

-- Dilemma countdown currently set to get 2 dilemmas every 20 turns!
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

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:dilemma_countdown("turns_until_event", turns_until_event, context);
	end
);

cm:add_loading_game_callback(
	function(context)
		dilemma_countdown = cm:load_named_value("turns_until_event", 20, context);
	end
);

-- Script Ends




