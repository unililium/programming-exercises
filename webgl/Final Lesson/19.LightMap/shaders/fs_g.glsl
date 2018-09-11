precision highp float; 

uniform sampler2D textureFile;
uniform sampler2D lightMapFile;

uniform float textureInfluence;
uniform float lightMapInfluence;

uniform vec4 mDiffColor;

varying vec2 fsUVs;
varying vec2 fsUV2s;

varying vec4 goureaudDiffuse;
varying vec4 goureaudSpecular;

void main() { 
	//Computing the color contribution from the texture
	vec4 diffuseTextureColorMixture = mDiffColor * (1.0 - textureInfluence) + texture2D(textureFile, fsUVs) * textureInfluence ;
	vec4 lightMapTextureColorMixture = texture2D(lightMapFile, fsUV2s) * lightMapInfluence + vec4(1.0 - lightMapInfluence) ;
	

	gl_FragColor = min(lightMapTextureColorMixture * diffuseTextureColorMixture * (goureaudDiffuse + goureaudSpecular), vec4(1.0, 1.0, 1.0, 1.0)); 

}