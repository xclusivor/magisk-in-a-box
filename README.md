# magisk-in-a-box
Dockerized Magisk that let's you easily root boot images without the need for an Android device or emulator.

## Why
Due to the way Magisk works, there is no particular reason patching needs to be done on-device. This tool lets you patch images as long as you have the ability to use Docker. This can be useful in situations where MTP and/or ADB are unreliable. You also won't have to push the images to the device, patch, then pull them off.

This thing is overkill, but there is a quite a bit of setup if you're to do this manually.

## How
Magisk actually provides several shell scripts to patch images in an Android environment. Though intended for Android, the scripts mostly work outside of it. This tool makes them easy to use.

The Docker image will do the following:
1. Install necessary packages
2. Setup the Android SDK
3. Clone magisk from: https://github.com/topjohnwu/Magisk.git
4. Compile Magisk's native binaries and stub apk

## Usage

Build the image (This will take a long time): `docker run -t miab`

Start an interactive shell: `docker run --rm -it -v $(pwd):/home/miab/host miab`

Run MIAB: `./miab.sh <32/64> <boot.img/AP...tar.md5>`

If given an AP file, the boot.img will be output as an Odin flashable `.tar.md5`. Patched images are output to your host's filesystem where you ran the image. 

## Without Docker
1. Build Magisk's native binaries and stub apk. 
2. Place the `magiskboot` binary that matches your **hosts** architecture in Magsk's `scripts/` directory.
2. Place the `magiskinit` and `magisk` binaries that matches your **targets** architecture in the `scripts/` directory. (adding 32 or 64 to the end of the `magisk` binary depending on target architecture)
3. Place `./miab.sh` in the `scripts/` folder and refer to usage above.

## Notes
- Magisk in a Box currently only supports ARM and AArch64 targets. x86 and x86_64 are trivial to add, but are not in the initial release.
- I've only tested this tool on boot images. Single and split vbmeta images are not currently supported.

**Disclaimer: Magisk in a Box is not affiliated with or supported by the offcial Magisk project**
