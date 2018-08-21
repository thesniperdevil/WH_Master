--Script by theSniperDevil--
-- This script lets the owner of a vassal get an effect bundle when the vassal owns its entire home province.
--It utilises an object which means you can use this script and define your own vassals and the rewards they give.
-- Note this script uses Kailua comment parsing for VS code.

-----------------------
-- Building the object and it's functions. - Consider these templates that are used later on.
-----------------------
local vassal_reward_entry = {} --# assume vassal_reward_entry: VRE

--this is a constructor function. It is used to define a new object that has the arguments overlord, vassal and province.
--v function(overlord: string, vassal: string, province: string) --> VRE
function vassal_reward_entry.new(overlord, vassal, province)
	local self ={};
	setmetatable(self, {__index = vassal_reward_entry});

	--# assume self: VRE
	self.overlord = overlord --faction name. e.g. "wh_main_emp_empire"
	self.vassal = vassal -- faction name. e.g. "wh_main_emp_hochland"
	self.province = province -- string e.g. "wh_main_hochland"
	out("vas_eff: New Vassal Entered: "..vassal);
	return self;
end;

--this function checks allows you to check a given object and returns true of all those checks are passed.
--v function(self: VRE) --> boolean
function vassal_reward_entry.condition_check(self)
	local vassal_interface = cm:get_faction(self.vassal) -- finds game interface using vassal name.
	local overlord_interface = cm:get_faction(self.overlord) -- finds game interface using overlord name.
	out("vas_eff: Checking "..tostring(self.vassal));
	
	if vassal_interface:is_dead() then
		out("vas_eff: Check fails "..tostring(self.vassal).." is dead!");
		return false -- the particular vassal is dead, CHECK FAILS.
	end;
	
	if not vassal_interface:is_vassal_of(overlord_interface) then --you could change this to military ally?
		out("vas_eff: Check fails "..tostring(self.overlord).." does not own "..tostring(self.vassal));
		return false -- the 'vassal' is not actually a vassal of the overlord, CHECK FAILS.
	end;
	
	if not vassal_interface:holds_entire_province(self.province, true) then
		out("vas_eff: Check fails "..tostring(self.vassal).." does not own "..tostring(self.province));
		return false -- the vassal does not own all of the given province, CHECK FAILS.
	end;
	
	out("vas_eff: Checks all pass for "..tostring(self.vassal));
	
	return true -- above three checks passed, CHECK PASSES.
end;
-------------------------------------
-- Object building ends.
-------------------------------------

--TEST FUNCTION change factions to suite the factions you want to test.
function force_vassal()
	cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_averland");
	cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_hochland");
	cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_middenland");
	cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_nordland");
	cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_stirland");
	cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_talabecland");
	cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_ostland");
	cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_ostermark");
	cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_marienburg");
	cm:force_make_vassal("wh_main_emp_empire","wh_main_emp_wissenland" );
end;


-------------------------------------
--EMPIRE FACTION OVERLORD
-------------------------------------

-------------------------------------
-- first define the vassal objects you wish. Syntax is:
-- vassal_reward_entry:new(faction overlord, vassal faction, province you want vassal to own.)	
	local hochland_vassal = vassal_reward_entry.new("wh_main_emp_empire","wh_main_emp_hochland","wh_main_hochland");
	local averland_vassal = vassal_reward_entry.new("wh_main_emp_empire","wh_main_emp_averland","wh_main_averland");
	local wissenland_vassal = vassal_reward_entry.new("wh_main_emp_empire","wh_main_emp_wissenland","wh_main_wissenland");
	local talabecland_vassal = vassal_reward_entry.new("wh_main_emp_empire","wh_main_emp_talabecland","wh_main_talabecland");
	local ostland_vassal = vassal_reward_entry.new("wh_main_emp_empire","wh_main_emp_ostland","wh_main_ostland");
	local nordland_vassal = vassal_reward_entry.new("wh_main_emp_empire","wh_main_emp_nordland","wh_main_nordland");
	local middenland_vassal = vassal_reward_entry.new("wh_main_emp_empire","wh_main_emp_middenland","wh_main_middenland");
	local ostermark_vassal = vassal_reward_entry.new("wh_main_emp_empire","wh_main_emp_ostermark","wh_main_ostermark");
	local marienburg_vassal = vassal_reward_entry.new("wh_main_emp_empire","wh_main_emp_marienburg","wh_main_the_wasteland");
	local stirland_vassal = vassal_reward_entry.new("wh_main_emp_empire","wh_main_emp_stirland","wh_main_stirland");

-------------------------------------	
--ensure that the variables above are then added to the table below. This allows the script to quickly search through the varaibles are easier to list through in a for loop.
local empire_vassals = {
    hochland_vassal,
    averland_vassal,
    wissenland_vassal,
	talabecland_vassal,
	ostland_vassal,
	nordland_vassal,
	middenland_vassal,
	ostermark_vassal,
	marienburg_vassal,
	stirland_vassal
} --:vector<VRE>

-------------------------------------
-- This function manages effects, it will always remove the current level effect and apply the most up to date version.
	--v function(counter: integer, overlord: string)
	function tp_emp_effect_manager(counter, overlord)

	-- Stores the effect levels. make sure you have 1 effect for each number of vassals you have set. names must match database.
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

		local this_counter = tonumber(counter);
		if this_counter > 10 then
			this_counter = 10 --this makes sure any additional vassals from EOM dont kill this mod.
		end;

		local new_effect = tp_emp_effects[this_counter];
		out("vas_eff: effect manager called with counter as "..tostring(this_counter).." and overlord as "..tostring(overlord));

	--Removes all current effects.
		for i = 1, #tp_emp_effects do
			local this_effect = tp_emp_effects[i];
			
			cm:remove_effect_bundle(this_effect, overlord);
			out("vas_eff: removing effect "..tostring(this_effect));
		end;
		
	--then applies the correct level of effect.	
		cm:apply_effect_bundle(new_effect, overlord,0);
		out("vas_eff: adding effect "..tostring(new_effect));

end;

-------------------------------------
-- Listener function. Fires on the START TURN of the overlord faction. checks to see how many vassals with full provinces there are and totals the number beforecalling the effect manager.
	function vassal_listener()
		core:add_listener(
		"overlord_emp_turn",
		"FactionTurnStart",
		function(context) return context:faction():is_human() end, -- in this case I want to run this for the player - may want to change this to "overlord" faction. Recommend setting up different listeners if you have multiple "overlords" defined.
		function(context)
		out("vas_eff: listener fired");
		local counter = 0 -- counter will determine how many vassals have full region.
		local this_faction = context:faction():name(); -- this assumes the triggering faction is the overlord.
			for i =1, #empire_vassals do -- This searches through the table that holds the empire vassal objects.
			local temp = empire_vassals[i];
			
			out("vas_eff: init conditon check");
			
				if temp:condition_check() then -- utilising the object function defined earlier.
					counter = counter + 1
					out("vas_eff: "..tostring(temp).." is a vassal and has it's full region, increasing counter to "..tostring(counter));
				end;
			end;
		tp_emp_effect_manager(counter, this_faction);
		out("vas_eff: effects removed/ applied");
		end,
		true);
	end;

-- This function initiates	the listener when the script loads.
function vassal_effects()
	vassal_listener();
	--force_vassal();
	out("vas_eff: Script Init");
return true;

end;

-- Script Ends