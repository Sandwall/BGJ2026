shader_type spatial;

uniform sampler2D tex : repeat_disable, filter_nearest_mipmap;
render_mode cull_disabled;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 col = texture(tex, UV);
	float fac = mix(1.0, 0.0, UV.y);
	
	ALBEDO = col.xyz * fac;
	EMISSION = ALBEDO;
	ALPHA = col.a * fac;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
