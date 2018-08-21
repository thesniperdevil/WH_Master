--creates a button next to normal recruitment button on the button group army panel.
    function my_button_creation()
        local button_parent = find_uicomponent(core:get_ui_root(), "button_group_army");
        local my_recruit_button = Button.new("recruit_button", button_parent, "SQUARE", "ui/skins/default/icon_end_turn.png");
        local nearby_button = find_uicomponent(core:get_ui_root(), "button_recruitment");
         my_recruit_button:Resize(50,50);
         my_recruit_button:PositionRelativeTo(nearby_button, 0, 50);
    end;


--listener for character selection with the aim of creating a button simialr to recruitment.
core:add_listener(
    "my_character_selected",

    "CharacterSelected",

    function(context) return true end, --will be a check for a player character with an army in a vassal territory.
    
    function(context) 
        cm:callback(my_button_creation() ,0.1); --creates the button a moment after character is selected - to ensure paqnel has loaded.
    end,
    
    true
);


--ToDo
--add listener for my_recruit_button click? then create a pannel which will be copy/pasta of a blank recruitment panel.
