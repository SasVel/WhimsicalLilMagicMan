shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D distortionTexture;

void fragment() {
	//vec2 distortedUV = SCREEN_UV + texture(TEXTURE, UV).r * 0.5;
	vec4 pixelColor = texture(SCREEN_TEXTURE, UV);
	float brightness = (pixelColor.r + pixelColor.g + pixelColor.b) / 3.0;
	vec4 grayScale = vec4(brightness, brightness, 0.5, 1);
	COLOR = grayScale;
}
