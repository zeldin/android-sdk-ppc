
ANDROID_INSTALL_DIR = /usr/local/android

ANDROID_JAVA_HOME=/usr/lib/jvm/ibm-jdk-bin-1.6

BUILD_TOOLS_VER=18.0.1

# Build all the architecture dependant stuff by default
.DEFAULT_GOAL := archdep

.DEFAULT:
	@test -f build/core/root.mk || $(MAKE) setup-submodules
	@test -f prebuilts/eclipse/deltapack/eclipse-3.8.2-delta-pack.zip || $(MAKE) download-eclipse-drops
	@env ANDROID_JAVA_HOME=$(ANDROID_JAVA_HOME) $(MAKE) -f ppcsdk.mk TARGET_PRODUCT=sdk SDK_ONLY=true BUILD_EMULATOR_OPENGL=true subdir_makefiles='$$(ppcsdk_subdir_makefiles)' MY_CC='$$(HOST_CC)' MY_CXX='$$(HOST_CXX)' MY_AR='$$(HOST_AR)' BISON=bison MY_ANDROID_DIR='$(ANDROID_INSTALL_DIR)' MY_BUILD_TOOLS_VER='$(BUILD_TOOLS_VER)' $@

setup-submodules:
	@echo Setting up submodules, please wait...
	git submodule init
	git submodule update
	@echo Submodules set up, your build will now resume

download-eclipse-drops:
	@echo Downloading Eclipse drops, please wait...
	@wget -O prebuilts/eclipse/platform/org.eclipse.platform-3.8.2.zip http://download.eclipse.org/eclipse/downloads/drops/R-3.8.2-201301310800/org.eclipse.platform-3.8.2.zip
	@wget -O prebuilts/eclipse/deltapack/eclipse-3.8.2-delta-pack.zip http://download.eclipse.org/eclipse/downloads/drops/R-3.8.2-201301310800/eclipse-3.8.2-delta-pack.zip
	@echo Eclipse drops downloaded, your build will now resume
