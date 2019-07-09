Shader "Unlit/EdgeShader"
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

#if 0
				// 正直な方法：スクリーンでの法線の方向を求め、後はスクリーンに垂直に一定の暑さでずらす
				o.vertex = UnityObjectToClipPos(v.vertex);
				float4 normal_clip = UnityObjectToClipPos(float4(v.vertex + v.normal, 1.0));
				normal_clip.xy = normalize(normal_clip.xy / normal_clip.w - o.vertex.xy / o.vertex.w);
				normal_clip.xy = normal_clip.xy * (_ScreenParams.zw-1) * _Thickness * 10.0 * o.vertex.w;
				o.vertex.xy += normal_clip.xy;
#else
				// 簡単な表現：頂点の深度値に応じて厚くすることで画面上で一様な幅にする
				float depth = UnityObjectToViewPos(v.vertex).z;
				o.vertex = UnityObjectToClipPos(v.vertex - v.normal * depth * _Thickness * 0.005);
#endif
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
