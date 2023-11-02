/// @description Insert description here
// You can write your code in this editor


if (image_xscale == -1 and instance_place(x-1, y, obj_block))
{
	image_xscale = (-1) * image_xscale 
	hspeed = (-1) * hspeed
}

if (image_xscale == 1 and instance_place(x+sprite_width/2, y, obj_block))
{
	image_xscale = (-1) * image_xscale 
	hspeed = (-1) * hspeed
}

if (image_xscale == 1 and !instance_place(x-sprite_width/2, y+sprite_height/2, obj_block))
{
	image_xscale = (-1) * image_xscale 
	hspeed = (-1) * hspeed
}

if (image_xscale == -1 and !instance_place(x-sprite_width/2, y+sprite_height/2, obj_block))
{
	image_xscale = (-1) * image_xscale 
	hspeed = (-1) * hspeed
}




