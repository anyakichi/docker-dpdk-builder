Check the current directory.

```
$ [[ -e meson.build ]] && return 0
```

Check distribution type.

```
$ case "${CROSS_IMAGE}" in \
    archlinux*) CROSS_DISTRO=archlinux;; \
    debian*|ubuntu*) CROSS_DISTRO=debian;; \
    almalinux*|fedora*|rockylinux*) CROSS_DISTRO=fedora;; \
    *) CROSS_DISTRO=;; \
  esac
```

Execute meson in dpdk directory.

```
$ cd dpdk
$ if [[ ! -e ../target ]]; then \
    meson setup ${DPDK_MESON_OPTS} --native-file /assets/meson/common.txt build; \
  elif [[ -z "${CROSS_ARCH}" || "${CROSS_ARCH}" == $(uname -m) ]]; then \
    meson setup ${DPDK_MESON_OPTS} \
        --native-file /assets/meson/common.txt \
        --native-file /assets/meson/sysroot.txt \
        --native-file /assets/meson/arch_$(uname -m).txt \
        --native-file /assets/meson/distro_\${CROSS_DISTRO}.txt \
        build; \
  else \
    meson setup ${DPDK_MESON_OPTS} \
        --cross-file /assets/meson/common.txt \
        --cross-file /assets/meson/sysroot.txt \
        --cross-file /assets/meson/arch_${CROSS_ARCH}.txt \
        --cross-file /assets/meson/distro_\${CROSS_DISTRO}.txt \
        build; \
  fi
```
