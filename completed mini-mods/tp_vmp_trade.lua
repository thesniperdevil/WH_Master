-- Script by theSniperDevil--

function tp_vmp_trade()
	if cm:is_new_game() then
		tp_listener();
		output("TP: INITIALISE");
	end;
	return true;
end;

function tp_listener()
	core:add_listener(
			"tradeCheckTurnStart",
			"FactionTurnStart",
			function(context) return true end,
			function(context)
				local factions_trading_with = context:faction():factions_trading_with();
				output("TP: checking faction for rite effect bundle");
				
				if context:faction():has_effect_bundle("wh_main_ritual_vmp_intrigue") then 
					if tp_trading_check(context:faction():name(), "wh_main_vmp_vampire_counts") then
						apply_effect_to_regions(context:faction():name(),"tp_trade_corr_bundle_region_vamp")
						output("TP: effects given.");
					else 
						remove_effect_from_regions(context:faction():name(), "tp_trade_corr_bundle_region_vamp")
						output("TP: effects taken.");
					end;
				end;
			end,
			true
	);
end

function elven_espionage_reveal_shroud(faction)
	local factions_trading_with = faction:factions_trading_with();
	local faction_name = faction:name();
	
	if factions_trading_with:num_items() > 0 then
		for i = 0, factions_trading_with:num_items() - 1 do
			local current_faction = factions_trading_with:item_at(i);
						

		end;
	
	end;
end;


--function (re)applies region effect bundle to all capitals of given faction.
--expects faction():name() and a string for the effect bundle name.
function apply_effect_to_regions(faction, effect_bundle)
	local effectBundle = effect_bundle
	local thisFaction = cm:model():world():faction_by_key(faction);
	local regionList = thisFaction:region_list();
	output("TP: effect function called");
	
	for i = 0, regionList:num_items() - 1 do
		local current_region = regionList:item_at(i);
		output("TP: checking regions with tradee");
			
		if current_region:is_province_capital() then
			output("TP: applying bundle to capital.");
			cm:remove_effect_bundle_from_region(effectBundle, current_region:name());
			cm:apply_effect_bundle_to_region(effectBundle, current_region:name(), 0);
		end;
	end;
end;

--function removes region effect bundle to all capitals of given faction.
--expects faction():name() and a string for the effect bundle name.
function remove_effect_from_regions(faction, effect_bundle)
	local effectBundle = effect_bundle
	local thisFaction = cm:model():world():faction_by_key(faction);
	local regionList = thisFaction:region_list();
	output("TP: effect function called");
		
	for i = 0, regionList:num_items() - 1 do
			local current_region = regionList:item_at(i);
			output("TP: checking regions with non-tradee");
			
			if current_region:is_province_capital() then
				output("TP: removing bundle from capital.");
				cm:remove_effect_bundle_from_region(effectBundle, current_region:name());
			end;
		end;
end;

--script ends