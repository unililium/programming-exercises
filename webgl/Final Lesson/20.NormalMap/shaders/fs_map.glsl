precision highp float; 

uniform vec4 mDiffColor;
uniform vec4 mSpecColor;            
uniform float mSpecPower;

uniform sampler2D textureFile;
uniform sampler2D lightMapFile;
uniform float textureInfluence;
uniform float normalInfluence;

uniform vec3 lightDirection;
uniform vec3 lightPosition;
uniform vec4 lightColor;
uniform int lightType;

uniform vec3 eyePosition;

varying vec3 fsNormal; 
varying vec3 fsPosition; 
varying vec2 fsUVs;

//Function to create different lights types
//int lt = the selected light source type
//vec3 pos = the surface position

vec4 lightModel(int lt, vec3 pos) {
	
	//The normalize light direction
    vec3 nLightDir;
	
	//Float to store light dimension and cone length
	float lDim, lCone;

	lDim = 1.0;
	
	if(lt == 1) { 			//Directional light
		nLightDir = - normalize(lightDirection);
	} else if(lt == 2) {	//Point light
		nLightDir = normalize(lightPosition - pos);
	} else if(lt == 3) {	//Point light (decay)
		float lLen = length(lightPosition - pos);
		nLightDir = normalize(lightPosition - pos);
		lDim = 160.0 / (lLen * lLen);
	} else if(lt == 4) {	//Spot light
		nLightDir = normalize(lightPosition - pos);
		lCone = -dot(nLightDir, normalize(lightDirection));
		if(lCone < 0.5) {
			lDim = 0.0;
		} else if(lCone > 0.7) {
			lDim = 1.0;
		} else {
			lDim = (lCone - 0.5) / 0.2;
		}
	}
	return vec4(nLightDir, lDim);
}

void main() { 

	vec3 nEyeDirection = normalize(eyePosition - fsPosition);
	vec3 nNormal;
	vec4 nColor;
	
	//Instead of computing it this way because directional
	//Now we call a function to define light direction and size.
	
	vec4 lm = lightModel(lightType, fsPosition);
	vec3 nlightDirection = lm.rgb;
	float lightDimension = lm.a;
	
	
	//Computes the normal direction from the colors of the texture.
	//NOTE: the json imporer function in drawing.js
	//		stores the UV component read from file as (1.0 - V)...
	
	nColor = texture2D(textureFile, fsUVs);
	
	nNormal.xzy = (2.0 * nColor.xyz - vec3(1.0, 1.0, 1.0));
	nNormal.y = -nNormal.y;
	
	//Defines the influence of the normal map based on the slider
	nNormal = normalize(nNormal * normalInfluence + fsNormal * (1.0 - normalInfluence));
		
	//Reflection vector for Phong model
	vec3 reflection = reflect(nlightDirection, nNormal);	
	vec4 specular = mSpecColor * lightColor * pow(clamp(dot(reflection, nEyeDirection),0.0, 1.0), mSpecPower) * lightDimension;
	
	vec4 diffuse = mDiffColor * lightColor * clamp(dot(nlightDirection, nNormal), 0.0, 1.0) * lightDimension;	
	gl_FragColor = nColor * (textureInfluence) + (1.0 - textureInfluence) * min(diffuse + specular, vec4(1.0, 1.0, 1.0, 1.0)); 


}