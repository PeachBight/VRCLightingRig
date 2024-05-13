    Shader "MetacosmStudios/Invis/Invis"
    {
        SubShader
        {
            Tags {"Queue" = "Transparent" }
            Lighting Off
			ZWrite Off
            Pass
            {
                //used rendering nothing on cullfix objects
                ColorMask 0    
            }
        }
    }

