/// @description Insert description here
// You can write your code in this editor

var _camera = view_camera[ 0 ]
camera_set_view_pos(_camera, x - view_wview / 2, y - view_hview / 2)

var _minimap = view_camera[1]
camera_set_view_pos(_minimap, x - view_wview[1] /2, y - view_hview[1] / 2)

//this must be done in end step, but also after camera movement, so done here
with obj_UISeed {
	if (!drag) {

	
	cx = camera_get_view_x(view_camera[0])
	cy = camera_get_view_y(view_camera [0])
	x = cx + xDifference
	y = cy + yDifference
	
	//var home = getHomeCoords()
	//xDifference = home[0]
	//yDifference = home[1] //CODE HERE
	

		var home = getHomeCoords()
		var moveSpeed = 100 //regular return speed
//was here
		if hop == 1 {
			moveSpeed = 20 //speed up hop
		} else if hop == 2 {
			moveSpeed = 20 //speed down hop
		}
		var moveTowards = moveTowardPoint(xDifference, yDifference, home[0], home[1], moveSpeed)
		if moveTowards == pointer_null {
			xDifference = home[0]
			yDifference = home[1]
			if hop == 1 hop = 2
			else if hop == 2 hop = 0
			if hopWhenCreated {
				hop = 1
				hopWhenCreated = false
			}
		} else {
			xDifference += moveTowards[0]
			yDifference += moveTowards[1]
		}
	
   if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id) && global.dragCount == pointer_null && nearest() && hop == 0 && !hopWhenCreated) {
      drag = true;
	  global.dragCount = id
      mx = x - mouse_x;
      my = y - mouse_y;
   }
}
else {
   x = mouse_x + mx;
   y = mouse_y + my;
	if (!mouse_check_button(mb_left)) {
      drag = false;
	global.dragCount = pointer_null
		xDifference = x - camera_get_view_x(view_camera[0])
		yDifference = y - camera_get_view_y(view_camera[0])
   }
}

}




