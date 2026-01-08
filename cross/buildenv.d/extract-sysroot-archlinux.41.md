Install required packages.

```
$ podman exec \$id pacman --noconfirm -Syu
$ podman exec \$id pacman --noconfirm --needed -S \
    dtc \
    gcc \
    jansson \
    libarchive \
    libbpf \
    libbsd \
    libcap \
    libelf \
    libmnl \
    libpcap \
    libxdp \
    numactl \
    openssl \
    rdma-core \
    ${CROSS_ARCHLINUX_PKGS}
```
