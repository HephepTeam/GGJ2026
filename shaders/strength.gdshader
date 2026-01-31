shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_enable;
uniform float strength: hint_range(0.0, 1.0) = 0.0;
uniform float explosion: hint_range(0.0, 1.0) = 0.0;

float easeOutElastic(float t) {
	float c4 = (2.0 * PI) / 3.0;
	if (abs(t) < 0.0001) {
		return 0.0;
	}
	if (abs(t - 1.0) < 0.0001) {
		return 1.0;
	}

	return pow(2.0, -10.0 * t) * sin((t * 10.0 - 0.75) * c4) + 1.0;
}

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	//vec2 uv = SCREEN_UV + vec2(easeOutElastic(sin(TIME * 1.0)) * 0.00005 * explosion, 0.0);
	vec2 uv = SCREEN_UV;
	COLOR = texture(screen_texture, uv);
	float ratio = abs(sin(TIME * 2.0)) * strength;
	COLOR = mix(COLOR, vec4(length(COLOR.rgb) / 3.0, 0.0, 0.0, 1.0), ratio);
	COLOR.rgb = mix(COLOR.rgb, vec3(1.0, 0.98, 0.84) * rand(uv + sin(TIME)), explosion * 0.7);
}
