shader_type canvas_item;
render_mode blend_mix;

uniform float strength: hint_range(0.0, 1.0) = 0.0;

void fragment() {
	float ratio = abs(sin(TIME * 2.0)) * strength;
	COLOR.a *= (1.0 - smoothstep(0.1, 0.2, COLOR.r) * ratio);
}
