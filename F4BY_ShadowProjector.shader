Shader "F4BY/ShadowProjector"
{
  Properties
  {
    _ShadowTex ("ShadowTex", 2D) = "gray" {}
    _shadowfactor ("Shadowfactor", Range(0, 1)) = 0.5
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "AlphaTest+1"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "QUEUE" = "AlphaTest+1"
      }
      ZWrite Off
      Offset -1, -1
      Blend DstColor Zero
      ColorMask RGB
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4x4 unity_Projector;
      uniform sampler2D _ShadowTex;
      uniform float _shadowfactor;
      struct appdata_t
      {
          float4 vertex :POSITION;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 tmpvar_1;
          tmpvar_1.w = 1;
          tmpvar_1.xyz = float3(in_v.vertex.xyz);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_1));
          out_v.xlv_TEXCOORD0 = mul(unity_Projector, in_v.vertex);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float a_1;
          float tmpvar_2;
          tmpvar_2 = tex2D(_ShadowTex, in_f.xlv_TEXCOORD0).w.x;
          a_1 = tmpvar_2;
          float4 tmpvar_3;
          float _tmp_dvx_5 = (1 - (_shadowfactor * a_1));
          tmpvar_3 = float4(_tmp_dvx_5, _tmp_dvx_5, _tmp_dvx_5, _tmp_dvx_5);
          out_f.color = tmpvar_3;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
