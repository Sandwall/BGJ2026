shader_type sky;
render_mode disable_fog;
uniform sampler2D tiling : filter_nearest, repeat_enable;
void sky() {
	vec2 uv = SCREEN_UV * 4.0;
	uv += mod(TIME, sqrt(2));
	COLOR = texture(tiling, uv).xyz;
	ALPHA = 0.2;
	// Called for every visible pixel in the sky background, as well as all pixels
	// in the radiance cubemap.
}
