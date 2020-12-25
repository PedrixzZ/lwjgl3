#!/bin/bash
set -e


# wget http://beanshell.org/bsh-2.0b5.jar
# mv bsh-2.0b5.jar $ANT_HO
# ls *

cd ios_build

# Build dyncall-1.0
wget -nv -O dyncall-1.0.tar.gz "https://www.dyncall.org/r1.0/dyncall-1.0.tar.gz"
tar xf dyncall-1.0.tar.gz
chmod +x build_dyncall.bash
./build_dyncall.bash

# FIXME make it better, ex put to function
# But it compile error!
(cd dyncall-1.0 && make)
# (cd dyncall-1.0/android_arm_build/ && make)
# (cd dyncall-1.0/android_x86_64_build/ && make)
# (cd dyncall-1.0/android_x86_build/ && make)

cp dyncall-1.0/ios_arm64_build/dyncall/libdyncall_s.a \
	dyncall-1.0/ios_arm64_build/dyncallback/libdyncallback_s.a \
	dyncall-1.0/ios_arm64_build/dynload/libdynload_s.a \
	jni/arm64-v8a/
	
cd ..

ant -version

# Disable driftfx because some JDKs (eg OpenJDK on Ubuntu) don't come with JavaFX
# Ignore ant build, since we are only building native code
 ANT_OPTS="-Dnashorn.args=\"--no-deprecation-warning\"" \

ant -Dplatform.ios=true -Dbinding.bullet=false -Dbinding.driftfx=false compile-templates compile release

# Build LWJGL Android native libraries
"$ANDROID_NDK_HOME/ndk-build"

# Copy debug libs
cp -r obj/local libs_debug
rm -r libs_debug/*/objs*

