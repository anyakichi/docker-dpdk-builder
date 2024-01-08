ARG base
FROM ${base}

RUN \
    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        clang \
        docker.io \
        lld \
        llvm \
    && rm -rf /var/lib/apt/lists/*

COPY buildenv.d/ /etc/buildenv.d/
COPY assets/ /assets/
ADD https://raw.githubusercontent.com/yoctoproject/poky/4675bbb757a4755e80914afb6840a640f292fc08/scripts/sysroot-relativelinks.py \
    /usr/local/bin/sysroot-relativelinks
RUN chmod 755 /usr/local/bin/sysroot-relativelinks

ARG cross_arch=""
ARG cross_image=""
ENV \
    CROSS_ARCH=${cross_arch} \
    CROSS_IMAGE=${cross_image}
