shader_type spatial;

uniform sampler2D diffuse_texture: source_color;
uniform sampler2D roughness_metallic_emmission_texture;

void fragment() {
	ALBEDO = texture(diffuse_texture, UV).rgb;
	
	vec3 rme = texture(roughness_metallic_emmission_texture, UV).xyz;
	ROUGHNESS = rme.x;
	METALLIC = rme.y;
	EMISSION = vec3(ALBEDO * rme.z);
}
