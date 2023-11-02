/// @description Insert description here
// You can write your code in this editor

var _width = ceil(room_width / 256)
var _height = ceil(room_height / 256)

global.mp_grid = mp_grid_create(0 ,0, _width, _height, 256, 256)

mp_grid_add_instances(global.mp_grid, obj_block, false)





