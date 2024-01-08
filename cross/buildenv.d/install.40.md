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
$ if [[ -n "${CROSS_IMAGE}" ]]; then \
    meson install -C build --destdir /build/target; \
  else \
    sudo meson install -C build; \
  fi
```
