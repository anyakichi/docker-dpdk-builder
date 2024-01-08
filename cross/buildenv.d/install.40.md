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
$ meson install -C build --destdir /build/target
```
