Extract rootfs from ${CROSS_IMAGE}.

```
$([[ -n "\${CROSS_IMAGE}" ]] && buildenv extract-sysroot-$(image2distro "${CROSS_IMAGE}") -d)
```
