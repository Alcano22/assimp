project "assimp"
    kind "StaticLib"
    language "C++"
    staticruntime "on"
    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    defines {
        "ASSIMP_BUILD_NO_OWN_ZLIB",
        "ASSIMP_BUILD_NO_3D_IMPORTER",
        "ASSIMP_BUILD_NO_OGRE_IMPORTER",
        "_CRT_SECURE_NO_WARNINGS"
    }

    files {
        "code/**.cpp",
        "code/**.c",
        "code/**.cc",
        
        "include/**.h",
        "include/**.hpp",

        "contrib/**.c",
        "contrib/**.cpp",
        "contrib/**.h"
    }

    includedirs {
        "include",
        "code",
        "contrib",
        "contrib/irrXML",
        "contrib/Opencolorio/include"
    }

    filter "system:windows"
        systemversion "latest"
        defines { "_WIN32", "WIN32" }
        files {
            "contrib/**windows**.cpp",
            "contrib/**windows**.c",
            "code/Win32/**.cpp"
        }
        links { "Ws2_32" }
    filter {}

    filter "system:linux"
        defines { "_LINUX" }
        links { "pthread", "m", "dl" }
    filter {}

    filter "system:macosx"
        defines { "_MACOSX" }
        linkoptions { 
            "-framework CoreFoundation",
            "-framework IOKit",
            "-framework Cocoa" 
        }
    filter {}

    filter "configurations:Debug"
        symbols "on"
        runtime "Debug"
        defines { "DEBUG" }
    filter {}

    filter "configurations:Release"
        optimize "on"
        runtime "Release"
        defines { "NDEBUG" }
    filter {}
