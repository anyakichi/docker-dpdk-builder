Check the current directory.

```
$ [[ -e meson.build ]] && return 0
```

Execute meson in dpdk directory.

```
$ cd dpdk
$ meson setup ${DPDK_MESON_OPTS} $(meson-cross-opts "${CROSS_ARCH}" "${CROSS_IMAGE}") build
```
