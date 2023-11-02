/// @description Insert description here
// You can write your code in this editor


//if state == block_state.grown {
//	var manage_to_destroy = instance_position(x + 128, y + 128, obj_plant_grow_manager)
//	if (manage_to_destroy != noone) {
//		manage_to_destroy.sprite_index = -1
//		manage_to_destroy.mask_index = -1
//	}

//	instance_destroy()
//}
if(point_distance(obj_player_follow.x, obj_player_follow.y, x, y) < global.selectionRadius){
	var manage_to_destroy = instance_position(x + 128, y + 128, obj_plant_grow_manager)
	if (manage_to_destroy != noone) {
		manage_to_destroy.sprite_index = -1
		manage_to_destroy.mask_index = -1
	}

	if state == block_state.growing {
		if (variable_instance_exists(id, "parent_manager") && instance_exists(parent_manager)) {
			if !is_fruit(block_id)
				parent_manager.amount_grown++
		}
	}

	if is_fruit(block_id) {
		with instance_create_layer(x+128,y+128,"SeedUI",obj_seed_get) {
			if other.block_id == global.FRUIT_ID {
				seed_struct_to_pass = other.seed_struct
			} else if other.block_id == global.MUTANT_FRUIT_ID {
				seed_struct_to_pass = mutate_struct(other.seed_struct)
			} else if other.block_id == global.SUPER_MUTANT_FRUIT_ID {
				seed_struct_to_pass = get_completely_random_struct()
			}
			image_blend = getColor(1, seed_struct_to_pass.color_tint)
		}
	}
	

	instance_destroy()
}