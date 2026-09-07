Install the packages DPDK builds against, and the ones CROSS_DEBIAN_PKGS
names as well.

```
$ podman exec \$id apt-get update
$ podman exec \$id apt-get upgrade -y
$ podman exec -e DEBIAN_FRONTEND=noninteractive \$id apt-get install -y \
>     gcc \
>     libacl1-dev \
>     libarchive-dev \
>     libbpf-dev \
>     libbsd-dev \
>     libbz2-dev \
>     libcap-dev \
>     libelf-dev \
>     libfdt-dev \
>     libibverbs-dev \
>     libisal-dev \
>     libjansson-dev \
>     liblz4-dev \
>     liblzma-dev \
>     libmnl-dev \
>     libnuma-dev \
>     libpcap-dev \
>     libssl-dev \
>     libsystemd-dev \
>     libxml2-dev \
>     libzstd-dev \
>     nettle-dev \
>     pkgconf
{% if "${CROSS_DEBIAN_PKGS}" %}
$ podman exec -e DEBIAN_FRONTEND=noninteractive \$id apt-get install -y ${CROSS_DEBIAN_PKGS}
{% endif %}
```

Install the packages that not every release has, each of them where
it is.

```
$ for i in libipsec-mb-dev libjitterentropy3-dev libxdp-dev ${CROSS_DEBIAN_OPTIONAL_PKGS}; do
>     if podman exec \$id apt-cache show \$i &>/dev/null; then
>         podman exec -e DEBIAN_FRONTEND=noninteractive \$id apt-get install -y \$i
>     fi
> done
```
