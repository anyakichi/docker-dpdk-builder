Configure the build in the dpdk directory with meson.  DPDK builds for
the machine it is built on unless told otherwise; -Dplatform=generic
makes binaries that run on any machine of the architecture.

```
$ cd dpdk
$ meson setup${DPDK_MESON_OPTS:+ ${DPDK_MESON_OPTS}} build
```
