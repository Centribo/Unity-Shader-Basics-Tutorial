Shader "Unlit/Tutorial_Shader" { //ShaderLab code
	Properties { //Properties/Custom data we want to use
		_Colour ("Colour", Color) = (1, 1, 1, 1) //Tint colour
		_MainTexture ("Main Texture", 2D) = "white" {} //Texture map
		_DissolveTexture ("Dissolve Texture", 2D) = "white" {} //Black and white dissolve texture
		_DissolveCutoff ("Dissolve Cutoff", Range(0, 1)) = 1 //Dissolve threshold
		_ExtrudeAmount ("Extrue Amount", float) = 0 //How far out to extrude the model
	}

	SubShader { //We can have multiple subshaders. Especially useful for multiple platforms/quality levels
		Pass { //Can have > 1 pass, each adding a draw call. Useful/Mandatory for many effects
			CGPROGRAM //Start of Cg code

				//Define what our vertex and fragment shaders are called
				#pragma vertex vertexFunction
				#pragma fragment fragmentFunction

				//Include Unity helper functions
				#include "UnityCG.cginc"

				//Data we want to retrieve from our model
				//Such as: Vertices, normal, colour, UV coordinates, etc.
				struct appdata {
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
					float3 normal : NORMAL;
				};

				//The object we're building and passing to our fragment function
				//We're going to give the fragment function information about the model's...
				struct v2f {
					float4 position : SV_POSITION;
					float2 uv : TEXCOORD0;
				};

				//Properties. Note the same names as above.
				float4 _Colour;
				sampler2D _MainTexture;
				sampler2D _DissolveTexture;
				float _DissolveCutoff;
				float _ExtrudeAmount;

				//Vertex function, outputs data in v2f struct
				v2f vertexFunction (appdata IN) {
					v2f OUT; //Create empty output
					
					//Move the vertices of our object along their normals (facing directions)
					//Animate the distance over time, with magnitude _ExtrudeAmount
					IN.vertex.xyz += IN.normal.xyz * _ExtrudeAmount * sin(_Time.y);
					
					//Return position that is translated from local object space to clip space
					OUT.position = UnityObjectToClipPos(IN.vertex);

					//Simply carry over the same UV coordinates
					OUT.uv = IN.uv;

					return OUT;
				}

				//Fragment function, outputs (R, G, B, A) colours to render
				fixed4 fragmentFunction (v2f IN) : SV_TARGET {
					//Sample main texture for colour
					float4 textureColour = tex2D(_MainTexture, IN.uv);
					
					//Sample dissolve texture for dissolve colour,
					float4 dissolveColour = tex2D(_DissolveTexture, IN.uv);

					//Check if colour in dissolve texture is over a certain threshold
					//If not, (ie: negative value) then discard the pixel 
					clip(dissolveColour.rgb - _DissolveCutoff);

					//Otherwise, if we get here just return tinted colour from our main texture
					return textureColour * _Colour;
				}
			ENDCG //End of Cg code
		} //End of pass
	} //End of SubShader
} //End of Shader!