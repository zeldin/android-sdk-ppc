ppcsdk_subdirs = \
	build/tools \
	build/libs \
	system/core/adb \
	system/core/fastboot \
	system/core/libcutils \
	system/core/liblog \
	system/core/libsparse \
	system/core/libzipfile \
	system/extras/ext4_utils \
	frameworks/base/libs \
	frameworks/base/tools \
	frameworks/native/libs \
	frameworks/native/opengl/libs \
	development/tools/etc1tool \
	dalvik/dexdump \
	dalvik/libdex \
	dalvik/tools \
	external/ant-glob \
	external/easymock \
	external/eclipse-windowbuilder \
	external/expat \
	external/hamcrest \
	external/junit \
	external/libpng \
	external/zlib \
	external/openssl \
	external/libselinux \
	external/sqlite \
	external/qemu \
	sdk/emulator/mksdcard \
	sdk/emulator/opengl \
	sdk/monitor \
	sdk/common \
	sdk/sdkstats \
	sdk/sdkmanager/libs \
	sdk/layoutlib_api \
	sdk/device_validator/dvlib \
	prebuilds/sdk \
	prebuilts/tools \
	prebuilts/misc \
	libcore

ppcsdk_subdir_makefiles := \
	$(shell build/tools/findleaves.py --prune=out --prune=.repo --prune=.git $(ppcsdk_subdirs) Android.mk)

include build/core/root.mk

MY_TOOLS := \
	$(HOST_OUT_EXECUTABLES)/dmtracedump \
	$(HOST_OUT_EXECUTABLES)/etc1tool \
	$(HOST_OUT_EXECUTABLES)/hprof-conv \
	$(HOST_OUT_EXECUTABLES)/mksdcard \
	$(HOST_OUT_EXECUTABLES)/sqlite3 \
	$(HOST_OUT_EXECUTABLES)/zipalign \
	$(HOST_OUT_EXECUTABLES)/emulator \
	$(HOST_OUT_EXECUTABLES)/emulator-arm \
	$(HOST_OUT_EXECUTABLES)/emulator-mips \
	$(HOST_OUT_EXECUTABLES)/emulator-ui \
	$(HOST_OUT_EXECUTABLES)/emulator-x86 \
	$(HOST_OUT_EXECUTABLES)/emulator64-arm \
	$(HOST_OUT_EXECUTABLES)/emulator64-mips \
	$(HOST_OUT_EXECUTABLES)/emulator64-x86

MY_PLATFORM_TOOLS := \
	$(HOST_OUT_EXECUTABLES)/aapt \
	$(HOST_OUT_EXECUTABLES)/adb \
	$(HOST_OUT_EXECUTABLES)/aidl \
	$(HOST_OUT_EXECUTABLES)/dexdump \
	$(HOST_OUT_EXECUTABLES)/fastboot

tools: $(MY_TOOLS) $(MY_PLATFORM_TOOLS)
	$(HOST_OUT_EXECUTABLES)/adb kill-server
	cp $(MY_TOOLS) $(MY_ANDROID_DIR)/tools/
	cp $(MY_PLATFORM_TOOLS) $(MY_ANDROID_DIR)/platform-tools/
	rm -f $(MY_ANDROID_DIR)/platform-tools/llvm-rs-cc

MY_GL_LIBS := \
	$(HOST_OUT_SHARED_LIBRARIES)/libOpenglRender.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libGLES_CM_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libGLES_V2_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libEGL_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/lib64OpenglRender.so \
	$(HOST_OUT_SHARED_LIBRARIES)/lib64GLES_CM_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/lib64GLES_V2_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/lib64EGL_translator.so

opengl: $(MY_GL_LIBS)
	cp $(MY_GL_LIBS) $(MY_ANDROID_DIR)/tools/lib/

monitor: $(HOST_OUT_EXECUTABLES)/monitor

archdep: tools opengl

