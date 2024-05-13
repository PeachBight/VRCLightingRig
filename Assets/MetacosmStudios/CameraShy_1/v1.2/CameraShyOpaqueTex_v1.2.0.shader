Shader "MetacosmStudios/CameraShy/Opaque_Tex_1_2_0"
{
    //version 1.2.0
    Properties{
      _MainTex("Texture", 2D) = "white" {}
      _Emission("Emission",Float) = 0
      _EmissionColor("Emission Color",Color) = (0.1,0.1,0.1,0.0)
      _EmissionTex("Texture", 2D) = "white" {}
      _ColorTint("Tint", Color) = (1.0, 1.0, 1.0, 1.0)
          //_Cutoff("Cutoff Alpha", Range(0,1)) = 0.5
          [MaterialToggle] _ShowInVRCL("Show in VRCLens", Float) = 0
          [MaterialToggle] _IsInvisible("Invisible", Float) = 0
          [MaterialToggle] _ShowInMirror("Show In Mirror", Float) = 0
    }
        SubShader{
            Tags { "RenderType" = "Opaque" }
            CGPROGRAM
            #pragma multi_compile_instancing
            #pragma surface surf Lambert vertex:vert addshadow //alphatest:_Cutoff 
            #include "UnityCG.cginc"
            struct Input {
              float2 uv_MainTex;
              float2 uv_EmissionTex;
              float3 viewDir;
            };
            sampler2D _MainTex;
            sampler2D _EmissionTex;
            float _Emission;
            float4 _EmissionColor;
            fixed4 _ColorTint;
            bool _ShowInVRCL;
            bool _IsInvisible;
            bool _ShowInMirror;

            bool IsInMirror()
            {
            #ifdef _VRChatMirrorMode
                return _VRChatMirrorMode > 0.5;
            #else
                return unity_CameraProjection[2][0] != 0.f || unity_CameraProjection[2][1] != 0.f;
            #endif
            }

            bool IsInLens()
            {
                /// unity_CameraProjection._m11 is 1/tan(FOV/2)
                /// unity_CameraProjection._m20 and _m21 are not 0 when in a mirror
                /// this branchless code reads as
                /// if FOV is not 60deg
                ///     and FOV is not 75deg
                ///     and the aspect ratio is not 16:9 or 8:9
                ///     and the mirror-only pieces are zero
                ///     and we aren't forcing to be shown in camera
                /// THEN we can be safe that the vertex/fragment is being rendered on a camera
                return (abs(unity_CameraProjection._m11 - 1.73205) > 0.00001) //if 60deg FOV is the default VRC desktop, so not lens
                    && (abs(unity_CameraProjection._m11 - 1.303225) > 0.00001) // if 75 FOV, not lens
                    && (abs((_ScreenParams.y / _ScreenParams.x) - 0.5625) < 0.05 // if not 16:9 ratio...
                        || abs((_ScreenParams.y / _ScreenParams.x) - 1.125) < 0.05) // and not 8:9 ratio (3D), then not lens
                    && all(unity_CameraProjection._m20_m21 == 0.0) // if in mirror, then not in lens
                    && (!_ShowInVRCL); // special case for disabling camera shy
            }

            void vert(inout appdata_full v) {
            #ifndef USING_STEREO_MATRICES
                if (_IsInvisible || IsInLens() || (IsInMirror() && !_ShowInMirror)) {
                    v.vertex.xyz = float3(0, 0, -2);
                }
            #else
                if (_IsInvisible || (IsInMirror() && !_ShowInMirror)) {
                    v.vertex.xyz = float3(0, 0, -2);
                }
            #endif

            }
            void surf(Input IN, inout SurfaceOutput o) {
                //fixed4 col = tex2D(_MainTex, IN.uv_MainTex) * _ColorTint;
                fixed4 col = tex2D(_MainTex, IN.uv_MainTex) * _ColorTint;
                o.Albedo = col.rgb;
                o.Alpha = col.a;
                o.Emission = tex2D(_EmissionTex, IN.uv_EmissionTex) * _EmissionColor.rgb * pow(2,_Emission) * _EmissionColor.a;
            }
            ENDCG
      }
          Fallback "Diffuse"
}