
Android SDK for Linux/PPC
=========================

This project will compile the architecture dependant parts of the
Android SDK on a Linux/PPC system.  Combined with the architecture
independant parts which can be downloaded from Google, a fully(?)
functional Android SDK running on Linux/PPC is the result.


Prerequesites
=============

Before you start, check that you have the following:

* A Linux/PPC system (duh).  I have only tested building in a 32-bit userland.

* A toolchain capable of building 64-bit binaries.  This also entails having
  things like libc and libstdc++ available as 64-bit libraries.

* Xorg and Mesa libraries, in both 32-bit and 64-bit variants.

* IBM JDK 1.6


Installation
============

* First, download `android-sdk_r22-linux.tgz` from
  <http://developer.android.com/sdk/index.html>.  This contains the
  architecture independant part of the tools (and a bunch of x86 binaries,
  go figure...)

* Extract the SDK files somewhere you would like to have them.  The top level
  directory of the extracted data (the one which contains the directories
  `tools`, `platforms` and `add-ons`) is your `ANDROID_INSTALL_DIR`.

* Next, edit the Makefile for this project to set the `ANDROID_INSTALL_DIR`
  variable to the directory just mentioned.

* Now, you can run `make` in the `android-sdk-ppc` directory to build and
  install all the architecture dependant stuff for PPC.

* While `make` is running, make yourself a nice cup of tea, it takes quite
  a while.  :-)

* When (if?) `make` completes successfully, you can run `tools/android`
  in the `ANDROID_INSTALL_DIR` to launch the Android SDK Manager.

* The first thing you should do is to upgrade the Android SDK Tools to the
  latest version (if that's not the version you already have), and install
  the Android SDK Platform-tools and Android SDK Build-tools.  Ignore any
  warnings about ADB server failing to start or stop.  When the latest
  version of both packages is installed (several upgrade steps may be needed),
  quit the Android SDK Manager.

* Unfortunately, installing/upgrading the Tools, Platform-tools  and/or
  Build-tools package, like you just did, will overwrite the PPC binaries
  with x86 binaries.  (This is  the reason why the ADB server stop/start
  fails, by the way.)  So now,  you will need to run `make` in
  `android-sdk-ppc` once more.  It will be much faster this time though,
  since everything is compiled already.  Remember to repeat this process
  everytime you upgrade the Tools or Platform-tools packages through the
  Android SDK Manager.

* Each time you upgrade Build-tools, make sure the `BUILD_TOOLS_VER` in
  the Makefile matches the latest version you have under the `build-tools`
  directory in `ANDROID_INSTALL_DIR`.  This will allow `make` to install
  the Build-tools in the correct directory.

* After reinstalling the PPC binaries, you can start the Android SDK Manager
  again, and install the API:s etc. you need.


