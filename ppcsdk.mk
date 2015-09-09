ppcsdk_subdirs = \
	build/tools \
	build/libs \
	system/core/adb \
	system/core/base \
	system/core/fastboot \
	system/core/libcutils \
	system/core/liblog \
	system/core/libsparse \
	system/core/libutils \
	system/core/libziparchive \
	system/core/libzipfile \
	system/extras/ext4_utils \
	system/extras/f2fs_utils \
	frameworks/base \
	frameworks/compile/libbcc \
	frameworks/compile/mclinker \
	frameworks/compile/slang \
	frameworks/native/libs \
	frameworks/native/opengl/libs \
	frameworks/rs \
	frameworks/support \
	frameworks/opt/telephony \
	development/tools/etc1tool \
	dalvik/dexdump \
	dalvik/dx \
	dalvik/libdex \
	dalvik/tools \
	external/apache-http \
	external/ant-glob \
	external/bouncycastle \
	external/clang \
	external/compiler-rt \
	external/e2fsprogs/lib/uuid \
	external/easymock \
	external/eclipse-windowbuilder \
	external/expat \
	external/hamcrest \
	external/junit \
	external/libcxx \
	external/libcxxabi \
	external/liblzf \
	external/libphonenumber \
	external/libpng \
	external/libunwind \
	external/llvm \
	external/zlib \
	external/nist-sip \
	external/openssl \
	external/okhttp \
	external/proguard \
	external/protobuf \
	external/libselinux \
	external/pcre \
	external/stlport \
	external/sqlite \
	external/tagsoup \
	external/qemu \
	external/zopfli \
	sdk/adtproductbuild \
	sdk/emulator/mksdcard \
	sdk/emulator/opengl \
	sdk/monitor \
	sdk/common \
	sdk/sdkstats \
	sdk/sdkmanager/libs \
	sdk/layoutlib_api \
	sdk/device_validator/dvlib \
	sdk/ninepatch \
	sdk/rule_api \
	sdk/ddms/libs \
	sdk/uiautomatorviewer \
	sdk/testutils \
	sdk/hierarchyviewer2/libs \
	sdk/traceview \
	prebuilds/sdk \
	prebuilts/tools \
	prebuilts/misc \
	libcore

ppcsdk_subdir_makefiles := \
	$(shell build/tools/findleaves.py --prune=out --prune=.repo --prune=.git $(ppcsdk_subdirs) Android.mk)

include build/core/root.mk

MY_TOOLS := \
	$(HOST_OUT_EXECUTABLES)/mksdcard \
	$(HOST_OUT_EXECUTABLES)/emulator \
	$(HOST_OUT_EXECUTABLES)/emulator-arm \
	$(HOST_OUT_EXECUTABLES)/emulator-mips \
	$(HOST_OUT_EXECUTABLES)/emulator-x86 \
	$(HOST_OUT_EXECUTABLES)/emulator64-arm \
	$(HOST_OUT_EXECUTABLES)/emulator64-mips \
	$(HOST_OUT_EXECUTABLES)/emulator64-x86

MY_PLATFORM_TOOLS := \
	$(HOST_OUT_EXECUTABLES)/adb \
	$(HOST_OUT_EXECUTABLES)/dmtracedump \
	$(HOST_OUT_EXECUTABLES)/etc1tool \
	$(HOST_OUT_EXECUTABLES)/fastboot \
	$(HOST_OUT_EXECUTABLES)/hprof-conv \
	$(HOST_OUT_EXECUTABLES)/sqlite3

MY_PLATFORM_TOOLS_LIBS := \
	$(HOST_OUT_SHARED_LIBRARIES)/libc++.so

MY_BUILD_TOOLS := \
	$(HOST_OUT_EXECUTABLES)/aapt \
	$(HOST_OUT_EXECUTABLES)/aidl \
	$(HOST_OUT_EXECUTABLES)/dexdump \
	$(HOST_OUT_EXECUTABLES)/llvm-rs-cc \
	$(HOST_OUT_EXECUTABLES)/bcc_compat \
	$(HOST_OUT_EXECUTABLES)/zipalign

MY_BUILD_TOOLS_LIBS := \
	$(HOST_OUT_SHARED_LIBRARIES)/libLLVM.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libbcc.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libbcinfo.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libclang.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libc++.so

tools: $(MY_TOOLS) $(MY_PLATFORM_TOOLS) $(MY_PLATFORM_TOOLS_LIBS) $(MY_BUILD_TOOLS) $(MY_BUILD_TOOLS_LIBS)
	$(HOST_OUT_EXECUTABLES)/adb kill-server
	cp $(MY_TOOLS) $(MY_ANDROID_DIR)/tools/
	test -d $(MY_ANDROID_DIR)/platform-tools || mkdir $(MY_ANDROID_DIR)/platform-tools
	cp $(MY_PLATFORM_TOOLS) $(MY_ANDROID_DIR)/platform-tools/
	cp $(MY_PLATFORM_TOOLS_LIBS) $(MY_ANDROID_DIR)/platform-tools/lib/
	test -d $(MY_ANDROID_DIR)/build-tools || mkdir $(MY_ANDROID_DIR)/build-tools
	test -d $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER) || mkdir $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)
	test -d $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/lib || mkdir $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/lib
	cp $(MY_BUILD_TOOLS) $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/
	cp $(MY_BUILD_TOOLS_LIBS) $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/lib/
	cp ld-command $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/i686-linux-android-ld
	cp ld-command $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/mipsel-linux-android-ld
	cp ld-command $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/arm-linux-androideabi-ld

MY_GL_LIBS := \
	$(HOST_OUT_SHARED_LIBRARIES)/libOpenglRender.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libGLES_CM_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libGLES_V2_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libEGL_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libemugl_test_shared_library.so \
	$(HOST_OUT_SHARED_LIBRARIES)/lib64OpenglRender.so \
	$(HOST_OUT_SHARED_LIBRARIES)/lib64GLES_CM_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/lib64GLES_V2_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/lib64EGL_translator.so \
	$(HOST_OUT_SHARED_LIBRARIES)/lib64emugl_test_shared_library.so

opengl: $(MY_GL_LIBS)
	cp $(MY_GL_LIBS) $(MY_ANDROID_DIR)/tools/lib/

BUNDLES_VERSION := bundles-24.3.3-SNAPSHOT

monitor: $(HOST_OUT_ROOT)/maven/$(BUNDLES_VERSION)/$(BUNDLES_VERSION).zip
	cp -TR $(HOST_OUT_ROOT)/maven/$(BUNDLES_VERSION)/products/monitorproduct/linux/gtk/ppc/monitor $(MY_ANDROID_DIR)/tools/lib/monitor-ppc
	cp -TR $(HOST_OUT_ROOT)/maven/$(BUNDLES_VERSION)/products/monitorproduct/linux/gtk/ppc64/monitor $(MY_ANDROID_DIR)/tools/lib/monitor-ppc64

$(HOST_OUT_ROOT)/maven/$(BUNDLES_VERSION)/$(BUNDLES_VERSION).zip: tools/gradlew tools/build.gradle tools/settings.gradle
	@cd tools && ./gradlew publishLocal :sdk:eclipse:copydeps :sdk:eclipse:buildEclipse

tools/%: tools/buildSrc/base/%
	cp $< $@

swt_jar: $(HOST_OUT_JAVA_LIBRARIES)/swt.jar
	test -d $(MY_ANDROID_DIR)/tools/lib/ppc || mkdir $(MY_ANDROID_DIR)/tools/lib/ppc
	cp $(HOST_OUT_JAVA_LIBRARIES)/swt.jar $(MY_ANDROID_DIR)/tools/lib/ppc/

archdep: tools opengl monitor swt_jar

