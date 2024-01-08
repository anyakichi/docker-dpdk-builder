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

You can use environment variables to change DPDK revision.  Build v22.11
of DPDK.

```
$ din -e DPDK_REV=v22.11 ghcr.io/anyakichi/dpdk-builder:main
```

Build v22.11 of DPDK in the stable repository.

```
$ din -e DPDK_REV=v22.11 DPDK_GIT_URL=https://dpdk.org/git/dpdk-stable ghcr.io/anyakichi/dpdk-builder:main
```

You can build DPDK in another environment by changing Docker image.

- Debian (Latest LTS): ghcr.io/anyakichi/dpdk-builder:main-debian
- Debian 12: ghcr.io/anyakichi/dpdk-builder:main-bookworm
- Ubuntu (Latest LTS): ghcr.io/anyakichi/dpdk-builder:main-ubuntu
- Ubuntu 22.04: ghcr.io/anyakichi/dpdk-builder:main-jammy
- Ubuntu 20.04: ghcr.io/anyakichi/dpdk-builder:main-focal

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
$ din -v /var/run/docker.sock:/var/run/docker.sock \
    -e CROSS_IMAGE=ubuntu:focal -e CROSS_ARCH=aarch64 \
    ghcr.io/anyakichi/dpdk-builder:main-cross
```

`CROSS_IMAGE` must be a debian, ubuntu, fedora, almalinux, rockylinux,
or archlinux image.  If not specified, the container will run with
self-compile mode.

`CROSS_ARCH` must be either x86_64 or aarch64.  If not specified, the
architecture of the container will be used.
