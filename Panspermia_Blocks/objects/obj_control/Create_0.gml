/// @description Insert description here
// You can write your code in this editor
global.mp_grid = 0

addSeedValue(get_starting_seed_struct())
var newBlock = placeBlock(0,0, [0,1], 1)
newBlock.speed_grow = 100