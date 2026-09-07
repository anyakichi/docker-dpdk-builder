Enable CRB (EL9) or PowerTools (EL8) repository if available.

```
$ for i in crb powertools; do \
    podman exec \$id \
      sh -c "dnf repolist --all | grep -q '^\$i ' \
        && dnf install -y dnf-plugins-core \
        && dnf config-manager --set-enabled \$i"; \
  done; \
  true
```

Install required packages.

```
$ podman exec \$id dnf update -y
$ podman exec \$id dnf install -y --skip-broken \
      bzip2-devel \
      gcc \
      intel-ipsec-mb-devel \
      jansson-devel \
      libacl-devel \
      libarchive-devel \
      libbpf-devel \
      libbsd-devel \
      libfdt-devel \
      libpcap-devel \
      libxdp-devel \
      libxml2-devel \
      libzstd-devel \
      lz4-devel \
      numactl-devel \
      openssl-devel \
      rdma-core-devel \
      xz-devel \
      zlib-devel \
      ${CROSS_FEDORA_PKGS}
$ for i in ${CROSS_FEDORA_OPTIONAL_PKGS}; do \
    podman exec \$id \
      sh -c "dnf info \$i >/dev/null 2>&1 && dnf install -y \$i"; \
  done; \
  true
```
