#version 440 core

uniform vec2 windowSize;
uniform sampler2D textureSampler;
uniform vec3 sunLight;
uniform vec3 moonLight;
uniform vec3 flashLight;
uniform bool linterna;
uniform bool sun;
uniform bool moon;

in vec2 uvsFragmentShader;
in vec3 normalsFragmentShader;
in vec4 primitivePosition;


out vec4 fragColor;

void main() {
        
        vec2 adjustedTexCoord = vec2(uvsFragmentShader.x, 1.0 - uvsFragmentShader.y);  
        vec4 baseColor = texture(textureSampler, adjustedTexCoord); 
        vec4 ambientColor = vec4(1.0,1.0,1.0,1.0);
        vec4 sunColor= vec4(0.5,0.5,0.0,1.0);
        vec4 moonColor= vec4(0.0,0.0,0.5,1.0);


        if(sun == true)
        {

        //vec3 sunLight = vec3(0,0,1);
        vec3 lightDirection = normalize(sunLight - primitivePosition.xyz);
        float sourceLightAngle = dot(normalsFragmentShader, lightDirection);

        fragColor += vec4(baseColor.rgb * sourceLightAngle,2.0) * (sunColor);

        
        }
        if(moon == true)
        {
        vec3 lightDirection = normalize(moonLight - primitivePosition.xyz);
        float sourceLightAngle = dot(normalsFragmentShader, lightDirection);

        fragColor += vec4(baseColor.rgb * sourceLightAngle,2.0) * (moonColor);
        }
      

        if(linterna == true)
        {
        vec3 flashLightDirection = normalize(flashLight - primitivePosition.xyz);
        float flashLighttAngle = dot(normalsFragmentShader, flashLightDirection);

        fragColor += vec4(baseColor.rgb * flashLighttAngle,1.0) * (ambientColor);
        }


        
        
}
