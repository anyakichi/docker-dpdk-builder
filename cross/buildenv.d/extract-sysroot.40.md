If no image is specified, skip extract target rootfs.

```
$ [[ -n "${CROSS_IMAGE}" ]] || exit 0
```

Run a container from base image.

```
$ case "${CROSS_ARCH:-$(uname -m)}" in \
    aarch64) platform=arm64;; \
    x86_64) platform=amd64;; \
  esac
$ id=\$(sudo docker run --platform \$platform -d ${CROSS_IMAGE} tail -f /dev/null)
```

If the image is Debian based, install dependencies by apt-get.

```
$ if [[ ${CROSS_IMAGE} == debian* || ${CROSS_IMAGE} == ubuntu* ]]; then \
    sudo docker exec -it \$id apt-get update; \
    sudo docker exec -it \$id apt-get upgrade -y; \
    sudo docker exec -it -e DEBIAN_FRONTEND=noninteractive \$id \
      apt-get install -y \
        gcc \
        libarchive-dev \
        libbpf-dev \
        libbsd-dev \
        libcap-dev \
        libelf-dev \
        libfdt-dev \
        libibverbs-dev \
        libisal-dev \
        libjansson-dev \
        libmnl-dev \
        libnuma-dev \
        libpcap-dev \
        libssl-dev \
    ; \
    if [[ "${CROSS_ARCH:-$(uname -m)}" == x86_64 ]]; then \
      sudo docker exec -it -e DEBIAN_FRONTEND=noninteractive \$id \
        apt-get install -y libipsec-mb-dev;\
    fi \
  fi
```

If the image is Fedora based, install dependencies by dnf.

```
$ if [[ ${CROSS_IMAGE} == almalinux* || ${CROSS_IMAGE} == fedora* || ${CROSS_IMAGE} == rockylinux* ]]; then \
    sudo docker exec -it \$id dnf update -y; \
    sudo docker exec -it \$id dnf install -y --skip-broken \
      gcc \
      intel-ipsec-mb-devel \
      jansson-devel \
      libarchive-devel \
      libbsd-devel \
      libfdt-devel \
      libibverbs \
      libpcap-devel \
      libxdp-devel \
      numactl-devel \
      openssl-devel \
      zlib-devel \
    ; \
  fi
```

If the image is Arch Linux based, install dependencies by pacman.

```
$ if [[ ${CROSS_IMAGE} == archlinux* ]]; then \
    sudo docker exec -it \$id pacman -Syu; \
    sudo docker exec -it \$id pacman -S \
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
    ; \
  fi
```

Stop the container.

```
$ sudo docker stop \$id
```

Extract container image.

```
$ mkdir -p target
$ sudo docker export \$id | tar -xf - -C target
```

Remove the container.

```
$ sudo docker rm \$id
```

Change absolute symbolic links to relative ones.

```
$ sysroot-relativelinks target || sudo sysroot-relativelinks target
```
