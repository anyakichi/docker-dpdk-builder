Enable the CRB (EL9) or PowerTools (EL8) repository where there is
one, since some of the packages below are in it.

```
$ for i in crb powertools; do
>     if podman exec \$id dnf repolist --all | grep -q "^\$i "; then
>         podman exec \$id dnf install -y dnf-plugins-core
>         podman exec \$id dnf config-manager --set-enabled \$i
>     fi
> done
```

Install the packages DPDK builds against, and the ones CROSS_FEDORA_PKGS
names as well.

```
$ podman exec \$id dnf update -y
$ podman exec \$id dnf install -y --skip-broken \
>     bzip2-devel \
>     gcc \
>     intel-ipsec-mb-devel \
>     jansson-devel \
>     libacl-devel \
>     libarchive-devel \
>     libbpf-devel \
>     libbsd-devel \
>     libfdt-devel \
>     libpcap-devel \
>     libxdp-devel \
>     libxml2-devel \
>     libzstd-devel \
>     lz4-devel \
>     numactl-devel \
>     openssl-devel \
>     rdma-core-devel \
>     xz-devel \
>     zlib-devel
{% if "${CROSS_FEDORA_PKGS}" %}
$ podman exec \$id dnf install -y --skip-broken ${CROSS_FEDORA_PKGS}
{% endif %}
```

Install the packages that not every release has, each of them where
it is.

```
$ for i in ${CROSS_FEDORA_OPTIONAL_PKGS}; do
>     if podman exec \$id dnf info \$i >/dev/null 2>&1; then
>         podman exec \$id dnf install -y \$i
>     fi
> done
```
