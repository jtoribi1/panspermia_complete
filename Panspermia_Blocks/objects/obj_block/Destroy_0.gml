/// @description Insert description here
// You can write your code in this editor

//for (var i = 0; i < array_length(grown_to); i++) {
//	if (instance_exists(grown_to[i])) {
//		if grown_to[i].block_id == 0 || grown_to[i].state == block_state.growing {
//			instance_destroy(grown_to[i])
//			array_delete(grown_to, i, 1)
//			i--
//		}
//	}
//}

var tilePos = getWorldCoords(x,y)
var adjacent = array_create(0)
array_push(adjacent, occupiedBy(tilePos[0] + 1, tilePos[1]))
array_push(adjacent, occupiedBy(tilePos[0] - 1, tilePos[1]))
array_push(adjacent, occupiedBy(tilePos[0], tilePos[1] + 1))
array_push(adjacent, occupiedBy(tilePos[0], tilePos[1] - 1))

for (var i = 0; i < array_length(adjacent); i++) {
	if instance_exists(adjacent[i]) {
		if adjacent[i].block_id == 0 && adjacent[i].state == block_state.grown {
			instance_destroy(adjacent[i])
		}
		else if adjacent[i].state == block_state.growing && adjacent[i].grown_from == id {
			instance_destroy(adjacent[i])
		}
	}
}

if (variable_instance_exists(id, "parent_manager") && instance_exists(parent_manager)) {
	
	var indexToDelete = array_get_index(parent_manager.initial_list, id)
	if indexToDelete != -1
		array_delete(parent_manager.initial_list, indexToDelete, 1)
	indexToDelete = array_get_index(parent_manager.ongoing_list, id)
	if indexToDelete != -1
		array_delete(parent_manager.ongoing_list, indexToDelete, 1)
		
	if (state == block_state.growing) {
		if !is_fruit(block_id)
			parent_manager.amount_grown--
	}
	//if deletedWhileGrowing {
	//	parent_manager.amount_grown++
	//}
	
	if parent_manager.total_grow_amount <= parent_manager.amount_grown {
		if array_length(parent_manager.initial_list) + array_length(parent_manager.ongoing_list) == 0
			instance_destroy(parent_manager)
	}
}