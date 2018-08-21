-----------------------------------------------------------------
--Colonial Trade, by thesniperdevil
-----------------------------------------------------------------

-- forcing trade with relevant colonies.
function force_trade()
	cm:force_make_trade_agreement("wh_main_emp_empire", "wh2_main_emp_new_world_colonies");
	cm:force_make_trade_agreement("wh_main_teb_tilea", "wh2_main_emp_new_world_colonies");
	cm:force_make_trade_agreement("wh_main_teb_estalia", "wh2_main_emp_new_world_colonies");
	cm:force_make_trade_agreement("wh_main_teb_border_princes", "wh2_main_emp_new_world_colonies");
	cm:force_make_trade_agreement("wh_main_brt_bretonnia", "wh2_main_emp_new_world_colonies");
	cm:force_make_trade_agreement("wh_main_brt_bretonnia", "wh2_main_brt_thegans_crusaders");
	cm:force_make_trade_agreement("wh_main_brt_bretonnia", "wh2_main_brt_knights_of_the_flame");
end;

--script initiation

function col_trade()
	if cm:is_new_game() then
		force_trade();
		out("COL: INITIALISE");
	end;
end;

