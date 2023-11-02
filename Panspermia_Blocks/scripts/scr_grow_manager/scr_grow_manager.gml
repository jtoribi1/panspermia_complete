// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function start_growing(struc, bifur, tileCoord) { //should return list of all created blocks
	var block_list = array_create(0)
	
	//var tileCoord = getWorldCoords(x, y)
	
	var blocks_created = 0
	var room_left = roomLeft(struc.dir_to_grow, tileCoord[0], tileCoord[1])
	var block_at_this_pos = occupiedBy(tileCoord[0], tileCoord[1])
	
	//show_debug_message("START")
	while (blocks_created < min(room_left, bifur, total_grow_amount - amount_grown)) {
		
		var priority_dir = getOpenPriority(struc.dir_priority, tileCoord[0], tileCoord[1])
		var random_dir
		if priority_dir == pointer_null
			random_dir = dirToArray(getRandomOpenDir(struc.dir_to_grow, tileCoord[0], tileCoord[1]))
		else
			random_dir = priority_dir
			
		var random_block_type = getRandomBlockType(struc.block_types)
		var new_block = placeBlock(tileCoord[0] + random_dir[0], tileCoord[1] + random_dir[1], [random_dir[0],random_dir[1]], random_block_type)
		new_block.parent_manager = id
		new_block.seed_struct = struc
		
		randomize()
		new_block.speed_grow = random_range(1, struc.grow_speed_variation) * struc.grow_speed
		
		blocks_created++
		amount_grown++
	
		array_push(block_list, new_block.id)
		array_push(block_at_this_pos.grown_to, new_block.id)
		new_block.grown_from = block_at_this_pos.id
		
		new_block.image_blend = make_colour_hsv(100, 100, struc.color_tint);
		
		new_block.check_for_fruit = true
		
		//do grown from as well
		//when delete, always check if manager exists and subtract from amount_grown
			//ONLY if block hadnt fully grown yet
		//count will increase auto over time to prevent infinite abuse (use stop_early in struct)
		
	}
	
	//same code basically as above copied for fruits
	var placesOpen = roomLeft(struc.dir_to_grow, tileCoord[0], tileCoord[1])
	randomize()
	for (var i = 0; i < placesOpen; i++) {
		if random(1) <= struc.fruit_amount {
			random_dir = dirToArray(getRandomOpenDir(struc.dir_to_grow, tileCoord[0], tileCoord[1]))
			
			var fruitType //This controls the rarity of fruit, mutant fruit, and super mutant fruit
			var randomRoll = random(1)
			if randomRoll <= .6
				fruitType = global.FRUIT_ID
			else if randomRoll <= .9
				fruitType = global.MUTANT_FRUIT_ID
			else
				fruitType = global.SUPER_MUTANT_FRUIT_ID
			
			var new_block = placeBlock(tileCoord[0] + random_dir[0], tileCoord[1] + random_dir[1], [random_dir[0],random_dir[1]], fruitType)
			
			new_block.parent_manager = id
			new_block.seed_struct = struc
			new_block.speed_grow = random_range(1, struc.grow_speed_variation) * struc.grow_speed
			array_push(block_at_this_pos.grown_to, new_block.id)
			new_block.grown_from = block_at_this_pos.id
			new_block.image_blend = getColor(0, struc.color_tint)
			new_block.check_for_fruit = false
			
		}
	}
	
	//amount_grown += array_length(block_list)
	return block_list
}

//called within obj_block
function block_done_growing() {
	
	if (variable_instance_exists(id, "parent_manager") && instance_exists(parent_manager)) {
		
		if (check_for_fruit || (parent_manager.total_grow_amount - parent_manager.amount_grown > 0) && !is_fruit(block_id)) {
			if parent_manager.total_grow_amount - parent_manager.amount_grown <= 0
				check_for_fruit = false
			var new_grow_pos = getWorldCoords(x,y)
			with parent_manager {
				var new_growths = start_growing(my_seed_struct, my_seed_struct.bifurcations, new_grow_pos)
				for (var i = 0; i < array_length(new_growths); i++) {
					array_push(ongoing_list, new_growths[i])
				}
			}
		}
		
		var index = array_get_index(parent_manager.initial_list, id)
		if index != -1 {
			array_delete(parent_manager.initial_list, index, 1)
			if array_length(parent_manager.initial_list) == 0 {
				with parent_manager {
					sprite_index = -1
					mask_index = -1
				}
			}
		}
		
		var index = array_get_index(parent_manager.ongoing_list, id)
		if index != -1
			array_delete(parent_manager.ongoing_list, index, 1)
		
		if array_length(parent_manager.initial_list) + array_length(parent_manager.ongoing_list) == 0
			instance_destroy(parent_manager)
		
	}
	
}

//right, up, left, down
function roomLeft(directionProbArray, xTile, yTile) {
	var count = 0
	if directionProbArray[0] > 0 && ! isOccupied(xTile + 1, yTile) count++
	if directionProbArray[1] > 0 && ! isOccupied(xTile, yTile - 1) count++
	if directionProbArray[2] > 0 && ! isOccupied(xTile - 1, yTile) count++
	if directionProbArray[3] > 0 && ! isOccupied(xTile, yTile + 1) count++
	return count
}
function isAnyRoomLeft(directionProbArray, xTile, yTile) {
	return roomLeft(directionProbArray, xTile, yTile) > 0
}

function getRandomDir(directionProbArray) {
	randomize()
	var ran = random(1)
	var arr = array_create(4,0)
	arr[0] = directionProbArray[0]
	for (var i = 1; i < 4; i++) {
		arr[i] = arr[i-1] + directionProbArray[i]
	}
	if ran <= arr[0] return dir.right
	if ran <= arr[1] return dir.up
	if ran <= arr[2] return dir.left
	return dir.down
}
function getRandomOpenDir(directionProbArray, tileX, tileY) {
	var direc;
	var direcInArray;
	do {
		direc = getRandomDir(directionProbArray)
		direcInArray = dirToArray(direc)
	} until (! isOccupied(tileX + direcInArray[0], tileY + direcInArray[1]))
	return direc;
}
 // 0: right, 1: up, 2: left, 3: down
function getOpenPriority(priorities, tileX, tileY) {
	for (var i = 0; i < array_length(priorities); i++) {
		if priorities[i] == 0 && !isOccupied(tileX + 1, tileY) return [1,0]
		if priorities[i] == 1 && !isOccupied(tileX, tileY - 1) return [0,-1]
		if priorities[i] == 2 && !isOccupied(tileX - 1, tileY) return [-1,0]
		if priorities[i] == 3 && !isOccupied(tileX, tileY + 1) return [0,1]
	}
	return pointer_null
}

function getRandomBlockType(blockTypeProbArray) {
	randomize()
	var ran = random(1)
	var arr = array_create(global.numBlockTypes, 0)
	arr[0] = blockTypeProbArray[0]
	for (var i = 1; i < global.numBlockTypes; i++) {
		arr[i] = arr[i-1] + blockTypeProbArray[i]
	}
	for (var i = 0; i < global.numBlockTypes; i++) {
		if ran <= arr[i] return i
	}
}