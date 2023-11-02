// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum dir {
	right,
	up,
	left,
	down
}

function dirToArray(d) {
	switch(d) {
		case dir.right: return [1, 0];
		case dir.left: return [-1, 0];
		case dir.up: return [0, -1];
		case dir.down: return [0, 1]
	}
}

function arrayToDir(a) {
	if (a[0] == 1 && a[1] == 0) return dir.right;
	if (a[0] == -1 && a[1] == 0) return dir.left;
	if (a[0] == 0 && a[1] == -1) return dir.up;
	if (a[0] == 0 && a[1] == 1) return dir.down;
}

function moveTowardPoint(startX, startY, endX, endY, increment) {
	if point_distance(startX, startY, endX, endY) <= increment
		return pointer_null
	
	var dx = endX - startX
	var dy = endY - startY
	var angle = arctan2(dy, dx)
	
	return [increment * cos(angle), increment * sin(angle)]
	
}