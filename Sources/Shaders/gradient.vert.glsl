#ifdef GL_ES
precision highp float;
#endif

attribute vec3 position;
varying vec3 color;

uniform mat4 mvp;

void kore()
{
	color = vec3(position.x + 0.5, 1.0, position.y + 0.5);
	gl_Position = mvp * vec4(position, 1.0);
}