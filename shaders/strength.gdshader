shader_type canvas_item;

uniform float strength: hint_range(0.0, 1.0) = 0.0;
uniform sampler2D screen_texture: hint_screen_texture;

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	float ratio = abs(sin(TIME * 2.0)) * strength;
	COLOR = mix(COLOR, vec4(length(COLOR.rgb) / 3.0, 0.0, 0.0, 1.0), ratio);
}
