#ifdef GL_ES
precision mediump float;
#endif

varying vec4 vLinearColor;

void kore()
{	        
    gl_FragColor = vLinearColor;    
}