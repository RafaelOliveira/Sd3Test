#ifdef GL_ES
precision highp float;
#endif

// Input vertex data, different for all executions of this shader
attribute vec3 position;
attribute vec2 textureCoord;

uniform mat4 mvp;

// Output data: will be interpolated for each fragment.
varying vec2 vTextureCoord;

void kore()
{
	vTextureCoord = textureCoord;
	gl_Position = mvp * vec4(position, 1.0);	
}