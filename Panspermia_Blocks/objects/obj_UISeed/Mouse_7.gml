/// @description Insert description here
// You can write your code in this editor


if drag {
	var collided = instance_place(x,y,obj_UISeed)

	if collided != noone {
	
		//get nearest if multiple collided
		if is_array(collided) {
			var nearest = collided[0]
			for (var i = 1; i < array_length(collided); i++) {
				if point_distance(x,y,collided[i].x, collided[i].y) < point_distance(x,y,nearest.x, nearest.y)
					nearest = collided[i]
			}
			collided = nearest
		}
	
		addSeedValue(crossbreed_struct(structure, collided.structure))
		count--
		if count <= 0
			instance_destroy()
		collided.count--
		if collided.count <= 0
			instance_destroy(collided)
	
	}
}