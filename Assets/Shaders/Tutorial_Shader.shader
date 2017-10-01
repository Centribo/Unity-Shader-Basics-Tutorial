Shader "Unlit/Tutorial_Shader" {
	Properties {
		
	}

	SubShader {
		Pass {
			CGPROGRAM
				#pragma vertex vertexFunction
				#pragma fragment fragmentFunction

				#import "UnityCG.cginc"

				struct appdata {
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f {
					float4 position : SV_POSITION;
					float2 uv : TEXCOORD0;
				};

				v2f vertexFunction (appdata v) {
					v2f OUT;

					return OUT;
				}

				fixed4 fragmentFunction (v2f IN) : SV_TARGET {

				}
			ENDCG
		}
	}
}