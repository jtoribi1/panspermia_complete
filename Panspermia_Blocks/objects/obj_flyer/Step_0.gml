/// @description Insert description here
// You can write your code in this editor


while (place_meeting(x, y + 1, obj_block)) {
    y -= 1;
}


//mp_potential_step(obj_player.x, obj_player.y, 2, false)

var _found_player = mp_grid_path(global.mp_grid, path, x, y, obj_player_follow.x, obj_player_follow.y,choose(0,1))

if (_found_player)
{
	path_start(path, 2, path_action_stop, false)
}

