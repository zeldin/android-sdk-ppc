
ANDROID_INSTALL_DIR = /usr/local/android

ANDROID_JAVA_HOME=/usr/lib/jvm/ibm-jdk-bin-1.6

# Build all the architecture dependant stuff by default
.DEFAULT_GOAL := archdep

.DEFAULT:
	@test -f build/core/root.mk || $(MAKE) setup-submodules
	@test -f prebuilts/eclipse/deltapack/eclipse-M20130124-1500-delta-pack.zip || $(MAKE) download-eclipse-drops
	@env ANDROID_JAVA_HOME=$(ANDROID_JAVA_HOME) $(MAKE) -f ppcsdk.mk TARGET_PRODUCT=sdk SDK_ONLY=true BUILD_EMULATOR_OPENGL=true subdir_makefiles='$$(ppcsdk_subdir_makefiles)' MY_CC='$$(HOST_CC)' MY_CXX='$$(HOST_CXX)' MY_AR='$$(HOST_AR)' MY_ANDROID_DIR='$(ANDROID_INSTALL_DIR)' $@

setup-submodules:
	@echo Setting up submodules, please wait...
	git submodules init
	git submodules update
	@echo Submodules set up, your build will now resume

download-eclipse-drops:
	@echo Downloading Eclipse drops, please wait...
	@wget -O prebuilts/eclipse/platform/org.eclipse.platform-M20130124-1500.zip http://download.eclipse.org/eclipse/downloads/drops/M20130124-1500/org.eclipse.platform-M20130124-1500.zip
	@wget -O prebuilts/eclipse/deltapack/eclipse-M20130124-1500-delta-pack.zip http://download.eclipse.org/eclipse/downloads/drops/M20130124-1500/eclipse-M20130124-1500-delta-pack.zip
	@echo Eclipse drops downloaded, your build will now resume
