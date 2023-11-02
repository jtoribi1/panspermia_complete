/// @description Insert description here
// You can write your code in this editor

//debugging hitbox
//draw_set_color(c_red)
//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false);

if (state == block_state.growing) {
	shader_set(sha_grow)

	var uvs = sprite_get_uvs(sprite_index,image_index);
	shader_set_uniform_f(shader_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
	shader_set_uniform_f(shader_grow_progress, grow_progress);
	shader_set_uniform_f(shader_grow_direction, grow_direction[0], grow_direction[1])

	draw_self()
	shader_reset()
} else {
	draw_self()
}