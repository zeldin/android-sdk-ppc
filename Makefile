
ANDROID_INSTALL_DIR = /usr/local/android

ANDROID_JAVA_HOME=/usr/lib/jvm/icedtea-7

BUILD_TOOLS_VER=23.0.1

# Build all the architecture dependant stuff by default
.DEFAULT_GOAL := archdep

.DEFAULT:
	@test -f build/core/root.mk || $(MAKE) setup-submodules
	@test -f prebuilts/eclipse-build-deps/cdt/cdt-master-8.0.0.zip || $(MAKE) download-eclipse-drops
	@env PATH="$(ANDROID_JAVA_HOME)/bin:$$PATH" ANDROID_JAVA_HOME=$(ANDROID_JAVA_HOME) $(MAKE) -f ppcsdk.mk TARGET_PRODUCT=sdk SDK_ONLY=true main_subdir_makefiles='$$(ppcsdk_subdir_makefiles)' BISON=bison LEX=flex MY_ANDROID_DIR='$(ANDROID_INSTALL_DIR)' MY_BUILD_TOOLS_VER='$(BUILD_TOOLS_VER)' CLANG=clang CLANG_CXX=clang++ LLVM_AS=llvm-as LLVM_LINK=llvm-link LEGACY_USE_JAVA6=true FORCE_BUILD_LLVM_COMPONENTS=true $@

setup-submodules:
	@echo Setting up submodules, please wait...
	git submodule init
	git submodule update
	@echo Submodules set up, your build will now resume

download-eclipse-drops:
	@echo Downloading Eclipse drops, please wait...
	@wget -O prebuilts/eclipse-build-deps/cdt/cdt-master-8.0.0.zip http://download.eclipse.org/tools/cdt/releases/indigo/dist/cdt-master-8.0.0.zip
	@echo Eclipse drops downloaded, your build will now resume
