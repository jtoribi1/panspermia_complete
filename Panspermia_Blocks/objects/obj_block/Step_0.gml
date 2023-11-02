/// @description Insert description here
// You can write your code in this editor

if (state == block_state.growing) {
	grow_progress += speed_grow
	
	if (grow_progress >= 1) {
		grow_progress = 1
		state = block_state.grown
		image_index = block_id
		if block_id != 0
			solid = true
		block_done_growing()
	}
}