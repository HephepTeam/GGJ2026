shader_type canvas_item;

uniform float strength: hint_range(0.0, 1.0) = 0.0;

void fragment() {
	COLOR.a = mix(COLOR.a, 0.0, abs(sin(TIME * 2.0)) * strength);
}
