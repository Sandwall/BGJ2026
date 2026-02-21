shader_type spatial;

uniform sampler2D diffuse_texture: source_color;
uniform sampler2D roughness_metallic_emmission_texture;

uniform sampler2D emission_mask_texture : hint_default_white;

uniform float roughness_mult = 1.0;
uniform float metallic_mult = 1.0;
uniform float emission_mult = 1.0;

void fragment() {
	vec4 alpha_a = texture(diffuse_texture, UV).rgba;
	ALBEDO = alpha_a.rgb;
	
	vec3 rme = texture(roughness_metallic_emmission_texture, UV).xyz;
	float emission_mask = texture(emission_mask_texture, UV).r;
	ROUGHNESS = rme.x * roughness_mult;
	METALLIC = rme.y * metallic_mult;
	EMISSION = vec3(ALBEDO * emission_mask * rme.z);
}
