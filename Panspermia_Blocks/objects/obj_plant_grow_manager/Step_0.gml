/// @description Insert description here
// You can write your code in this editor


if sprite_index != -1 {
	var new_growths = start_growing(my_seed_struct, my_seed_struct.bifurcations - array_length(initial_list), getWorldCoords(x,y))
	for (var i = 0; i < array_length(new_growths); i++) {
		array_push(initial_list, new_growths[i])
	}
}