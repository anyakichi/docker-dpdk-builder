# docker-dpdk-builder

[docker-buildenv](https://github.com/anyakichi/docker-buildenv) for DPDK.

## How to use

Build the latest DPDK in the default environment (debian:latest).

```
$ mkdir dpdk && cd $_
$ din ghcr.io/anyakichi/dpdk-builder:main
builder@dpdk:/build$ extract
builder@dpdk:/build$ setup
builder@dpdk:/build/dpdk$ build
```

install builds DPDK and installs it into the container, for a program
that is built against it there.

```
builder@dpdk:/build$ install
```

You can use environment variables to change DPDK revision.  Build v22.11
of DPDK.

```
$ din -e DPDK_REV=v22.11 ghcr.io/anyakichi/dpdk-builder:main
```

Build v22.11 of DPDK in the stable repository.

```
$ din -e DPDK_REV=v22.11 -e DPDK_GIT_URL=https://dpdk.org/git/dpdk-stable ghcr.io/anyakichi/dpdk-builder:main
```

The options of meson setup are taken from DPDK_MESON_OPTS.  Build the
examples as well.

```
$ din -e DPDK_MESON_OPTS=-Dexamples=all ghcr.io/anyakichi/dpdk-builder:main
```

You can build DPDK in another environment by changing Docker image.

- Debian (Latest LTS): ghcr.io/anyakichi/dpdk-builder:main-debian
- Debian 13: ghcr.io/anyakichi/dpdk-builder:main-trixie
- Debian 12: ghcr.io/anyakichi/dpdk-builder:main-bookworm
- Ubuntu (Latest LTS): ghcr.io/anyakichi/dpdk-builder:main-ubuntu
- Ubuntu 26.04: ghcr.io/anyakichi/dpdk-builder:main-resolute
- Ubuntu 24.04: ghcr.io/anyakichi/dpdk-builder:main-noble
- Ubuntu 22.04: ghcr.io/anyakichi/dpdk-builder:main-jammy

## Cross-native build

ARM64 binary can be built in an ARM64 container with qemu-user-static.
Ensure qemu-user-static and binfmt are set up correctly.  For example,
if you use Debian/Ubuntu, install binfmt-support and qemu-user-static:

```
$ sudo apt install binfmt-support qemu-user-static
```

You can run an ARM64 container with `--platform` option.

```
$ din --platform arm64 ghcr.io/anyakichi/dpdk-builder:main
```

## Cross build

dpdk-builder also supports cross-building for different architectures
and distributions.

Cross-build the latest DPDK for Ubuntu 20.04 ARM64 in the default
environment (debian:latest).

```
$ din --privileged \
    -e CROSS_IMAGE=ubuntu:focal -e CROSS_ARCH=aarch64 \
    ghcr.io/anyakichi/dpdk-builder:main-cross
```

You can use individual parameters instead of `--privileged` (but
required parameters depend on your environment).

```
$ din --cap-add SYS_ADMIN --security-opt systempaths=unconfined --device /dev/fuse \
    -e CROSS_IMAGE=ubuntu:focal -e CROSS_ARCH=aarch64 \
    ghcr.io/anyakichi/dpdk-builder:main-cross
```

`CROSS_IMAGE` must be a debian, ubuntu, fedora, almalinux, rockylinux,
alpine or archlinux image.  If not specified, the container will run
with self-compile mode.

`CROSS_ARCH` must be either x86_64 or aarch64.  If not specified, the
architecture of the container will be used.

The container of `CROSS_IMAGE` is run with podman inside the builder
container, which is what `--privileged` or the parameters above are
for.  A container of another architecture runs with qemu-user-static,
so the host needs the set-up of the [Cross-native
build](#cross-native-build) section as well.

The sysroot gets the packages DPDK builds against.  More can be named
in `CROSS_DEBIAN_PKGS`, `CROSS_FEDORA_PKGS`, `CROSS_ALPINE_PKGS` or
`CROSS_ARCHLINUX_PKGS`, whichever is the distribution of `CROSS_IMAGE`
(almalinux and rockylinux count as fedora, ubuntu as debian), and in
`CROSS_DEBIAN_OPTIONAL_PKGS` and the like for a package that not every
release has, which is installed where it is.

```
$ din --privileged \
    -e CROSS_IMAGE=ubuntu:noble -e CROSS_ARCH=aarch64 \
    -e CROSS_DEBIAN_PKGS=libpcre2-dev \
    ghcr.io/anyakichi/dpdk-builder:main-cross
```

`PODMAN_RUN_OPTS` holds the options of the podman run of that
container; it is `--network host` unless set.

install installs DPDK into the sysroot instead of the container, so
that a program cross-built against the sysroot finds it there.
