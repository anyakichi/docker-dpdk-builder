Install required packages.

```
$ sudo docker exec \$id apt-get update
$ sudo docker exec \$id apt-get upgrade -y
$ sudo docker exec -e DEBIAN_FRONTEND=noninteractive \$id \
    apt-get install -y \
      gcc \
      libacl1-dev \
      libarchive-dev \
      libbpf-dev \
      libbsd-dev \
      libbz2-dev \
      libcap-dev \
      libelf-dev \
      libfdt-dev \
      libibverbs-dev \
      libisal-dev \
      libjansson-dev \
      liblz4-dev \
      liblzma-dev \
      libmnl-dev \
      libnuma-dev \
      libpcap-dev \
      libssl-dev \
      libsystemd-dev \
      libxml2-dev \
      libzstd-dev \
      nettle-dev \
      pkgconf \
      ${CROSS_DEBIAN_PKGS}
$ for i in libipsec-mb-dev libxdp-dev; do \
    sudo docker exec -e DEBIAN_FRONTEND=noninteractive \$id \
      bash -c "apt-cache show \$i &>/dev/null && apt-get install -y \$i"; \
  done; \
  true
```
