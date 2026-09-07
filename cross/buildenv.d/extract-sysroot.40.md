{% if "${CROSS_IMAGE}" -%}

Run a temporary container from ${CROSS_IMAGE}.

```
$ id=\$(podman run ${PODMAN_RUN_OPTS} --platform $(platform) -d ${CROSS_IMAGE} tail -f /dev/null)
```

{% include extract-sysroot-$(distro) %}

Stop the container.

```
$ podman stop \$id
```

Extract the rootfs of the container into sysroot.

```
$ mkdir -p sysroot
$ podman export \$id | tar -xf - -C sysroot
```

Remove the temporary container.

```
$ podman rm \$id
```

Change absolute symbolic links to relative ones.

```
$ sysroot-relativelinks sysroot || sudo sysroot-relativelinks sysroot
```

{%- else -%}

CROSS_IMAGE is not set, hence the build is native and there is no
sysroot to extract.

{%- endif %}
