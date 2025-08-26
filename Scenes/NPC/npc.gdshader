shader_type canvas_item;

uniform vec4 find_color : source_color;
uniform vec4 target_color : source_color;

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	if (pixel_color.rgb == vec3(0, 0, 1) 
	) {
		COLOR = target_color;
	}
}

