ARG base=ghcr.io/anyakichi/dpdk-builder:main
FROM ${base}

RUN \
    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        clang \
        podman \
        lld \
        llvm \
    && rm -rf /var/lib/apt/lists/*

COPY assets/ /assets/
COPY bin/ /usr/local/bin/
COPY buildenv.d/ /etc/buildenv.d/

ADD https://raw.githubusercontent.com/yoctoproject/poky/4675bbb757a4755e80914afb6840a640f292fc08/scripts/sysroot-relativelinks.py \
    /usr/local/bin/sysroot-relativelinks
RUN chmod 755 /usr/local/bin/sysroot-relativelinks

ARG cross_arch=""
ARG cross_image=""
ENV \
    CROSS_ARCH=${cross_arch} \
    CROSS_IMAGE=${cross_image} \
    CROSS_ALPINE_PKGS="" \
    CROSS_ARCHLINUX_PKGS="" \
    CROSS_DEBIAN_PKGS="" \
    CROSS_FEDORA_PKGS=""
