
local effect_bundle_level_1 = "" --dummy and hidden effect bundles
local effect_bundle_level_2 = "" --dummy and hidden effect bundles
local effect_bundle_level_3 = "" --dummy and hidden effect bundles

function init() 
	local region_list = cm:model():world():region_manager():region_list();

	for i=1, #region_list do
		local current_region = region_list[i];
		local current_owner = current_region:owning_faction();


	end;
end;

-- at the end of each factions turn, goes through their regions and modifies counter 
eh:add_listener(
	"end_turn_deducter",

	"FactionTurnEnd",

	true,

	function(context)
		local this_faction = context:faction();
		local faction_regions = this_faction:region_list();

		for i=1, #faction_regions do
			local current_region = faction_region[i];

			if not current_region:is_province_capital() then
				
				if current_region:has_character() then 

					addition(current_region);

				else 

					if deducter(current_region); then
						make_settlement_neutral(current_region);
					end;

				end;

			end;

		end;

	end

);

-- this function will transfer the region to a rebel like faction.
function make_settlement_neutral(region)
	--change ownership of region to a rebel.
end;

-- function is called when a region for a faction has no character in it and deducts effect bundle counters and retursn true if counter hits 0.
function deducter(region)
	local this_region = region;

	if this_region:has_effect_bundle(effect_bundle_level_3) then
		--remove effect_bundle_level_3
		--add effect_bundle_level_2
	elseif this_region:has_effect_bundle(effect_bundle_level_2) then
		--remove effect_bundle_level_2
		--add effect_bundle_level_1

	elseif this_region:has_effect_bundle(effect_bundle_level_1) then
		--remove effect_bundle_level_2
		return true;
	end;

end;

-- function is called when a region for a faction has a character in it and deducts effect bundle counters and retursn true if counter hits 0.
	function addition(region)
		local this_region = region;
	
		if this_region:has_effect_bundle(effect_bundle_level_3) then
			return true;
		elseif this_region:has_effect_bundle(effect_bundle_level_2) then
			--remove effect_bundle_level_2
			--add effect_bundle_level_3
	
		elseif this_region:has_effect_bundle(effect_bundle_level_1) then
			--remove effect_bundle_level_1
			--add effect_bundle_level_2
		else
			--add effect_bundle_level_1
		end;
	
	end;

	function has_character_in_region(faction, region)

	end;