Shader "F4BY/NewElephantBattery"
{
  Properties
  {
    _MainTex ("MainTex", 2D) = "white" {}
    _Line ("Line", float) = 4
    _Row ("Row", float) = 2
    _Speed ("播放速度", float) = 150
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform int _Line;
      uniform int _Row;
      uniform float _Speed;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float2 tmpvar_1;
          float tmpvar_2;
          float tmpvar_3;
          tmpvar_3 = float(_Line);
          tmpvar_2 = (1 / tmpvar_3);
          float tmpvar_4;
          float tmpvar_5;
          tmpvar_5 = float(_Row);
          tmpvar_4 = (1 / tmpvar_5);
          float4 tmpvar_6;
          float4 tmpvar_7;
          tmpvar_7.w = 1;
          tmpvar_7.xyz = float3(in_v.vertex.xyz);
          tmpvar_6 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_7));
          tmpvar_1.x = in_v.texcoord.x;
          tmpvar_1.y = (in_v.texcoord.y * tmpvar_2);
          float tmpvar_8;
          tmpvar_8 = (floor(((_Time.y / tmpvar_5) * _Speed)) / tmpvar_3);
          float tmpvar_9;
          tmpvar_9 = (frac(abs(tmpvar_8)) * tmpvar_3);
          float tmpvar_10;
          if((tmpvar_8>=0))
          {
              tmpvar_10 = tmpvar_9;
          }
          else
          {
              tmpvar_10 = (-tmpvar_9);
          }
          tmpvar_1.y = (tmpvar_1.y + (tmpvar_2 * tmpvar_10));
          tmpvar_1.x = (in_v.texcoord.x * tmpvar_4);
          float y_11;
          y_11 = float(_Row);
          float tmpvar_12;
          tmpvar_12 = (floor((_Time.y * _Speed)) / y_11);
          float tmpvar_13;
          tmpvar_13 = (frac(abs(tmpvar_12)) * y_11);
          float tmpvar_14;
          if((tmpvar_12>=0))
          {
              tmpvar_14 = tmpvar_13;
          }
          else
          {
              tmpvar_14 = (-tmpvar_13);
          }
          tmpvar_1.x = (tmpvar_1.x + (tmpvar_4 * tmpvar_14));
          out_v.vertex = tmpvar_6;
          out_v.xlv_TEXCOORD0 = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 c_1;
          float4 tmpvar_2;
          tmpvar_2 = tex2D(_MainTex, in_f.xlv_TEXCOORD0);
          c_1 = tmpvar_2;
          out_f.color = c_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
