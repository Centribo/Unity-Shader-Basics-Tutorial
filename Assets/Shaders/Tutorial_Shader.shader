Shader "Unlit/Tutorial_Shader" {
	Properties {
		
	}

	SubShader {
		Pass {
			CGPROGRAM
				#pragma vertex vertexFunction
				#pragma fragment fragmentFunction

				void vertexFunction () {

				}

				void fragmentFunction () {

				}
			ENDCG
		}
	}
}