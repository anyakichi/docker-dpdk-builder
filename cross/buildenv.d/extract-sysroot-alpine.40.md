Install the packages DPDK builds against, and the ones CROSS_ALPINE_PKGS
names as well.

```
$ podman exec \$id apk update
$ podman exec \$id apk add --no-cache \
>     acl-dev \
>     bsd-compat-headers \
>     bzip2-dev \
>     dtc-dev \
>     expat-dev \
>     gcc \
>     isa-l-dev \
>     jansson-dev \
>     libarchive-dev \
>     libatomic \
>     libbsd-dev \
>     libc-dev \
>     libpcap-dev \
>     libxdp-dev \
>     linux-headers \
>     lz4-dev \
>     musl-dev \
>     numactl-dev \
>     openssl-dev \
>     rdma-core-dev \
>     zlib-dev
{% if "${CROSS_ALPINE_PKGS}" %}
$ podman exec \$id apk add --no-cache ${CROSS_ALPINE_PKGS}
{% endif %}
```

Install the packages that not every release has, each of them where
it is.

```
$ for i in ${CROSS_ALPINE_OPTIONAL_PKGS}; do
>     if podman exec \$id apk search -e \$i | grep -q .; then
>         podman exec \$id apk add --no-cache \$i
>     fi
> done
```
