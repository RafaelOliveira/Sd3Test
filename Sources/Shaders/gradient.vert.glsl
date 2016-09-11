#ifdef GL_ES
precision highp float;
#endif

attribute vec3 pos;
varying vec3 color;

uniform mat4 mvp;

void kore()
{
	color = vec3(pos.x + 0.5, 1.0, pos.y + 0.5);
	gl_Position = mvp * vec4(pos, 1.0);
}