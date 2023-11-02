// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//idType:
//0: block tint
//1: seed halo
function getColor(idType, tint) {
	switch (idType) {
		case 0:
			//return make_colour_hsv(128, 128, tint)
			return make_color_hsv(tint, 255, 255)
		case 1:
			//return make_color_hsv(100, 100, tint)
			return make_color_hsv(tint, 255, 255)
	}
}