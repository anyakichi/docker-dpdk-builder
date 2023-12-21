Check the current directory.

```
$ [[ -e meson.build ]] && return 0
```

Execute meson in dpdk directory.

```
$ cd dpdk
$ meson build
```
