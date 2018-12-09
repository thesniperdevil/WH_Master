--This script allows you to create objects that define a faction, the territories it considers "native lands" and territories it considers "rightfuly belonging to them or their kin"
--it then set up listeners that would fire at the end of each defined factions turn, and check all regions and then apply diploamtic malus to the region owners, if they did not meet a criteria.
-- unfortuantely, there is no percieved way to incremnet diplomatic malus via scripts, and effect bundles do not stack.
-- You may be able to set thresholds similar to "great power" though.


local faction_region_manager = {} --# assume faction_region_manager: FRM
local object_list = {} --:vector<FRM>

--constructor function allows defining of objects.
--v function(faction: string, subculture: string, native_land: vector<string>, cultural_land: vector<string>, native_effect: string, cultural_effect: string) --> FRM
function faction_region_manager.new(faction, subculture, native_land, cultural_land, native_effect, cultural_effect)
    local self = {}
    setmetatable(self, {__index = faction_region_manager});
    --# assume self: FRM
    self.faction = faction;
    self.subculture = subculture;
    self.native_land = native_land;
    self.cultural_land = cultural_land;
    self.native_effect = native_effect; --was planning to use effect bundles to do siploamtic malus but they dont stack :(
    self.cultural_effect = cultural_effect; --was planning to use effect bundles to do siploamtic malus but they dont stack :(
    table.insert(object_list, self);
    out("TP_FRM: New genefaction entered "..tostring(self.faction));
    return self;
end;

-- function applies diploamtic malus on a faction if it owns a region this faction considers theirs by rights.
--v function(self: FRM)
function faction_region_manager.native_check(self)
    out("TP_FRM: native lands being checked for "..tostring(self.faction));
    for i = 1, #self.native_land do
        local this_region = cm:get_region(self.native_land[i]);
        local this_owner = this_region:owning_faction():name();
        out("TP_FRM: "..tostring(self.native_land[i]).." owned by "..tostring(this_owner));

        if this_owner ~= self.faction then
            out("TP_FRM: applying native debuff effect");
              -- do something to apply diplomatic malus
        end;
    end;
end;

-- function applies a diplomatic malus if a region is not woend by right culture.
--v function(self: FRM)
    function faction_region_manager.culture_check(self)
        out("TP_FRM: cultural lands being checked for "..tostring(self.faction));
        for i = 1, #self.cultural_land do
            local this_region = cm:get_region(self.cultural_land[i]);
            local this_owner = this_region:owning_faction();
            out("TP_FRM: "..tostring(self.cultural_land[i]).." owned by "..tostring(this_owner:name() ));
    
            if this_owner:subculture() ~= self.subculture then
                out("TP_FRM: applying culural debuff effect");
                -- do something to apply diplomatic malus
            end;
        end;
    end;

-- function calls the checks for teh faction whos turn just ended.  
 --v function(context: FRM)
    function region_checks(context)
        out("TP_FRM: performing region checks now");
        context:native_check();
        context:culture_check();
    end;

    -- function sets up a listener for each faction entered.
--v function(self: FRM)
    function faction_region_manager.listener(self)
        local listener_name = "frm_"..self.faction.."_listener"
        core:add_listener(
            listener_name, 
            "FactionTurnEnd", 
            function(context) return context:faction():name() == self.faction and not context:faction():is_human() end, -- the player don't care about this!
            function(context)
                out("TP_FRM: Listener Fired"); 
                region_checks(self)
            end, 
            true)
    end;

    -- defines the regions a faction /culture considers "native" and what is considered "cultural"
    local dawi = faction_region_manager.new("wh_main_dwf_dwarfs", "wh_main_sc_dwf_dwarfs", 
    {"wh_main_the_silver_road_karaz_a_karak","wh_main_the_silver_road_mount_squighorn","wh_main_the_silver_road_the_pillars_of_grungni"},
     {"wh_main_reikland_altdorf"}, "test_effect", "test_effect_2")

    local empire = faction_region_manager.new("wh_main_emp_empire", "wh_main_sc_emp_empire", 
    {"wh_main_reikland_altdorf","wh_main_reikland_grunburg","wh_main_reikland_eilhart","wh_main_reikland_helmgart"},
     {}, "test_effect", "test_effect_2")


-- start function goes through the objects that are entered and sets up the listeners.
function region_politics()
    out("TP_FRM: INITIALISE");
    for i = 1, #object_list do
        object_list[i]:listener();
    end
end;
