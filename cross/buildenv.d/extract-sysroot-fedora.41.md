Install required packages.

```
$ sudo docker exec -it \$id dnf update -y
$ sudo docker exec -it \$id dnf install -y --skip-broken \
      bzip2-devel \
      gcc \
      intel-ipsec-mb-devel \
      jansson-devel \
      libacl-devel \
      libarchive-devel \
      libbpf-devel \
      libbsd-devel \
      libfdt-devel \
      libibverbs \
      libpcap-devel \
      libxdp-devel \
      libxml2-devel \
      libzstd-devel \
      lz4-devel \
      numactl-devel \
      openssl-devel \
      xz-devel \
      zlib-devel \
      ${CROSS_FEDORA_PKGS}
```
