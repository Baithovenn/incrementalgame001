shader_type spatial;
// Schachbrett in Weltkoordinaten (1 m Felder) plus feine Rasterlinien, gedeckte Erdfarben.

uniform vec3 color_a : source_color = vec3(0.165, 0.133, 0.098);
uniform vec3 color_b : source_color = vec3(0.215, 0.176, 0.128);
uniform vec3 line_color : source_color = vec3(0.30, 0.26, 0.20);
uniform float cell_size = 1.0;
uniform float line_width = 0.02;

varying vec3 world_pos;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec2 p = world_pos.xz / cell_size;
	vec2 cell = floor(p);
	float checker = mod(cell.x + cell.y, 2.0);
	vec3 col = mix(color_a, color_b, checker);

	vec2 f = abs(fract(p) - 0.5);
	float edge = max(f.x, f.y);
	float line = 1.0 - smoothstep(0.5 - line_width, 0.5 - line_width * 0.5, edge);
	col = mix(col, line_color, line * 0.55);

	ALBEDO = col;
	ROUGHNESS = 0.95;
	SPECULAR = 0.1;
}
