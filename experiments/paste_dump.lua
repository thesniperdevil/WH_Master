lord_object_manager = {} --# assume global lord_object_manager: LO
lord_holder = {} --: vector<LO>

    --v function(lord_subtype: string, lord_faction: string, lord_army_list: vector<string> ) --> LO
    function lord_object_manager.new(lord_subtype, lord_faction, lord_army_list)
        local self = {}
        setmetatable(self, {__index = lord_object_manager});
        --# assume self: LO
        self.lord_subtype = lord_subtype;
        self.lord_faction = lord_faction; 
        self.lord_army_list = lord_army_list; 
        table.insert(lord_holder, self);         
        out("AEX: We've made a new table for the lord: "..self.lord_subtype);
        return self; 
    end;


--v function(self: LO) --> CA_CHAR
    function lord_object_manager.get_lord(self) -- this function is expecting a 'table instance' for its input.
        local this_faction = cm:get_faction(self.lord_faction);
        local this_char_list = this_faction:character_list();

        for i = 0, this_char_list:num_items() -1 do
            local current_char = this_char_list:item_at(i);
            if current_char:character_subtype_key() == self.lord_subtype then
                out("AEX: returning character");
                return current_char;
            end;
            
        end;
       
    end;

    --v function(self: LO, current_char: CA_CHAR)
    function lord_object_manager.new_army(self, current_char)
        local char_cqi = cm:char_lookup_str(current_char:cqi())
        out("AEX: adding new units");
        for i = 1, #self.lord_army_list do
            local this_unit = self.lord_army_list[i];
            cm:grant_unit_to_character(char_cqi, this_unit);
        end;
    end;

------------- metatable defining stuff ends----------------


-- we have set up 3 "instances" of our meta table. for Vlad, isabella and manfred

local vladdy_boi = lord_object_manager.new("dlc04_vmp_vlad_con_carstein","wh_main_vmp_schwartzhafen",{"wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_cav_black_knights_0", "wh_main_vmp_mon_vargheists", "wh_main_vmp_mon_vargheists"});
local issi_gal = lord_object_manager.new("pro02_vmp_isabella_von_carstein","wh_main_vmp_schwartzhafen",{"wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_cav_black_knights_0", "wh_main_vmp_mon_vargheists", "wh_main_vmp_mon_vargheists"});
local manny_boi = lord_object_manager.new("vmp_mannfred_von_carstein", "wh_main_vmp_vampire_counts", {"wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_inf_grave_guard_0", "wh_main_vmp_inf_grave_guard_0", "wh_main_vmp_inf_cairn_wraiths"});
local hella_boi = lord_object_manager.new("dlc04_vmp_helman_ghorst","wh_main_vmp_vampire_counts",{"wh_main_vmp_inf_zombie", "wh_main_vmp_inf_zombie", "wh_main_vmp_inf_zombie", "wh_main_vmp_inf_crypt_ghouls", "wh_main_vmp_inf_crypt_ghouls", "wh_dlc04_vmp_veh_corpse_cart_0", "wh_dlc04_vmp_veh_corpse_cart_0"});
local kemmy_boi = lord_object_manager.new("vmp_heinrich_kemmler","wh_main_vmp_vampire_counts",{"wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_inf_grave_guard_0", "wh_main_vmp_inf_grave_guard_0", "wh_main_vmp_inf_cairn_wraiths"});
local reddy_boi = lord_object_manager.new("wh_dlc05_vmp_red_duke","wh_main_vmp_mousillon",{"wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_inf_skeleton_warriors_1", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_mon_fell_bats", "wh_main_vmp_cav_black_knights_0", "wh_main_vmp_cav_black_knights_0", "wh_main_vmp_veh_black_coach"});

function vmp_army_tweaks()
    for i = 1, #lord_holder do
        local current_lord_object = lord_holder[i];
        local current_char = current_lord_object:get_lord();

        if current_char ~= nil then
            cm:remove_all_units_from_general(current_char);
            current_lord_object:new_army(current_char);
        end;
    end;
end;
