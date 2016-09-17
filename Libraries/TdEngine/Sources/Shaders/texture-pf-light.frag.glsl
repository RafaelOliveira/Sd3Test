#version 150

#ifdef GL_ES
precision mediump float;
#endif

uniform mat4 model;
uniform mat4 normalModel;
uniform sampler2D textureSampler;

uniform vec3 lightPosition;
uniform vec3 lightColor;

varying vec3 vPosition;
varying vec2 vTextureCoord;
varying vec3 vNormal;

void kore()
{
	//calculate normal in world coordinates
    //mat3 normalMatrix = transpose(inverse(mat3(model)));	
    //vec3 normal = normalize(normalMatrix * vNormal);
    vec3 normal = normalize(mat3(normalModel) * vNormal);
    
    //calculate the location of this fragment (pixel) in world coordinates
    vec3 fragPosition = vec3(model * vec4(vPosition, 1));
    
    //calculate the vector from this pixels surface to the light source
    vec3 surfaceToLight = lightPosition - fragPosition;

    //calculate the cosine of the angle of incidence
    float brightness = dot(normal, surfaceToLight) / (length(surfaceToLight) * length(normal));
    brightness = clamp(brightness, 0, 1);

    //calculate final color of the pixel, based on:
    // 1. The angle of incidence: brightness
    // 2. The color/intensities of the light: light.intensities
    // 3. The texture and texture coord: texture(tex, fragTexCoord)
    vec4 surfaceColor = texture(textureSampler, vTextureCoord);

    gl_FragColor = vec4(brightness * lightColor * surfaceColor.rgb, surfaceColor.a);
}