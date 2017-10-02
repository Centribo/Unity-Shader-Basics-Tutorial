Shader "Unlit/Tutorial_Shader" {
	Properties {
		_Colour ("Colour", Color) = (1, 1, 1, 1)
		_MainTexture ("Main Texture", 2D) = "white" {}
		_DissolveTexture ("Dissolve Texture", 2D) = "white" {}
		_DissolveCutoff ("Dissolve Cutoff", Range(0, 1)) = 1
		_ExtrudeAmount ("Extrue Amount", float) = 0
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
					float3 normal : NORMAL;
				};

				struct v2f {
					float4 position : SV_POSITION;
					float2 uv : TEXCOORD0;
				};

				float4 _Colour;
				sampler2D _MainTexture;
				sampler2D _DissolveTexture;
				float _DissolveCutoff;
				float _ExtrudeAmount;

				v2f vertexFunction (appdata IN) {
					v2f OUT;
					IN.vertex.xyz += IN.normal.xyz * _ExtrudeAmount * sin(_Time.y);
					OUT.position = UnityObjectToClipPos(IN.vertex);
					OUT.uv = IN.uv;
					return OUT;
				}

				fixed4 fragmentFunction (v2f IN) : SV_TARGET {
					float4 textureColour = tex2D(_MainTexture, IN.uv);
					float4 dissolveColour = tex2D(_DissolveTexture, IN.uv);
					clip(dissolveColour.rgb - _DissolveCutoff);
					return textureColour * _Colour;
				}
			ENDCG
		}
	}
}