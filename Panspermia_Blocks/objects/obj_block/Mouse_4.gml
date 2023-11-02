/// @description Insert description here
// You can write your code in this editor

if(point_distance(obj_player_follow.x, obj_player_follow.y, x, y) < global.selectionRadius){
	if state == block_state.grown {
		if block_id != 0 {
			if ! position_meeting(x + 128, y + 128, obj_plant_grow_manager) {
				var selectedSeedObject = getSelectedSeedObject()
			
				if selectedSeedObject != pointer_null && selectedSeedObject.count > 0 {
			
					with instance_create_layer(x, y, "PlantedSeed", obj_plant_grow_manager) {
						centerPos = getWorldCoords(x,y)
					
						my_seed_struct = selectedSeedObject.structure
					
						selectedSeedObject.count--
						if selectedSeedObject.count <= 0
							instance_destroy(selectedSeedObject)
						//selectedSeedObject.count--
					
						image_blend = getColor(1, my_seed_struct.color_tint)

						initial_list = array_create(0) //wait until at least 1 room to grow before doing this
						ongoing_list = array_create(0)

						amount_grown = 0
						total_grow_amount = my_seed_struct.grow_amount
						if occupiedBy(centerPos[0], centerPos[1]).block_id == 3 //fertile soil
							total_grow_amount *= 2
					}
			
				}
			}
		}
	}
}