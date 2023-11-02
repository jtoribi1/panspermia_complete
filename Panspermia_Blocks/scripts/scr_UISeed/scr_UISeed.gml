// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.UISeedOrdering = ds_list_create()
global.dragCount = pointer_null

global.UISEEDSPACING = 1.2

function getHomeCoords() {
	
	var total_width = ds_list_size(global.UISeedOrdering) * (sprite_width  * global.UISEEDSPACING)
	var starting = (camera_get_view_width(view_camera[0]) / 2) - (total_width / 2) + ((sprite_width  *global.UISEEDSPACING) / 2)
	
	var _x = starting + (sprite_width  *global.UISEEDSPACING) * ds_list_find_index(global.UISeedOrdering, id)
	var _y = camera_get_view_height(view_camera[0]) - sprite_height
	
		if hop == 1
			_y -= 300 //hop height
		else if selected
			_y -= 150 //selected height
	
	return [_x, _y]
}

function isHome() {
	var homeVal = getHomeCoords()
	return xDifference == homeVal[0] && yDifference == homeVal[1]
}

function nearest() {
	var myId = id
	var myDistance = point_distance(x,y,mouse_x,mouse_y)
	with obj_UISeed {
		if (id != myId) {
			if point_distance(id.x,id.y,mouse_x,mouse_y) < myDistance
				return false
		}
	}
	return true
}

function addSeedValue(structure_val) {
	var numSeedObjects = instance_number(obj_UISeed)
	for (var i = 0; i < numSeedObjects; i++) {
		var otherSeedObject = instance_find(obj_UISeed, i)
		if areStructsTheSame(otherSeedObject.structure, structure_val) {
			otherSeedObject.count++
			otherSeedObject.hop = 1
			return
		}
	}
	makeSeed(structure_val)
}

function getSelectedSeedObject() {
	var numSeedObjects = instance_number(obj_UISeed)
	for (var i = 0; i < numSeedObjects; i++) {
		var otherSeedObject = instance_find(obj_UISeed, i)
		if otherSeedObject.selected
			return otherSeedObject
	}
	return pointer_null
}

function makeSeed(structure_val) {
	
	var startX = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2
	var startY = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + sprite_height
	
	var newSeed = instance_create_layer(startX,startY,"SeedUI",obj_UISeed)
	with newSeed {
		hopWhenCreated = true
	
		ds_list_add(global.UISeedOrdering, id)
		
		structure = structure_val
		my_color = getColor(1, structure_val.color_tint)

		mx = -1;
		my = -1;
		drag = false;

		xDifference = x - camera_get_view_x(view_camera[0])
		yDifference = y - camera_get_view_y(view_camera[0])

	}
	return newSeed
}