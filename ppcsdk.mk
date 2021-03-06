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
	$(HOST_OUT_EXECUTABLES)/zipalign \
	$(HOST_OUT_EXECUTABLES)/split-select

MY_BUILD_TOOLS_LIBS := \
	$(HOST_OUT_SHARED_LIBRARIES)/libLLVM.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libbcc.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libbcinfo.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libclang.so \
	$(HOST_OUT_SHARED_LIBRARIES)/libc++.so

tools: $(MY_TOOLS) $(MY_PLATFORM_TOOLS) $(MY_PLATFORM_TOOLS_LIBS) $(MY_BUILD_TOOLS) $(MY_BUILD_TOOLS_LIBS)
	$(HOST_OUT_EXECUTABLES)/adb kill-server
	cp $(MY_TOOLS) $(MY_ANDROID_DIR)/tools/
	strip -S $(addprefix $(MY_ANDROID_DIR)/tools/,$(notdir $(MY_TOOLS)))
	test -d $(MY_ANDROID_DIR)/platform-tools || mkdir $(MY_ANDROID_DIR)/platform-tools
	cp $(MY_PLATFORM_TOOLS) $(MY_ANDROID_DIR)/platform-tools/
	strip -S $(addprefix $(MY_ANDROID_DIR)/platform-tools/,$(notdir $(MY_PLATFORM_TOOLS)))
	cp $(MY_PLATFORM_TOOLS_LIBS) $(MY_ANDROID_DIR)/platform-tools/lib/
	strip -S $(addprefix $(MY_ANDROID_DIR)/platform-tools/lib/,$(notdir $(MY_PLATFORM_TOOLS_LIBS)))
	test -d $(MY_ANDROID_DIR)/build-tools || mkdir $(MY_ANDROID_DIR)/build-tools
	test -d $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER) || mkdir $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)
	test -d $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/lib || mkdir $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/lib
	cp $(MY_BUILD_TOOLS) $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/
	strip -S $(addprefix $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/,$(notdir $(MY_BUILD_TOOLS)))
	cp $(MY_BUILD_TOOLS_LIBS) $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/lib/
	strip -S $(addprefix $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/lib/,$(notdir $(MY_BUILD_TOOLS_LIBS)))
	cp ld-command $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/i686-linux-android-ld
	cp ld-command $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/mipsel-linux-android-ld
	cp ld-command $(MY_ANDROID_DIR)/build-tools/$(MY_BUILD_TOOLS_VER)/arm-linux-androideabi-ld

EMULATOR_OUT := $(HOST_OUT)/emulator

MY_EMULATOR_BINARIES := \
	$(EMULATOR_OUT)/emulator \
	$(EMULATOR_OUT)/emulator-arm \
	$(EMULATOR_OUT)/emulator-mips \
	$(EMULATOR_OUT)/emulator-x86 \
	$(EMULATOR_OUT)/emulator-ranchu-arm64 \
	$(EMULATOR_OUT)/emulator-ranchu-mips64 \
	$(EMULATOR_OUT)/emulator64-arm \
	$(EMULATOR_OUT)/emulator64-mips \
	$(EMULATOR_OUT)/emulator64-x86 \
	$(EMULATOR_OUT)/emulator64-ranchu-arm64 \
	$(EMULATOR_OUT)/emulator64-ranchu-mips64

MY_EMULATOR_LIBS := \
	$(EMULATOR_OUT)/lib/libOpenglRender.so \
	$(EMULATOR_OUT)/lib/libGLES_CM_translator.so \
	$(EMULATOR_OUT)/lib/libGLES_V2_translator.so \
	$(EMULATOR_OUT)/lib/libEGL_translator.so \
	$(EMULATOR_OUT)/lib/libemugl_test_shared_library.so

MY_EMULATOR_LIBS64 := \
	$(EMULATOR_OUT)/lib64/lib64OpenglRender.so \
	$(EMULATOR_OUT)/lib64/lib64GLES_CM_translator.so \
	$(EMULATOR_OUT)/lib64/lib64GLES_V2_translator.so \
	$(EMULATOR_OUT)/lib64/lib64EGL_translator.so \
	$(EMULATOR_OUT)/lib64/lib64emugl_test_shared_library.so

emulator: $(EMULATOR_OUT)/config-host.h $(EMULATOR_OUT)/config.make
	cd external/qemu && make -j2 OBJS_DIR=../../$(EMULATOR_OUT)
	cp $(MY_EMULATOR_BINARIES) $(MY_ANDROID_DIR)/tools/
	strip -S $(addprefix $(MY_ANDROID_DIR)/tools/,$(notdir $(MY_EMULATOR_BINARIES)))
	cp $(MY_EMULATOR_LIBS) $(MY_ANDROID_DIR)/tools/lib/
	strip -S $(addprefix $(MY_ANDROID_DIR)/tools/lib/,$(notdir $(MY_EMULATOR_LIBS)))
	cp $(MY_EMULATOR_LIBS64) $(MY_ANDROID_DIR)/tools/lib64/
	strip -S $(addprefix $(MY_ANDROID_DIR)/tools/lib64/,$(notdir $(MY_EMULATOR_LIBS64)))

$(EMULATOR_OUT)/config-host.h $(EMULATOR_OUT)/config.make:
	external/qemu/android-configure.sh --out-dir=../../$(EMULATOR_OUT) --verbose --no-pcbios --cc=gcc

EMULATOR32_OUT := $(HOST_OUT)/qemu-linux-ppc
EMULATOR64_OUT := $(HOST_OUT)/qemu-linux-ppc64

MY_EMULATOR32_BINARIES := \
	$(EMULATOR32_OUT)/aarch64-softmmu/qemu-system-aarch64 \
	$(EMULATOR32_OUT)/mips64el-softmmu/qemu-system-mips64el

MY_EMULATOR64_BINARIES := \
	$(EMULATOR64_OUT)/aarch64-softmmu/qemu-system-aarch64 \
	$(EMULATOR64_OUT)/mips64el-softmmu/qemu-system-mips64el

emulator2: $(EMULATOR32_OUT)/config-host.mak $(EMULATOR64_OUT)/config-host.mak
	cd $(EMULATOR32_OUT) && make -j2
	cd $(EMULATOR64_OUT) && make -j2
	test -d $(MY_ANDROID_DIR)/tools/qemu || mkdir $(MY_ANDROID_DIR)/tools/qemu
	test -d $(MY_ANDROID_DIR)/tools/qemu/linux-ppc || mkdir $(MY_ANDROID_DIR)/tools/qemu/linux-ppc
	test -d $(MY_ANDROID_DIR)/tools/qemu/linux-ppc64 || mkdir $(MY_ANDROID_DIR)/tools/qemu/linux-ppc64
	cp $(MY_EMULATOR32_BINARIES) $(MY_ANDROID_DIR)/tools/qemu/linux-ppc/
	strip -S $(addprefix $(MY_ANDROID_DIR)/tools/qemu/linux-ppc/,$(notdir $(MY_EMULATOR32_BINARIES)))
	cp $(MY_EMULATOR64_BINARIES) $(MY_ANDROID_DIR)/tools/qemu/linux-ppc64/
	strip -S $(addprefix $(MY_ANDROID_DIR)/tools/qemu/linux-ppc64/,$(notdir $(MY_EMULATOR64_BINARIES)))

$(HOST_OUT)/qemu-linux-%/config-host.mak: external/qemu-android/dtc/Makefile
	@test -d $(@D) || mkdir $(@D)
	cd $(@D) && $(CURDIR)/external/qemu-android/configure --cpu=$* --target-list="aarch64-softmmu mips64el-softmmu" --extra-ldflags="-static-libgcc -static-libstdc++ -ldl -lm" --audio-drv-list=pa --disable-attr --disable-blobs --disable-cap-ng --disable-curl --disable-curses --disable-docs --disable-glusterfs --disable-gtk --disable-guest-agent --disable-libnfs --disable-libiscsi --disable-libssh2 --disable-libusb --disable-quorum --disable-seccomp --disable-spice --disable-smartcard-nss --disable-usb-redir --disable-user --disable-vde --disable-vhdx --disable-vhost-net --disable-vte --disable-werror --with-sdlabi=2.0

external/qemu-android/dtc/Makefile:
	cd external/qemu-android && git submodule update --init dtc

MESA_OUT := $(HOST_OUT)/mesa
MESA_PATCHES := $(MESA_OUT)/MesaLib-10.4.2-patches
MESA_ARCHIVE := $(MESA_OUT)/MesaLib-10.4.2.tar.bz2
MESA_SRC := $(MESA_OUT)/Mesa-10.4.2
MESA_URL := ftp://ftp.freedesktop.org/pub/mesa/10.4.2/MesaLib-10.4.2.tar.bz2

MESA_LIBS := \
	$(MESA_SRC)/build/linux-ppc/gallium/targets/libgl-xlib/libGL.so.1 \
	$(MESA_SRC)/build/linux-ppc/gallium/targets/libgl-xlib/libGL.so \
	$(MESA_SRC)/build/linux-ppc/gallium/targets/osmesa/libosmesa.so

MESA_LIBS64 := \
	$(MESA_SRC)/build/linux-ppc64/gallium/targets/libgl-xlib/libGL.so.1 \
	$(MESA_SRC)/build/linux-ppc64/gallium/targets/libgl-xlib/libGL.so \
	$(MESA_SRC)/build/linux-ppc64/gallium/targets/osmesa/libosmesa.so

mesa : $(MESA_LIBS) $(MESA_LIBS64)
	test -d $(MY_ANDROID_DIR)/tools/lib/gles_mesa || mkdir $(MY_ANDROID_DIR)/tools/lib/gles_mesa
	test -d $(MY_ANDROID_DIR)/tools/lib64/gles_mesa || mkdir $(MY_ANDROID_DIR)/tools/lib64/gles_mesa
	cp -Lf $(MESA_LIBS) $(MY_ANDROID_DIR)/tools/lib/gles_mesa
	strip -S $(addprefix $(MY_ANDROID_DIR)/tools/lib/gles_mesa/,$(notdir $(MESA_LIBS)))
	cp -Lf $(MESA_LIBS64) $(MY_ANDROID_DIR)/tools/lib64/gles_mesa
	strip -S $(addprefix $(MY_ANDROID_DIR)/tools/lib64/gles_mesa/,$(notdir $(MESA_LIBS64)))

$(MESA_LIBS) : $(MESA_OUT)/.patched
	scons -j2 -C $(MESA_SRC) build=release llvm=no verbose=true machine=ppc libgl-xlib libgl-osmesa

$(MESA_LIBS64) : $(MESA_OUT)/.patched
	scons -j2 -C $(MESA_SRC) build=release llvm=no verbose=true machine=ppc64 libgl-xlib libgl-osmesa

$(MESA_OUT)/.patched: $(MESA_PATCHES) mesa_scons.patch | $(MESA_SRC)
	for f in $(MESA_PATCHES)/*.patch; do patch -p1 -d $(MESA_SRC) < $$f; done
	patch -p1 -d $(MESA_SRC) < mesa_scons.patch
	touch $@

$(MESA_SRC): $(MESA_ARCHIVE)
	tar -C $(MESA_OUT) -x -j -f $(MESA_ARCHIVE)

$(MESA_ARCHIVE): | $(MESA_OUT)
	curl -L -o $@ $(MESA_URL)

$(MESA_PATCHES): | $(MESA_OUT)
	tar -C $(MESA_OUT) -x -J -f external/qemu/android/dependencies/$(notdir $(MESA_PATCHES)).tar.xz

$(MESA_OUT):
	test -d $@ || mkdir $@

BUNDLES_VERSION := bundles-24.3.3-SNAPSHOT

monitor: $(HOST_OUT_ROOT)/maven/$(BUNDLES_VERSION)/$(BUNDLES_VERSION).zip
	cp -TR $(HOST_OUT_ROOT)/maven/$(BUNDLES_VERSION)/products/monitorproduct/linux/gtk/ppc/monitor $(MY_ANDROID_DIR)/tools/lib/monitor-ppc
	cp -TR $(HOST_OUT_ROOT)/maven/$(BUNDLES_VERSION)/products/monitorproduct/linux/gtk/ppc64/monitor $(MY_ANDROID_DIR)/tools/lib/monitor-ppc64
	find $(MY_ANDROID_DIR)/tools/lib/monitor-ppc $(MY_ANDROID_DIR)/tools/lib/monitor-ppc64 -name '*.so' -print0 | xargs -0 strip -S
	strip -S $(MY_ANDROID_DIR)/tools/lib/monitor-ppc/monitor
	strip -S $(MY_ANDROID_DIR)/tools/lib/monitor-ppc64/monitor

$(HOST_OUT_ROOT)/maven/$(BUNDLES_VERSION)/$(BUNDLES_VERSION).zip: tools/gradlew tools/build.gradle tools/settings.gradle
	@cd tools && ./gradlew publishLocal :sdk:eclipse:copydeps :sdk:eclipse:buildEclipse

tools/%: tools/buildSrc/base/%
	cp $< $@

swt_jar: $(HOST_OUT_JAVA_LIBRARIES)/swt.jar
	test -d $(MY_ANDROID_DIR)/tools/lib/ppc || mkdir $(MY_ANDROID_DIR)/tools/lib/ppc
	cp $(HOST_OUT_JAVA_LIBRARIES)/swt.jar $(MY_ANDROID_DIR)/tools/lib/ppc/

archdep: tools emulator emulator2 mesa monitor swt_jar

