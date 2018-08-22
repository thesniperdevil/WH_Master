--This script defines a "vassal" object and its functions. Consider thes templates that are used by the master script.

vassal_object_manager = {} --# assume global vassal_object_manager: VRM --empty table populated by below constructer function.

------------------------------------------------------------------------
--this is a constructor function. It is used to define a new object. The object has a few arguments from the vassal name to details about spawning an army.
--v function(vassal_name: string, vassal_overlord: string, home_province: string,  ancillary_name: string, home_captial: string, home_regions: vector<string>, army_x: number, army_y: number, unit_list: string) --> VRM
function vassal_object_manager.new(vassal_name, vassal_overlord, home_province, ancillary_name, home_captial, home_regions, army_x, army_y, unit_list)
    local self = {}
    setmetatable(self, {__index = vassal_object_manager});
    --# assume self: VRM
    self.vassal_name = vassal_name;
    self.vassal_overlord = vassal_overlord;
    self.home_province = home_province;
    self.ancillary_name = ancillary_name;
    self.home_capital = home_captial;
    self.home_regions = home_regions;
    self.army_x = army_x;
    self.army_y = army_y;
    self.unit_list = unit_list;
    

    return self;
end;

------------------------------------------------------------------------
-- More specialised functions

-- Function checks a faction is a vassal, is alive and owns its origianl province (fundamental check for effects & ancillaries) 
--v function(self: VRM) --> boolean
    function vassal_object_manager.condition_check(self)
        local vassal_interface = cm:get_faction(self.vassal_name)
        local overlord_interface = cm:get_faction(self.vassal_overlord)
        
        if vassal_interface:is_dead() then

            return false -- the particular vassal is dead, CHECK FAILS.
        end;
        
        if not vassal_interface:is_vassal_of(overlord_interface) then

            return false -- the 'vassal' is not actually a vassal of the overlord, CHECK FAILS.
        end;
        
        if not vassal_interface:holds_entire_province(self.home_province, true) then

            return false -- the vassal does not own all of the given province, CHECK FAILS.
        end;

        return true -- above three checks passed, CHECK PASSES.
    end;

-- Function checks to see if a given region is part of the region list of the vassal object.
--v function(self: VRM, region_check: string) --> boolean
function vassal_object_manager.region_list(self, region_check)
    local region_list = self.home_regions;

    for i=1, #region_list do
        if region_list[i] == region_check then
            return true
        end;
    end;
    return false;

end;

-- function spawns an army defined army for the specified vassal object using definitions within the object itself.
--v function(self: VRM) 
    function vassal_object_manager.emerging_army(self)
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

-- Function checks to see if specific conditions are around to spawn an army to ressurect an empire faction and returns boolean.
--v function(self: VRM, my_bool: boolean) --> boolean
function vassal_object_manager.emergence_check(self, my_bool)
    local this_vassal_interface = cm:model():world():faction_by_key(self.vassal_name);
    local this_overlord_interface = cm:model():world():faction_by_key(self.vassal_overlord);
    local this_capital_interface = cm:get_region(self.home_capital)
       
    if my_bool == true then -- emp dilemma
        if this_vassal_interface:is_dead() and this_capital_interface:owning_faction():name() == self.vassal_overlord then
            return true
        else
            return false
        end;
    elseif my_bool == false then -- vas dilemma
        if this_vassal_interface:is_dead() and this_capital_interface:owning_faction():is_vassal_of(this_overlord_interface)then
            return true
        else
            return false
        end;
    else
        return false
    end;
end;

--function transfers all "home regions" for vassal object to that vassal so long as conditions are met.
--v function(self: VRM, my_bool: boolean)
function vassal_object_manager.region_transfer(self, my_bool)
    for i = 1, #self.home_regions do
        local this_region = cm:get_region(self.home_regions[i]);
        local this_overlord_interface = cm:model():world():faction_by_key(self.vassal_overlord);
        local owner_check = this_region:owning_faction():is_vassal_of(this_overlord_interface);

        if my_bool == 1 and this_region:owning_faction():name() == self.vassal_overlord then --means its emp dilemma & emp owns region
            cm:transfer_region_to_faction(self.home_regions[i], self.vassal_name);
        elseif my_bool == 0 and owner_check == true then --its vas dilemma and owner is vassal.
            cm:transfer_region_to_faction(self.home_regions[i], self.vassal_name);		
        end;
    end;
end;


------------------------------------------------------------------------
-- These functions will return elements of the object that may be needed for comparisons. Not all are used - but could be useful for submods.

-- returns the vassal province or edits the value before returning new value.
--v function(self: VRM, new_value: string?) --> string
    function vassal_object_manager.vassal_province(self, new_value)
        if not new_value then
            return self.home_province
        else
            self.home_province = new_value;
            return self.home_province
        end;
    end;

-- returns the vassal overlord or edits the value before returning new value.
--v function(self: VRM, new_value: string?) --> string
    function vassal_object_manager.return_vassal_overlord(self, new_value)
        if not new_value then
            return self.vassal_overlord
        else
            self.vassal_overlord = new_value;
            return self.vassal_overlord
        end;
    end;

-- returns the ancilalry name or edits the value before returning new value.
--v function(self: VRM, new_value: string) --> string
    function vassal_object_manager.return_ancillary_name(self, new_value)
        if not new_value then
            return self.ancillary_name
        else
            self.ancillary_name = new_value;
            return self.ancillary_name
        end;
    end;

-- returns the home capital or edits the value before returning new value.
--v function(self: VRM, new_value: string?) --> string
    function vassal_object_manager.return_home_capital(self, new_value)
        if not new_value then
            return self.home_capital
        else
            self.home_capital = new_value;
            return self.home_capital
        end;
    end;

-- returns the unit list or edits the value before returning new value.
--v function(self: VRM, new_value: string?) --> string
    function vassal_object_manager.return_unit_list(self, new_value)
        if not new_value then
            return self.unit_list
        else
            self.unit_list = new_value;
            return self.unit_list
        end;
    end;

-- returns the vassal name or edits the value before returning new value.
--v function(self: VRM, new_value: string?) --> string
    function vassal_object_manager.return_vassal_name(self, new_value)
        if not new_value then
            return self.vassal_name
        else
            self.vassal_name = new_value;
            return self.vassal_name
        end;
    end;

-- returns the lsit of home regions or edits the value before returning new value.
--v function(self: VRM, new_value: vector<string>?) --> vector<string>
    function vassal_object_manager.return_home_regions(self, new_value)
        if not new_value then
            return self.home_regions
        else
            self.home_regions = new_value
            return self.home_regions
        end;
    end;
-- returns the x coords or edits the value before returning new value.
--v function(self: VRM, new_value: number?) --> number
    function vassal_object_manager.return_army_x(self, new_value)
        if not new_value then
            return self.army_x
        else
        self.army_x = new_value    
            return self.army_x
        end;
    end;

-- returns the y coords or edits the value before returning new value.
--v function(self: VRM, new_value: number?) --> number
    function vassal_object_manager.return_army_y(self, new_value)
        if not new_value then
            return self.army_y
        else
        self.army_y = new_value    
            return self.army_y
        end;
    end;
