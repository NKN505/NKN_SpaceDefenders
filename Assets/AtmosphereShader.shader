Shader "Custom/AtmosphereShader"
{
    Properties
    {
        _Color ("Atmosphere Color", Color) = (0.3, 0.6, 1, 1)
        _Intensity ("Glow Intensity", Range(0, 5)) = 1
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
            };

            fixed4 _Color;
            float _Intensity;

            v2f vert (appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float fresnel = 1.0 - saturate(dot(i.normal, float3(0, 0, 1)));
                fresnel = pow(fresnel, 2) * _Intensity;
                return float4(_Color.rgb, fresnel);
            }
            ENDCG
        }
    }
}
