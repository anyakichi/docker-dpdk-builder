Install the packages DPDK builds against, and the ones CROSS_ARCHLINUX_PKGS
names as well.

```
$ podman exec \$id pacman --noconfirm -Syu
$ podman exec \$id pacman --noconfirm --needed -S \
>     dtc \
>     gcc \
>     jansson \
>     libarchive \
>     libbpf \
>     libbsd \
>     libcap \
>     libelf \
>     libmnl \
>     libpcap \
>     libxdp \
>     numactl \
>     openssl \
>     rdma-core
{% if "${CROSS_ARCHLINUX_PKGS}" %}
$ podman exec \$id pacman --noconfirm --needed -S ${CROSS_ARCHLINUX_PKGS}
{% endif %}
```

Install the packages that not every release has, each of them where
it is.

```
$ for i in ${CROSS_ARCHLINUX_OPTIONAL_PKGS}; do
>     if podman exec \$id pacman -Si \$i >/dev/null 2>&1; then
>         podman exec \$id pacman --noconfirm --needed -S \$i
>     fi
> done
```
