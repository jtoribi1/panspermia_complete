/// @description Insert description here
// You can write your code in this editor

var copter_perc = obj_player_follow.copter_power/10
if instance_exists(obj_player_follow)
{
    var barWidth = 256;
    var barHeight = 32;
    var screenWidth = view_wport[0];
    var screenHeight = view_hport[0];
    var healthBarX = screenWidth - barWidth - 8; // 8 pixels from the right edge
    var healthBarY = 8; // 8 pixels from the top edge
    var powerBarX = screenWidth - barWidth - 8;
    var powerBarY = 50; // Adjust the vertical position as needed
    
    draw_healthbar(healthBarX, healthBarY, healthBarX + barWidth, healthBarY + barHeight, obj_player_follow.hp, c_black, c_red, c_lime, 0, true, true);
    draw_healthbar(powerBarX, powerBarY, powerBarX + barWidth, powerBarY + barHeight, copter_perc, c_black, c_blue, c_yellow, 0, true, true);
	//audio_play_sound(Background_theme, 2, true)
	
}




