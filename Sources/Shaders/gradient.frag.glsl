#ifdef GL_ES
precision mediump float;
#endif

varying vec3 color;

void kore()
{
	gl_FragColor = vec4(color, 1.0);
}