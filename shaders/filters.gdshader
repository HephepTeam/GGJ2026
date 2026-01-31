shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_nearest_mipmap;
uniform vec2 player_position = vec2(0.0, 0.0);
uniform float speed: hint_range(0.0, 1.0) = 0.0;
uniform float strength: hint_range(0.0, 1.0) = 0.0;
uniform float explosion: hint_range(0.0, 1.0) = 0.0;

group_uniforms scanline_wiggle;
uniform float color_offset_multiplier: hint_range(0.0, 0.1) =  0.004;
uniform float black_offset_multiplier: hint_range(0.0, 0.1) = 0.1;
uniform float color_offset: hint_range(-0.1, 0.1) = 0.002;

group_uniforms blur;
uniform float blur_amount: hint_range(0.0, 3.0, 0.1) = 1.0;

varying vec2 player_position_screen_space;

float rand(vec2 uv, float offset){
    return fract(sin(dot(uv * offset, vec2(12.9898, 78.233))) * 43758.5453);
}

vec3 rgb_to_yuv(vec3 rgb) {
	const mat3 RGB_TO_YUV = mat3(
		vec3(0.299, 0.587, 0.114),
		vec3(-0.14713, -0.28886, 0.436),
		vec3(.615, -0.51499, -0.10001)
		);
	return rgb * RGB_TO_YUV;
}

vec3 yuv_to_rgb(vec3 yuv) {
	const mat3 YUV_TO_RGB = mat3(
		vec3(1.0, 0.0, 1.13983),
		vec3(1.0, -0.39465, -0.58060),
		vec3(1.0, 2.03211, 0.0)
		);
	return clamp(yuv * YUV_TO_RGB, vec3(0.0), vec3(1.0));
}

vec4 vhsFilter(vec2 uv, vec2 screen_uv) {
	float x_offset = color_offset + rand(vec2(floor(uv.y * 487.0), fract(uv.y * 487.0)), TIME) * color_offset_multiplier;
	float black_offset = rand(vec2(floor(uv.y * 487.0), fract(uv.y * 487.0)), TIME + 69.420) * (black_offset_multiplier * 0.025);

	vec4 color1 = textureLod(screen_texture, screen_uv + vec2(black_offset,0.0), 0.0);

	vec4 color2 = textureLod(screen_texture, screen_uv + vec2(x_offset,0.0), blur_amount);
	vec3 yuv1 = rgb_to_yuv(color1.rgb);
	vec3 yuv2 = rgb_to_yuv(color2.rgb);

	return vec4(yuv_to_rgb(vec3(yuv1.x, yuv2.yz)), color1.a);
}

// From David Hoskins (MIT licensed): https://www.shadertoy.com/view/4djSRW
vec3 hash33(vec3 p3) {
	p3 = fract(p3 * vec3(0.1031, 0.1030, 0.0973));
	p3 += dot(p3, p3.yxz + 33.33);
	return fract((p3.xxy + p3.yxx) * p3.zyx) - 0.5;
}

// From Nikita Miropolskiy (MIT licensed): https://www.shadertoy.com/view/XsX3zB
float simplex3d(vec3 p) {
	vec3 s = floor(p + dot(p, vec3(1.0 / 3.0)));
	vec3 x = p - s + dot(s, vec3(1.0 / 6.0));
	vec3 e = step(vec3(0), x - x.yzx);
	vec3 i1 = e * (1.0 - e.zxy);
	vec3 i2 = 1.0 - e.zxy * (1.0 - e);
	vec3 x1 = x - i1 + 1.0 / 6.0;
	vec3 x2 = x - i2 + 1.0 / 3.0;
	vec3 x3 = x - 0.5;
	vec4 w = max(0.6 - vec4(dot(x, x), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0);
	w *= w;
	return dot(vec4(dot(hash33(s), x), 
	                dot(hash33(s + i1), x1), 
	                dot(hash33(s + i2), x2),  
	                dot(hash33(s + 1.0), x3)) * w * w, vec4(52));
}

vec4 speedLines(vec4 input_color, vec2 fragcoord, vec2 resolution) {
	if (speed < 0.0001) {
		return input_color;
	}
	float mr = min(resolution.x, resolution.y);
	vec2 uv = (fragcoord * 2.0 - resolution) / mr * 0.5;
	
	// Applies roughly the same displacement as on the VHS filter.
	uv += rand(vec2(floor(uv.y * 487.0), fract(uv.y * 487.0)), TIME + 69.420) * (black_offset_multiplier * 0.025);
	
	vec2 p = vec2(0.5) + normalize(uv) * min(length(uv), 0.05);
	vec3 p3 = 13.0 * vec3(p.xy, 0) + vec3(0, 0, TIME * mix(0.05, 0.2, speed));
	float noise = simplex3d(p3 * 32.0) * 0.5 + 0.5;
	float dist = abs(clamp(length(uv) / (12.0 - speed * 5.0), 0.0, 1.0) * noise * 2.0 - 1.0);
	const float e = 0.3;
	float stepped = smoothstep(e - 0.5, e + 0.5, noise * (1.0 - pow(dist, 4.0)));
	float final = smoothstep(e - 0.05, e + 0.05, noise * stepped);
	return clamp(input_color + vec4(vec3(sign(final)) * mix(0.1, 0.5, speed), 1.0), 0.0, 1.0);
}

void vertex() {
	player_position_screen_space = (CANVAS_MATRIX * vec4(player_position, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 screen_uv = SCREEN_UV;
	vec2 from_center = screen_uv - vec2(0.5);
	screen_uv = vec2(0.5) + from_center * (1.0 + 0.1 * speed * abs(sin(TIME * speed * 5.0)));
	COLOR = vhsFilter(UV, screen_uv);
	vec2 fragcoord =  FRAGCOORD.xy - (player_position_screen_space - 0.5 / SCREEN_PIXEL_SIZE);
	COLOR = speedLines(COLOR, fragcoord, 1.0 / SCREEN_PIXEL_SIZE);
	COLOR.rgb = mix(COLOR.rgb, vec3(1.0, 0.98, 0.84) * rand(screen_uv, TIME), explosion * 0.7);
	float ratio = abs(sin(TIME * 2.0)) * strength;
	COLOR = mix(COLOR, vec4(length(COLOR.rgb) / 3.0, 0.0, 0.0, 1.0), ratio);
}
