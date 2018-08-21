--Script by theSniperDevil--
-- This script lets the owner of a vassal get an ancillary for a general when present in a vassals home province IF the vassal owns its entire home province.
--It utilises an object which means you can use this script and define your own vassals and the ancillaries they give.
-- Note this script uses Kailua comment parsing for VS code.


-----------------------
-- Building the object and it's functions. - Consider these templates that are used later on.
-----------------------
local vassal_ancillary_manager = {}; --# assume vassal_ancillary_manager: VAM

--constructor function allows defining of objects. 
	--v function(vassal_name: string, vassal_overlord: string, home_province: string, ancillary_name: string) --> VAM
	function vassal_ancillary_manager.new(vassal_name, vassal_overlord, home_province,ancillary_name)
		local self ={};
		setmetatable(self, {__index = vassal_ancillary_manager});
	
		--# assume self: VAM
		self.vassal_name = vassal_name;
		self.vassal_overlord = vassal_overlord;
		self.home_province = home_province;
		self.ancillary_name = ancillary_name
		
		out("TP_VAS: New ancillary object entered "..tostring(self.vassal_name));
		return self;
	end;

	-- function checks to see if vassal  is sufficiently appeased to give follower.
	--v function(self: VAM, context: WHATEVER) --> boolean
	function vassal_ancillary_manager.checks(self, context)
		
		local vassal_interface = cm:get_faction(self.vassal_name);
		local overlord_interface = cm:get_faction(self.vassal_overlord);

		if context:character():region():province_name() ~= self.home_province then
			out("TP_VAS: Character is not in this vassals region");
			return false
		end;
		if not vassal_interface:holds_entire_province(self.home_province , true) then 
			out("TP_Vas: vassal does not own its entire province.");
			return false
		end;
		if not vassal_interface:is_vassal_of(overlord_interface) then
			out("TP_VAS: vassal is not an actual vassal");
			return false
		end;
		out("TP_VAS: checks passed.");
		return true

	end;

	-- assigns ancillary, unless it is already earned.
	--v function(self: VAM, context: WHATEVER)
	function vassal_ancillary_manager.unlock_ancillary(self, context)
		local char_str = cm:char_lookup_str(context:character())
		if not context:character():has_ancillary(self.ancillary_name) then
			cm:force_add_and_equip_ancillary(char_str, self.ancillary_name);
			out("TP_VAS: ancillary unlocked");
		end;
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

------------------------------------
-- first define the ancilalry objects you wish. Syntax is:
-- vassal_ancilalry_manager:new(vassal faction, vassal overlord, province you want vassal to own, the ancillary key in ancillaries table.)	
	local hochland_ancillary = vassal_ancillary_manager.new("wh_main_emp_hochland", "wh_main_emp_empire", "wh_main_hochland", "tp_vas_anc_hochland")
	local ostland_ancillary = vassal_ancillary_manager.new("wh_main_emp_ostland", "wh_main_emp_empire", "wh_main_ostland", "tp_vas_anc_ostland")
	local nordland_ancillary = vassal_ancillary_manager.new("wh_main_emp_nordland", "wh_main_emp_empire", "wh_main_nordland", "tp_vas_anc_nordland")
	local middenland_ancillary = vassal_ancillary_manager.new("wh_main_emp_middenland", "wh_main_emp_empire", "wh_main_middenland", "tp_vas_anc_middenland")
	local ostermark_ancillary = vassal_ancillary_manager.new("wh_main_emp_ostermark", "wh_main_emp_empire", "wh_main_ostermark", "tp_vas_anc_ostermark")
	local talabecland_ancillary = vassal_ancillary_manager.new("wh_main_emp_talabecland", "wh_main_emp_empire", "wh_main_talabecland", "tp_vas_anc_talabecland")
	local wissenland_ancillary = vassal_ancillary_manager.new("wh_main_emp_wissenland", "wh_main_emp_empire", "wh_main_wissenland", "tp_vas_anc_wissenland")
	local stirland_ancillary = vassal_ancillary_manager.new("wh_main_emp_stirland", "wh_main_emp_empire", "wh_main_stirland", "tp_vas_anc_stirland")
	local averland_ancillary = vassal_ancillary_manager.new("wh_main_emp_averland", "wh_main_emp_empire", "wh_main_averland", "tp_vas_anc_averland")

-------------------------------------	
--ensure that the variables above are then added to the table below. This allows the script to quickly search through the varaibles are easier to list through in a for loop.
	local ancillary_list = {
		hochland_ancillary,
		ostland_ancillary,
		nordland_ancillary,
		middenland_ancillary,
		ostermark_ancillary,
		talabecland_ancillary,
		wissenland_ancillary,
		stirland_ancillary,
		averland_ancillary
	}--: vector<VAM>

-------------------------------------
-- Listener function. Fires on the START TURN of the overlord faction characters. It calls the check function defined earlier and calls the ancilalry assignment function defined earlier if checks are pased.

function vassal_ancillary()
	out("TP_VAS: init");
		
	core:add_listener(
		"ancillary_listener",
		"CharacterTurnStart", 
		function(context) return context:character():faction():name() == "wh_main_emp_empire" end, -- this check is best made without object. create a fresh listener for each "overlord" you may have.
		function(context)
			for i=1, #ancillary_list do
				local temp = ancillary_list[i];
				out("TP_Vas "..tostring(temp.vassal_name));
				if temp:checks(context) then
					out("TP_VAS: ancillary unlock function called.");
					temp:unlock_ancillary(context);
				end;
			end;	
		end,
	true
	);


	--force_vassal();
end;