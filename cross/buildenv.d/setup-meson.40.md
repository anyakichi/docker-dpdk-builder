Configure the build in the dpdk directory with meson.  The cross files
of /assets/meson tell it the compiler, the architecture and the
sysroot, and the environment of pkg-config is pointed into the sysroot
too, so that the libraries found are the ones the binaries run
against.

```
$ cd dpdk
$ $(meson-cross-env) meson setup $(meson-cross-opts) ${DPDK_MESON_OPTS} build
```
