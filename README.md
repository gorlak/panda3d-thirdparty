Premake build script for panda3d's thirdparty libs (x64/vs2012)

This script builds some of the requisite third party libraries into the appropriate folders:
* Build premake-dev: https://bitbucket.org/premake/premake-dev (you need latest for vs2012 support)
* Run `premake4 vs2012` from the repo root (openssl is built inside the premake utility)
* Build thirdparty.sln to build all the rest of the libraries
* Modify your makepandacore.py to no call mt.exe to embed vc90's manfest directives (there are 2 calls)
* Before calling makepanda.py: `set MAKEPANDA_THIRDPARTY=...path-to-repo...`

If you have any questions or need help, you might be able to find me on irc.freenode.net (#helium)
