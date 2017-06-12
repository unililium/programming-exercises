precision highp float;

uniform vec4 mDiffColor;
uniform vec4 mSpecColor;
uniform float mSpecPower;

uniform sampler2D textureFile;
uniform float textureInfluence;

uniform vec3 lightDirection;
uniform vec3 lightPosition;
uniform vec4 lightColor;
uniform int lightType;

uniform vec3 eyePosition;

varying vec2 fsUVs;
varying vec3 fsNormal;
varying vec3 fsPosition;

vec4 lightModel(int lt, vec3 pos) {
	vec3 nLightDir;
	float lDim, lCone;

	lDim = 1.0;

	if (lt == 1) { //directional
		nLightDir = -normalize(lightDirection);
	} else if (lt == 2) { //point light
		nLightDir = normalize(lightPosition - pos);
	} else if (lt == 3) { // point light w. decay
		float lLen = length(lightPosition - pos);
		nLightDir = normalize(lightPosition - pos);
		lDim = 160.0 / (lLen * lLen);
	} else if (lt == 4) { // spotlight
		nLightDir = normalize(lightPosition - pos);
		lCone = -dot(nLightDir, normalize(lightDirection));
		if (lCone < 0.5) {
			lDim = 0.0;
		} else if (lCone > 0.7) {
			lDim = 1.0;
		} else {
			lDim = (lCone - 0.5) / 0.2;
		}
	}

	return ;
}

void main() {

	vec3 nEyeDirection = normalize(eyePosition - fsPosition);
	//vec3 nlightDirection = - normalize(lightDirection);
	vec3 nNormal = normalize(fsNormal);

	vec4 lm = lightModel(lightType, fsPosition);
	vec3 nlightDirection = lm.rgb;
	float lightDim = lm.a;

	vec4 diffuseTextureColorMixture = texture2D(textureFile, fsUVs) * textureInfluence + mDiffColor * (1.0 - textureInfluence);

	vec4 diffuse =  mDiffColor * lightColor * clamp(dot(nlightDirection, nNormal), 0.0, 1.0);

	//vec3 hVec = normalize(nEyeDirection + nlightDirection);
	vec3 reflection = -reflect(nlightDirection, nNormal);
	vec4 specular = mSpecColor * lightColor * pow(clamp(dot(reflection, nEyeDirection),0.0, 1.0), mSpecPower);

	gl_FragColor = min(diffuse + specular, vec4(1.0, 1.0, 1.0, 1.0));

}
