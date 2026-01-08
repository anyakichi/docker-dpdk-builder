Install required packages.

```
$ podman exec \$id apk update
$ podman exec \$id apk add --no-cache \
    acl-dev \
    bsd-compat-headers \
    bzip2-dev \
    dtc-dev \
    expat-dev \
    gcc \
    isa-l-dev \
    jansson-dev \
    libarchive-dev \
    libatomic \
    libbsd-dev \
    libc-dev \
    libpcap-dev \
    libxdp-dev \
    linux-headers \
    lz4-dev \
    musl-dev \
    numactl-dev \
    openssl-dev \
    rdma-core-dev \
    zlib-dev \
    ${CROSS_ALPINE_PKGS}
```
