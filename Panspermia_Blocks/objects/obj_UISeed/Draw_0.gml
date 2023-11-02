/// @description Insert description here
// You can write your code in this editor


if(view_current == 0){
	if drag && place_meeting(x,y,obj_UISeed) {
		draw_sprite_ext(spr_seedHalo, 0, x, y, .75, .75, 0, my_color, 1)
	} else if selected && !drag && isHome() {
		draw_sprite_ext(spr_seedHalo, 0, x, y, 1.5, 1.5, 0, my_color, 1)
	} else {
		draw_sprite_ext(spr_seedHalo, 0, x, y, 1, 1, 0, my_color, 1)
	}

	if count > 1 {
		draw_set_color(c_white)
		draw_set_font(font_handwritten)
		draw_text(x,y,"x" + string(count))
	}	
}