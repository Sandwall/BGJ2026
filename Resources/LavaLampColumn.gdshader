shader_type spatial;

uniform sampler2D diffuse_texture: source_color;
uniform float speed = 1.0;

void fragment() {
	vec2 uv = UV + vec2(0, TIME * speed);
	ALBEDO = texture(diffuse_texture, uv).rgb;
	
	EMISSION = ALBEDO;
}
