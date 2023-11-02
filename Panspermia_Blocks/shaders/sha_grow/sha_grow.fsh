varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 shader_uvs;
uniform vec2 grow_direction;
uniform float grow_progress;

float mapFrom0To1(float x, float out_min, float out_max)
{
    float in_min = 0.0; // Use float literals
    float in_max = 1.0; // Use float literals
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void main()
{
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    
    int shader_uv_index_1, shader_uv_index_2;
    float texcoordToCompare;
    if (grow_direction.x != 0.0) { // Use float literals
        texcoordToCompare = v_vTexcoord.x;
        shader_uv_index_1 = 0;
        shader_uv_index_2 = 2;
    }
    else {
        texcoordToCompare = v_vTexcoord.y;
        shader_uv_index_1 = 1;
        shader_uv_index_2 = 3;
    }
	
	
    
    bool is_positive = true;
    float progress = grow_progress;
    if (grow_direction.x == -1.0 || grow_direction.y == -1.0) { // Use float literals
        progress = 1.0 - grow_progress; // Use float literals
        is_positive = false;
    }
    
    float map = mapFrom0To1(progress, shader_uvs[shader_uv_index_1], shader_uvs[shader_uv_index_2]);
    if (is_positive) {
        if (texcoordToCompare > map)
            gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0); // Use float literals
    } else {
        if (texcoordToCompare < map)
            gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0); // Use float literals
    }
}
