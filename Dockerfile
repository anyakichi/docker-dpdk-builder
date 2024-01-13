ARG base=debian
FROM ${base}

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
        libpcap-dev \
        libssl-dev \
        libsystemd-dev \
        libxml2-dev \
        libzstd-dev \
        nettle-dev \
    # Tools for buildenv
        ccache \
        git \
        sudo \
    && for i in libipsec-mb-dev libxdp-dev; do \
        if apt-cache show "$i" >/dev/null 2>&1; then \
            DEBIAN_FRONTEND=noninteractive apt-get install -y $i; \
        fi \
       done \
    ; rm -rf /var/lib/apt/lists/*

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
