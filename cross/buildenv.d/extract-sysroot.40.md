Extract rootfs from ${CROSS_IMAGE}.

$([[ -n "\${CROSS_IMAGE}" ]] && buildenv extract-sysroot-$(distro) -d)
