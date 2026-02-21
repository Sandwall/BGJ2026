shader_type spatial;

uniform sampler2D albedo_texture;
uniform float shake_amount = 0;
uniform float shake_speed = 1;

varying vec3 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	
	float time = TIME * shake_speed + NODE_POSITION_WORLD.x + NODE_POSITION_WORLD.y + NODE_POSITION_WORLD.z;
	VERTEX += vec3(sin(time * 0.3), sin(time * 0.4 + 3.3), sin(time + 16.2)) * shake_amount;
}

void fragment() {
	ALBEDO = texture(albedo_texture, UV).rgb;
	
	float cutoff = smoothstep(0, -30, world_position.y);
	ALBEDO = mix(ALBEDO, vec3(0.0), cutoff);
	ALPHA = 1.0 - cutoff;
	
	EMISSION = ALBEDO;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
