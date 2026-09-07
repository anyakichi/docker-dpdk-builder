{% if "${CROSS_IMAGE}" -%}

{% if "${CROSS_CONTAINER:-}" -%}

Start the container ${CROSS_CONTAINER}, which is kept between the runs
so that the packages are installed once.  Run it from ${CROSS_IMAGE}
when there is no such container yet.

```
$ id=${CROSS_CONTAINER}
$ if podman inspect \$id &>/dev/null; then
>     podman start \$id
> else
>     podman run ${PODMAN_RUN_OPTS} --name \$id --platform $(platform) -d ${CROSS_IMAGE} tail -f /dev/null
> fi
```

{%- else -%}

Run a temporary container from ${CROSS_IMAGE}.

```
$ id=\$(podman run ${PODMAN_RUN_OPTS} --platform $(platform) -d ${CROSS_IMAGE} tail -f /dev/null)
```

{%- endif %}

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

{% if -z "${CROSS_CONTAINER:-}" -%}

Remove the temporary container.

```
$ podman rm \$id
```

{% endif -%}

Change absolute symbolic links to relative ones.

```
$ sysroot-relativelinks sysroot || sudo sysroot-relativelinks sysroot
```

{%- else -%}

CROSS_IMAGE is not set, hence the build is native and there is no
sysroot to extract.

{%- endif %}
