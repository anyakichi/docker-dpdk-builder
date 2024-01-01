Check the current directory.

```
$ [[ -e meson.build ]] && return 0
```

Execute meson in dpdk directory.

```
$ cd dpdk
$ if meson configure | grep '^  platform ' &>/dev/null; then \
    DPDK_PLATFORM_OPTS="-Dplatform=generic"; \
  fi
$ meson setup \${DPDK_PLATFORM_OPTS} ${DPDK_MESON_OPTS} build
```
