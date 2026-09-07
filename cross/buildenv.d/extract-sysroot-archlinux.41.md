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
$ for i in ${CROSS_ARCHLINUX_OPTIONAL_PKGS}; do \
    podman exec \$id \
      sh -c "pacman -Si \$i >/dev/null 2>&1 && pacman --noconfirm --needed -S \$i"; \
  done; \
  true
```
