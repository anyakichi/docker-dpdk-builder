If no image is specified, skip extract target rootfs.

```
$ [[ -n "\${CROSS_IMAGE}" ]] || exit 0
```

Extract rootfs from ${CROSS_IMAGE}.

```
$ buildenv extract-sysroot-$(image2distro "${CROSS_IMAGE}") -y
```
