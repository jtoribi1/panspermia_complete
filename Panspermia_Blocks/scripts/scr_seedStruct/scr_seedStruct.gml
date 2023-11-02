// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.numBlockTypes = 10

global.FRUIT_ID = 10
global.MUTANT_FRUIT_ID = 11
global.SUPER_MUTANT_FRUIT_ID = 12

function is_fruit(num) {
	return num == global.FRUIT_ID || num == global.MUTANT_FRUIT_ID || num == global.SUPER_MUTANT_FRUIT_ID
}

function get_starting_seed_struct() {
	//nice starting platform
	struct =
	{
		block_types : [0,.5,0, .5,0, 0,0,0,0,0], //see spr_tiles
		dir_to_grow : [.4, 0, .4, .2], //right, up, left, down
		dir_priority : [], //-1: no priority. 0: right, 1: up, 2: left, 3: down
		color_tint : 255,
		//seed_spawning : [-1, 0], //where every other to spawn, what to spawn (see spr_tiles)
		grow_speed : .005,
		grow_speed_variation : 1.5,
		//grow_infinite : false, //not implemented, will cause crash
		fruit_amount : .9,
		grow_amount: 15,
		bifurcations: 2,
		//stop_early : .1, //not implemented yet
		//mold_resistant : false //not implemented yet
	}
	
	return struct
}

function get_completely_random_struct() {
	randomize()
	
	//make vines more common!
	b_types = interesting_noise_array(.5, 1.1, global.numBlockTypes)
	b_types[0] += random_range(8,10)
	b_types = normalizeArray(b_types)
	
	struct = 
	{
		block_types: b_types,
		//dir_to_grow: normalizeArray(interesting_noise_array(2, 3.1, 4)), //just changed this
		dir_to_grow: normalizeArray(random_array(1000, 4)),
		dir_priority: random_dir_priority(),
		color_tint: irandom(255),
		grow_speed: random_range(.001, .05),
		grow_speed_variation: random_range(1.5, 1.9),
		fruit_amount: random_range(0,.3),
		grow_amount: irandom_range(1,75),
		bifurcations: irandom_range(1,4)
	}
	return struct
}

function mutate_struct(to_copy) {
	randomize()
	var copied = copyStruct(to_copy)
	//TODO
	return copied
}

function crossbreed_struct(struct1, struct2) {
	//seed random gen with unique id of the two structs
	var string_array = array_create(0)
	array_push(string_array, uniqueStringify(struct1))
	array_push(string_array, uniqueStringify(struct2))
	array_sort(string_array, true)
	var unique_string = string_array[0] + string_array[1]
	random_set_seed(string_to_seed(unique_string)) //not really needed since only one thing uses random
	struct = 
	{
		block_types: normalizeArray(add_array(struct1.block_types, struct2.block_types)),
		dir_to_grow: normalizeArray(add_array(struct1.dir_to_grow, struct2.dir_to_grow)),
		dir_priority: random(1) < .5 ? struct1.dir_priority : struct2.dir_priority,
		color_tint: (struct1.color_tint + struct2.color_tint) / 2,
		grow_speed: (struct1.grow_speed + struct2.grow_speed) / 2,
		grow_speed_variation: (struct1.grow_speed_variation + struct2.grow_speed_variation) / 2,
		fruit_amount: (struct1.fruit_amount + struct2.fruit_amount) / 2,
		grow_amount: floor((struct1.grow_amount + struct2.grow_amount) / 2),
		bifurcations: random(1) < .5 ? struct1.bifurcations : struct2.bifurcations
	}
	return struct
}

function random_array(variation, length) {
	var array = array_create(0)
	for (var i = 0; i < length; i++) {
		array_push(array, random(variation))
	}
	return array
}

function string_to_seed(input) {
	var seed = 0;
	for (i = 0; i < string_byte_length(input); i += 1) {
	  seed = (seed + string_byte_at(input, i)) << 1;
	}
	return seed;
}

function interesting_noise_array(range1, range2, length) {
	var sinMultiplier = random_range(range1, range2);
	var blocks = array_create(0)
	for (var i = 0; i < length; i++) {
		array_push(blocks, sin(sinMultiplier * i) + 1)
	}
	blocks = array_shuffle(blocks)
	return blocks
}

function add_array(array1, array2) {
	var new_array = array_create(0)
	for (var i = 0; i < array_length(array1); i++) {
		array_push(new_array, array1[i] + array2[i])
	}
	return new_array
}

function normalizeArray(array) {
	var sum = 0
	for (var i = 0; i < array_length(array); i++) {
		sum += array[i]
	}
	for (var i = 0; i < array_length(array); i++) {
		array[i] /= sum
	}
	return array
}

function random_dir_priority() {
	var array = array_create(0)
	while array_length(array) < 3 {
		if random(1) < .3
			break
		var add = irandom(3)
		if !array_contains(array, add)
			array_push(array, add)
	}
	return array
}

function uniqueStringify(struc) {
	var keys = variable_struct_get_names(struc);
	array_sort(keys, true)
	var str = ""
	for (var i = array_length(keys)-1; i >= 0; --i) {
	    var k = keys[i];
	    var v = struc[$ k];
		str = str + string(v)
	    /* Use k and v here */
	}
	return str
}

function areStructsTheSame(struct1, struct2) {
	return uniqueStringify(struct1) == uniqueStringify(struct2)
}

function copyStruct(struct){
    var key, value;
    var newCopy = {};
    var keys = variable_struct_get_names(struct);
    for (var i = array_length(keys)-1; i >= 0; --i) {
            key = keys[i];
            value = struct[$ key];
            variable_struct_get(struct, key);
            variable_struct_set(newCopy, key, value)
    }
    return newCopy;
}