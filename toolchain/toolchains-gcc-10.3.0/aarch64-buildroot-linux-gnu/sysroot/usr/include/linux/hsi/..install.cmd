cmd_/builds/bootlin/toolchains-builder/build/aarch64--glibc--stable-2021.11-1/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/hsi/.install := /bin/bash scripts/headers_install.sh /builds/bootlin/toolchains-builder/build/aarch64--glibc--stable-2021.11-1/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/hsi ./include/uapi/linux/hsi cs-protocol.h hsi_char.h; /bin/bash scripts/headers_install.sh /builds/bootlin/toolchains-builder/build/aarch64--glibc--stable-2021.11-1/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/hsi ./include/linux/hsi ; /bin/bash scripts/headers_install.sh /builds/bootlin/toolchains-builder/build/aarch64--glibc--stable-2021.11-1/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/hsi ./include/generated/uapi/linux/hsi ; for F in ; do echo "$(pound)include <asm-generic/$$F>" > /builds/bootlin/toolchains-builder/build/aarch64--glibc--stable-2021.11-1/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/hsi/$$F; done; touch /builds/bootlin/toolchains-builder/build/aarch64--glibc--stable-2021.11-1/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/hsi/.install