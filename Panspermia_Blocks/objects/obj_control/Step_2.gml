/// @description Insert description here
// You can write your code in this editor
global.selectionRadius = 1650
var on_seed = false
with(obj_UISeed){
	if(position_meeting(mouse_x, mouse_y, id)){
		on_seed = true
		break
	}
}

if(on_seed || point_distance(obj_player_follow.x, obj_player_follow.y, mouse_x, mouse_y) < global.selectionRadius){
	window_set_cursor(cr_handpoint);
}
else {
	window_set_cursor(cr_default);
}




