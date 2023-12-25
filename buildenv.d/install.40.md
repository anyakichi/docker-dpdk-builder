Setup build environment before building.

```
$ . <(buildenv setup)
```

Build DPDK.

```
$ buildenv build -y
```

Install DPDK.

```
$ sudo meson install -C build
```
