/// @description Insert description here
// You can write your code in this editor

obj_player_follow.hp -= 30

if (obj_player_follow.hp <= 30)
{
	instance_destroy(other)
}
else
{
//audio_play_sound(Player_hurt, 1, false)
instance_destroy()	
}





