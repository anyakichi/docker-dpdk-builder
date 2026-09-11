{% if "${CROSS_IMAGE}" && -z "$(platform)" -%}

CROSS_ARCH is not one of x86_64 and aarch64, as the message above
says, and there is no container to run for it.

```
$ exit 1
```

{%- elif "${CROSS_IMAGE}" -%}

Run a temporary container from ${CROSS_IMAGE}.

```
$ id=\$(podman run ${PODMAN_RUN_OPTS} --platform $(platform) -d ${CROSS_IMAGE} tail -f /dev/null)
```

{% include extract-sysroot-$(distro) %}

Write down the directories pkg-config searches, in the root of the
container so that it comes out with the rootfs, and setup points the
pkg-config of the build at the same ones in the sysroot.

```
$ podman exec \$id sh -c 'pkg-config --variable pc_path pkg-config > /.pc_path'
```

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
