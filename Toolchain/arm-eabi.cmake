set(CMAKE_SYSTEM_NAME GNU)

set(ANDROID TRUE)
set(ANDROID_API_VERSION 23 CACHE STRING "Android API Version")
set(ANDROID_NDK_API_VERSION ${ANDROID_API_VERSION} CACHE STRING "Android NDK API Version")
set(ANDROID_ARCH "armeabi" CACHE STRING "Android architecture")

find_program(CMAKE_C_COMPILER NAMES arm-eabi-gcc arm-eabi-gcc.exe arm-linux-androideabi-gcc arm-linux-androideabi-gcc.exe)
find_program(CMAKE_CXX_COMPILER NAMES arm-eabi-gcc arm-eabi-g++.exe arm-linux-androideabi-g++ arm-linux-androideabi-g++.exe)
set(PKG_CONFIG_EXECUTABLE "arm-eabi-pkg-config")

get_filename_component(COMPILER_PATH ${CMAKE_C_COMPILER} PATH)

set(ANDROID_NDK "${COMPILER_PATH}/../../../../.." CACHE STRING "PATH to Android NDK")

set(NDK_ARCH_DIR "${ANDROID_NDK}/platforms/android-${ANDROID_NDK_API_VERSION}/arch-arm")
set(CMAKE_FIND_ROOT_PATH ${NDK_ARCH_DIR})

set(CMAKE_REQUIRED_FLAGS "-ldl --sysroot=${NDK_ARCH_DIR} ${EXTRA_COMPILER_FLAGS} -D__STDC_VERSION__=199901L -D__ANDROID_API__=${ANDROID_API_VERSION} -D_GNU_SOURCE")
set(NAVIT_INCLUDES "${ANDROID_NDK}/sysroot/usr/include")
set(CMAKE_REQUIRED_INCLUDES "${NAVIT_INCLUDES}" "${NAVIT_INCLUDES}/arm-linux-androideabi")

set(NAVIT_COMPILE_FLAGS "-I${NAVIT_INCLUDES} -I${NAVIT_INCLUDES}/arm-linux-androideabi -g -DANDROID -fno-short-enums ${CMAKE_REQUIRED_FLAGS}")

set(CMAKE_SHARED_LINKER_FLAGS_INIT "${CMAKE_REQUIRED_FLAGS} -Wl,--no-undefined -Wl,-rpath,/system/lib")
set(CMAKE_EXE_LINKER_FLAGS_INIT "${CMAKE_REQUIRED_FLAGS} -Wl,--no-undefined")
set(CMAKE_MODULE_LINKER_FLAGS_INIT "${CMAKE_REQUIRED_FLAGS} -Wl,-rpath,/data/data/org.navitproject.navit/lib")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
