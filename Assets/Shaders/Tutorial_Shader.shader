Shader "Unlit/Tutorial_Shader" {
	Properties {
		_Colour ("Colour", Color) = (1, 1, 1, 1)
		_MainTexture ("Main Texture", 2D) = "white" {}
	}

	SubShader {
		Pass {
			CGPROGRAM
				#pragma vertex vertexFunction
				#pragma fragment fragmentFunction

				#include "UnityCG.cginc"

				struct appdata {
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f {
					float4 position : SV_POSITION;
					float2 uv : TEXCOORD0;
				};

				float4 _Colour;
				sampler2D _MainTexture;

				v2f vertexFunction (appdata IN) {
					v2f OUT;
					OUT.position = UnityObjectToClipPos(IN.vertex);
					OUT.uv = IN.uv;
					return OUT;
				}

				fixed4 fragmentFunction (v2f IN) : SV_TARGET {
					float4 textureColour = tex2D(_MainTexture, IN.uv);
					return textureColour;
				}
			ENDCG
		}
	}
}