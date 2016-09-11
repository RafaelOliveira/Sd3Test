#ifdef GL_ES
precision highp float;
#endif

// Input vertex data, different for all executions of this shader
attribute vec3 pos;
attribute vec2 textureCoords;

uniform mat4 mvp;

// Output data: will be interpolated for each fragment.
varying vec2 vTextureCoords;

void kore()
{
	gl_Position = mvp * vec4(pos, 1.0);
	vTextureCoords = textureCoords;
}