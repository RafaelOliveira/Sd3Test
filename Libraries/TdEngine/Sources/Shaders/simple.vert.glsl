// Input vertex data, different for all executions of this shader
attribute vec3 pos;

// Values that stay constant for the whole mesh
uniform mat4 mvp;

void kore()
{
	// Output position of the vertex, in clip space : mvp * position
	gl_Position = mvp * vec4(pos, 1.0);
}