Install required packages.

```
$ sudo docker exec -it \$id dnf update -y
$ sudo docker exec -it \$id dnf install -y --skip-broken \
      bzip2-static \
      gcc \
      intel-ipsec-mb-devel \
      jansson-devel \
      libacl-devel \
      libarchive-devel \
      libbpf-static \
      libbsd-devel \
      libfdt-static \
      libibverbs \
      libpcap-devel \
      libxdp-static \
      libxml2-static \
      libzstd-static \
      lz4-static \
      numactl-devel \
      openssl-devel \
      xz-static \
      zlib-static \
      ${CROSS_FEDORA_PKGS}
```
