Shader "Shader Forge/Mod_cartoon"
{
  Properties
  {
    _zhuse01 ("zhuse01", 2D) = "white" {}
    _zhuse02 ("zhuse02", 2D) = "white" {}
    _faxian ("faxian", 2D) = "bump" {}
    _Color ("Color", Color) = (0.5,0.5,0.5,1)
    _guang ("guang", Range(-1, 1)) = 0
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile DIRECTIONAL
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt3x3_0(mat4x4) float3(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x)
      #define conv_mxt3x3_1(mat4x4) float3(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y)
      #define conv_mxt3x3_2(mat4x4) float3(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform sampler2D _zhuse02;
      uniform float4 _zhuse02_ST;
      uniform sampler2D _faxian;
      uniform float4 _faxian_ST;
      uniform sampler2D _zhuse01;
      uniform float4 _zhuse01_ST;
      uniform float4 _Color;
      uniform float _guang;
      struct appdata_t
      {
          float4 tangent :TANGENT;
          float4 vertex :POSITION;
          float3 normal :NORMAL;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
          float3 xlv_TEXCOORD3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
          float3 xlv_TEXCOORD3 :TEXCOORD3;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float3x3 tmpvar_1;
          tmpvar_1[0] = conv_mxt4x4_0(unity_WorldToObject).xyz;
          tmpvar_1[1] = conv_mxt4x4_1(unity_WorldToObject).xyz;
          tmpvar_1[2] = conv_mxt4x4_2(unity_WorldToObject).xyz;
          float3 tmpvar_2;
          tmpvar_2 = normalize(mul(in_v.normal, tmpvar_1));
          float4 tmpvar_3;
          tmpvar_3.w = 0;
          tmpvar_3.xyz = float3(in_v.tangent.xyz);
          float3 tmpvar_4;
          tmpvar_4 = normalize(mul(unity_ObjectToWorld, tmpvar_3).xyz);
          float4 tmpvar_5;
          tmpvar_5.w = 1;
          tmpvar_5.xyz = float3(in_v.vertex.xyz);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_5));
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          out_v.xlv_TEXCOORD1 = tmpvar_2;
          out_v.xlv_TEXCOORD2 = tmpvar_4;
          out_v.xlv_TEXCOORD3 = normalize((((tmpvar_2.yzx * tmpvar_4.zxy) - (tmpvar_2.zxy * tmpvar_4.yzx)) * in_v.tangent.w));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float4 finalRGBA_2;
          float4 _zhuse02_var_3;
          float2 node_529_4;
          float4 _zhuse01_var_5;
          float3 normalLocal_6;
          float3 _faxian_var_7;
          float3 tmpvar_8;
          tmpvar_8 = normalize(in_f.xlv_TEXCOORD1);
          float3x3 tmpvar_9;
          conv_mxt3x3_0(tmpvar_9).x = in_f.xlv_TEXCOORD2.x;
          conv_mxt3x3_0(tmpvar_9).y = in_f.xlv_TEXCOORD3.x;
          conv_mxt3x3_0(tmpvar_9).z = tmpvar_8.x;
          conv_mxt3x3_1(tmpvar_9).x = in_f.xlv_TEXCOORD2.y;
          conv_mxt3x3_1(tmpvar_9).y = in_f.xlv_TEXCOORD3.y;
          conv_mxt3x3_1(tmpvar_9).z = tmpvar_8.y;
          conv_mxt3x3_2(tmpvar_9).x = in_f.xlv_TEXCOORD2.z;
          conv_mxt3x3_2(tmpvar_9).y = in_f.xlv_TEXCOORD3.z;
          conv_mxt3x3_2(tmpvar_9).z = tmpvar_8.z;
          float2 P_10;
          P_10 = TRANSFORM_TEX(in_f.xlv_TEXCOORD0, _faxian);
          float3 tmpvar_11;
          tmpvar_11 = ((tex2D(_faxian, P_10).xyz * 2) - 1).xyz;
          _faxian_var_7 = tmpvar_11;
          normalLocal_6 = _faxian_var_7;
          float4 tmpvar_12;
          float2 P_13;
          P_13 = TRANSFORM_TEX(in_f.xlv_TEXCOORD0, _zhuse01);
          tmpvar_12 = tex2D(_zhuse01, P_13);
          _zhuse01_var_5 = tmpvar_12;
          float4 tmpvar_14;
          tmpvar_14.w = 0;
          tmpvar_14.xyz = float3(normalize(mul(normalLocal_6, tmpvar_9)));
          float2 tmpvar_15;
          tmpvar_15 = ((mul(unity_WorldToObject, tmpvar_14).xyz * 0.5) + 0.5).xy.xy;
          node_529_4 = tmpvar_15;
          float4 tmpvar_16;
          float2 P_17;
          P_17 = TRANSFORM_TEX(node_529_4, _zhuse02);
          tmpvar_16 = tex2D(_zhuse02, P_17);
          _zhuse02_var_3 = tmpvar_16;
          float4 tmpvar_18;
          tmpvar_18.w = 1;
          tmpvar_18.xyz = float3(((_zhuse01_var_5.xyz + _guang) + (_Color.xyz + _zhuse02_var_3.xyz)));
          finalRGBA_2 = tmpvar_18;
          tmpvar_1 = finalRGBA_2;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
