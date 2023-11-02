/// @description Insert description here
// You can write your code in this editor

// Create an empty list to store instances of "obj_water"
var spawner_instances = ds_list_create();

// Get all instances of "obj_water"
var _num = instance_number(obj_block);

// Loop through all instances of "obj_water"
for (var i = 0; i < _num; i++) {
    var spawner_instance = instance_find(obj_block, i)
	if(spawner_instance.block_id == 5){
	    // Calculate the position for "objectType" based on the distance and direction
	    var new_x = spawner_instance.x
	    var new_y = spawner_instance.y - 50

	    // Create "objectType" at the calculated position
	    instance_create_layer(new_x, new_y, "Instances", objectType);
	}
}

// Destroy the list
ds_list_destroy(spawner_instances);

// Reset the alarm[0] for the next spawn
alarm[0] = spawnInterval;




