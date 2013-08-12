function publish( sourceDirectory, targetDirectory, filter )
	local matches = os.matchfiles( path.join( sourceDirectory, filter ) )
	for i, source in ipairs(matches) do
		local relpath = path.getrelative( sourceDirectory, source )
		local dest = path.join( targetDirectory, relpath )
		print( source .. " -> " .. dest )
		os.mkdir( path.getdirectory( dest ) )
		if not os.copyfile( source, dest ) then
			print( "Failed to copy file!" )
			os.exit( 1 )
		end
	end
end

solution( "thirdparty" )

--
-- Platforms (architectures)
--

platforms
{
	"x64"
}

--
-- Configurations (build types)
--

configurations
{
	"Debug",
	"Release"
}

--
-- Build flags (compiler options)
--

flags
{
}

configuration "Debug"
	flags
	{
		"Symbols",
	}

configuration "Release"
	flags
	{
		"Symbols",
		"NoFramePointer",
		"NoEditAndContinue",
		"OptimizeSpeed",
	}

configuration "windows"
	flags
	{
		"NoMinimalRebuild",
	}

configuration "linux"
	buildoptions
	{
		"-fPIC",
		"-fexceptions",
		"-pthread",
	}

configuration "windows"
	buildoptions
	{
		"/MP",
		"/Zm384"
	}

configuration { "windows", "x32" }
	linkoptions
	{
		"/LARGEADDRESSAWARE",
	}

configuration { "windows", "Debug" }
	buildoptions
	{
		"/Ob0",
	}

configuration { "windows", "not Debug" }
	buildoptions
	{
		"/Ob2",
		"/Oi",
	}

configuration {}

--
-- Preprocessor defines
--

defines
{
}

configuration "windows"
	defines
	{
		"WIN32",
		"_WIN32",
		"_CRT_SECURE_NO_DEPRECATE",
		"_CRT_NONSTDC_NO_WARNINGS",
		"_CRT_NON_CONFORMING_SWPRINTFS",
	}

configuration "Debug"
	defines
	{
		"_DEBUG=1",
	}

configuration "Release"
	defines
	{
		"NDEBUG=1",
	}

configuration {}

--
-- Projects
--

project( "zlib" )
	language "C"
	kind "StaticLib"

	flags
	{
		"Unicode",
	}

	files
	{
		"zlib/dist/*.c",
	}

	targetdir "zlib/lib"
	targetname "libpandazlib1"

	if _ACTION then
		publish( "zlib/dist", "zlib/include", "*.h" )
	end

project( "png" )
	language "C"
	kind "StaticLib"

	flags
	{
		"Unicode",
	}

	includedirs
	{
		"zlib/include",
	}

	files
	{
		"png/dist/*.c",
	}

	targetdir "png/lib"
	targetname "libpandapng"

	if _ACTION then
		publish( "png/dist", "png/include", "*.h" )
	end

project( "jpeg" )
	language "C"
	kind "StaticLib"

	flags
	{
		"Unicode",
	}

	files
	{
		"jpeg/dist/*.c",
	}

	excludes
	{
		"jpeg/dist/jmemdos.c",
		"jpeg/dist/jmemmac.c",
	}

	targetdir "jpeg/lib"
	targetname "libpandajpeg"

	if _ACTION then
		if not os.isfile( "jpeg/dist/jconfig.h" ) then
			os.copyfile( "jpeg/dist/jconfig.vc", "jpeg/dist/jconfig.h" )
		end
		publish( "jpeg/dist", "jpeg/include", "*.h" )
	end

project( "tiff" )
	language "C"
	kind "StaticLib"

	flags
	{
		"Unicode",
	}

	includedirs
	{
		"zlib/include",
		"jpeg/include",
	}

	files
	{
		"tiff/dist/libtiff/*.c",
	}

	excludes
	{
		"tiff/dist/libtiff/tif_acorn.c",
		"tiff/dist/libtiff/tif_apple.c",
		"tiff/dist/libtiff/tif_atari.c",
		"tiff/dist/libtiff/tif_msdos.c",
		"tiff/dist/libtiff/tif_win3.c",
		"tiff/dist/libtiff/tif_win32.c",
	}

	targetdir "tiff/lib"
	targetname "libpandatiff"

	if _ACTION then
		if not os.isfile( "tiff/dist/libtiff/tif_config.h" ) then
			os.copyfile( "tiff/dist/libtiff/tif_config.h.vc", "tiff/dist/libtiff/tif_config.h" )
		end
		publish( "tiff/dist/libtiff", "tiff/include", "*.h" )
	end

project "freetype"
	language "C"
	kind "StaticLib"

	flags
	{
		"Unicode",
	}

	defines
	{
		"_LIB",
		"FT2_BUILD_LIBRARY",
	}

	includedirs
	{
		"freetype/dist/include",
	}

	files
	{
		"freetype/dist/builds/win32/ftdebug.c",
		"freetype/dist/src/autofit/autofit.c",
		"freetype/dist/src/base/ftbase.c",
		"freetype/dist/src/base/ftbbox.c",
		"freetype/dist/src/base/ftbitmap.c",
		"freetype/dist/src/base/ftgasp.c",
		"freetype/dist/src/base/ftglyph.c",
		"freetype/dist/src/base/ftgxval.c",
		"freetype/dist/src/base/ftinit.c",
		"freetype/dist/src/base/ftlcdfil.c",
		"freetype/dist/src/base/ftmm.c",
		"freetype/dist/src/base/ftotval.c",
		"freetype/dist/src/base/ftpfr.c",
		"freetype/dist/src/base/ftstroke.c",
		"freetype/dist/src/base/ftsynth.c",
		"freetype/dist/src/base/ftsystem.c",
		"freetype/dist/src/base/fttype1.c",
		"freetype/dist/src/base/ftwinfnt.c",
		"freetype/dist/src/base/ftxf86.c",
		"freetype/dist/src/bdf/bdf.c",
		"freetype/dist/src/cache/ftcache.c",
		"freetype/dist/src/cff/cff.c",
		"freetype/dist/src/cid/type1cid.c",
		"freetype/dist/src/gzip/ftgzip.c",
		"freetype/dist/src/lzw/ftlzw.c",
		"freetype/dist/src/pcf/pcf.c",
		"freetype/dist/src/pfr/pfr.c",
		"freetype/dist/src/psaux/psaux.c",
		"freetype/dist/src/pshinter/pshinter.c",
		"freetype/dist/src/psnames/psmodule.c",
		"freetype/dist/src/raster/raster.c",
		"freetype/dist/src/sfnt/sfnt.c",
		"freetype/dist/src/smooth/smooth.c",
		"freetype/dist/src/truetype/truetype.c",
		"freetype/dist/src/type1/type1.c",
		"freetype/dist/src/type42/type42.c",
		"freetype/dist/src/winfonts/winfnt.c",
	}

	targetdir "freetype/lib"
	targetname "freetype"

	if _ACTION then
		publish( "freetype/dist/include", "freetype/include", "**.h" )
	end

project( "squish" )
	language "C++"
	kind "StaticLib"

	flags
	{
		"Unicode",
	}

	includedirs
	{
		"squish/dist",
	}

	files
	{
		"squish/dist/*.cpp",
	}

	targetdir "squish/lib"
	targetname "squish"

	if _ACTION then
		publish( "squish/dist", "squish/include", "squish.h" )
	end

project( "openal" )
	language "C"
	kind "SharedLib"

	flags
	{
		"Unicode",
	}

	defines
	{
		"AL_BUILD_LIBRARY=1",
		"AL_ALEXT_PROTOTYPES=1",
		"strcasecmp=_stricmp",
		"strncasecmp=_strnicmp",
		"snprintf=_snprintf",
		"isfinite=_finite",
		"isnan=_isnan",
	}

	includedirs
	{
		"openal/dist",
		"openal/dist/include",
		"openal/dist/OpenAL32/Include",
	}

	files
	{
		"openal/dist/OpenAL32/*.c",
		"openal/dist/Alc/*.c",
		"openal/dist/Alc/backends/dsound.c",
		"openal/dist/Alc/backends/loopback.c",
		"openal/dist/Alc/backends/mmdevapi.c",
		"openal/dist/Alc/backends/null.c",
		"openal/dist/Alc/backends/wave.c",
		"openal/dist/Alc/backends/winmm.c",
	}

	excludes
	{
		"openal/dist/Alc/mixer_neon.c",
		"openal/dist/Alc/mixer_inc.c",
	}

	links
	{
		"winmm"
	}

	targetdir "openal/bin"
	implibdir "openal/lib"
	targetname "OpenAL32"

	if _ACTION then
		publish( "openal/dist/include", "openal/include", "**.h" )
	end

--
-- OpenSSL
--

local cwd = os.getcwd()

os.chdir( path.join( cwd, 'openssl/dist' ) )

if os.execute( 'perl Configure VC-WIN64A --prefix="' .. path.join( cwd, 'openssl/dist/built' ) .. '"' ) ~= 0 then
	os.exit(1)
end

if os.execute( 'ms\\do_win64a.bat' ) ~= 0 then
	os.exit(1)
end

if os.execute( 'nmake -f ms\\nt.mak' ) ~= 0 then
	os.exit(1)
end

if os.execute( 'nmake -f ms\\nt.mak install' ) ~= 0 then
	os.exit(1)
end

os.chdir( cwd )

os.mkdir( "openssl/lib" )
os.copyfile( "openssl/dist/built/lib/libeay32.lib", "openssl/lib/libpandaeay.lib" )
os.copyfile( "openssl/dist/built/lib/ssleay32.lib", "openssl/lib/libpandassl.lib" )

publish( "openssl/dist/built/include", "openssl/include", "**.h" )
