Shader "Unlit/ObjectSpaceEdgeShader"
{
    Properties
    {
		_Thickness("Thickness", Range(0,10)) = 1.0
	}
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

		Cull Front

		Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
				float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

			float _Thickness;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(
					v.vertex + v.normal * _Thickness * 0.03);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				return fixed4(0, 0, 0, 1);
            }
            ENDCG
        }
    }
}
