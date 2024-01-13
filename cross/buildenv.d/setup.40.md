Check the current directory.

```
$ [[ \$WORKDIR == \$PWD ]] || return 0
```

Execute meson in dpdk directory.

```
$ cd dpdk
$ $(meson-cross-env) meson setup $(meson-cross-opts) ${DPDK_MESON_OPTS} build
```
