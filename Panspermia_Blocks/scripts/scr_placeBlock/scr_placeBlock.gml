// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getTileCoords (tileX, tileY) {
	return [tileX * 256, tileY * 256]
}
function getWorldCoords(worldX, worldY) {
	return [worldX / 256, worldY / 256]
}
function isOccupied(tileX, tileY) {
	coord1 = getTileCoords(tileX, tileY)
	worldCoord = [coord1[0] + 128, coord1[1] + 128]
	return position_meeting(worldCoord[0], worldCoord[1], obj_block)
}
function occupiedBy(tileX, tileY) {
	coord1 = getTileCoords(tileX, tileY)
	worldCoord = [coord1[0] + 128, coord1[1] + 128]
	return instance_position(worldCoord[0], worldCoord[1], obj_block)
}
//function getCollisionTileCoords (tileX, tileY) {
//	return [tileX * 256 + 128, tileY * 256 + 128]
//}

function placeBlock (x, y, grow_dir, b_id) {
	coords = getTileCoords(x, y);
	new_block = instance_create_layer(coords[0], coords[1], "Instances",obj_block)
	
	with new_block {
		block_id = b_id //change to enum represeting block type
		grow_direction = grow_dir
		grow_progress = 0
		state = block_state.growing
	
		image_speed = 0
		image_index = 0
		
		shader_uvs = shader_get_uniform(sha_grow, "shader_uvs")
		shader_grow_direction = shader_get_uniform(sha_grow, "grow_direction")
		shader_grow_progress = shader_get_uniform(sha_grow, "grow_progress")
	}
	return new_block
}