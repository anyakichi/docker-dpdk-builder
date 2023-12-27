ARG ubuntu_version="latest"
FROM ubuntu:${ubuntu_version}

# https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html
RUN \
    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        libnuma-dev \
        meson \
        ninja-build \
        pkgconf \
        python3-pyelftools \
    # Addtional libraries
        libbpf-dev \
        libbsd-dev \
        libcap2-dev \
        libelf-dev \
        libfdt-dev \
        libibverbs-dev \
        libipsec-mb-dev \
        libisal-dev \
        libjansson-dev \
        libmnl-dev \
        libpcap-dev \
        libssl-dev \
    # Tools for buildenv
        git \
        sudo \
    && rm -rf /var/lib/apt/lists/*

RUN \
    useradd -ms /bin/bash builder \
    && echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER builder
RUN \
    echo '. <(buildenv init)' >> ~/.bashrc \
    && git config --global user.email "builder@dpdk-builder" \
    && git config --global user.name "DPDK Builder"

USER root
WORKDIR /home/builder

COPY buildenv/entrypoint.sh /buildenv-entrypoint.sh
COPY buildenv/buildenv.sh /usr/local/bin/buildenv

COPY buildenv/buildenv.conf /etc/
COPY buildenv.d/ /etc/buildenv.d/

RUN sed -i 's/^#DOTCMDS=.*/DOTCMDS=setup/' /etc/buildenv.conf

ENTRYPOINT ["/buildenv-entrypoint.sh"]
CMD ["/bin/bash"]

ARG dpdk_git_url
ARG dpdk_rev
ENV \
    DPDK_GIT_URL=${dpdk_git_url} \
    DPDK_MESON_OPTS= \
    DPDK_REV=${dpdk_rev}
