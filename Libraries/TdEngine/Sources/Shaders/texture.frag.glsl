#ifdef GL_ES
precision mediump float;
#endif

uniform mat4 model;
uniform mat4 normalModel;
uniform vec3 cameraPosition;

uniform sampler2D textureSampler;
uniform float materialShininess;
uniform vec3 materialSpecularColor;

uniform vec3 lightPosition;
uniform vec3 lightColor;
uniform float lightAttenuation;
uniform float lightAmbientCoefficient;

varying vec3 vPosition;
varying vec2 vTextureCoord;
varying vec3 vNormal;

void kore()
{	    
    //mat3 normalMatrix = transpose(inverse(mat3(model)));
    vec3 normal = normalize(mat3(normalModel) * vNormal);
    //vec3 normal = normalize(normalMatrix * vNormal);
    vec3 surfacePosition = vec3(model * vec4(vPosition, 1));
    vec4 surfaceColor = texture2D(textureSampler, vTextureCoord);
    vec3 surfaceToLight = normalize(lightPosition - surfacePosition);
    vec3 surfaceToCamera = normalize(cameraPosition - surfacePosition);

    //ambient
    vec3 ambient = lightAmbientCoefficient * surfaceColor.rgb * lightColor;

    //diffuse
    float diffuseCoefficient = max(0.0, dot(normal, surfaceToLight));    
    vec3 diffuse = diffuseCoefficient * surfaceColor.rgb * lightColor;

    //specular
    float specularCoefficient = 0.0;
    if (diffuseCoefficient > 0.0)
        specularCoefficient = pow(max(0.0, dot(surfaceToCamera, reflect(-surfaceToLight, normal))), materialShininess);
    vec3 specular = specularCoefficient * materialSpecularColor * lightColor;

    //attenuation
    float distanceToLight = length(lightPosition - surfacePosition);
    float attenuation = 1.0 / (1.0 + lightAttenuation * pow(distanceToLight, 2.0));

    //linear color (color before gamma correction)
    vec3 linearColor = ambient + attenuation * (diffuse + specular);

    //final color (after gamma correction)
    //vec3 gamma = vec3(1.0 / 2.2);
    
    gl_FragColor = vec4(linearColor, surfaceColor.a);
    //gl_FragColor = vec4(pow(linearColor, gamma), surfaceColor.a);
}