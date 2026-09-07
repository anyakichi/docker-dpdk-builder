Setup build environment before building.

```
$ . <(buildenv setup)
```

Build DPDK.

```
$ buildenv build -y
```

{% if "${CROSS_IMAGE}" -%}

Install DPDK into the sysroot, so that a program built against it
finds DPDK there.

```
$ meson install -C build --destdir ${WORKDIR}/sysroot
```

{%- else -%}

Install DPDK.

```
$ sudo meson install -C build
```

{%- endif %}
