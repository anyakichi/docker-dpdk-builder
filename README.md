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

build and install take the steps of setup themselves when they are run
in the mounted directory, which is where a shell that has not been set
up is; setup leaves the shell in the dpdk directory.

The manuals of extract and build, joined with a blank line, are the
whole procedure from an empty directory to the built DPDK, and can be
printed before anything is done.

```
builder@dpdk:/build$ { extract -m; echo; build -m; } > BUILD.md
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

DPDK builds for the machine it is built on unless told otherwise.  Set
the platform to generic for binaries that run on any machine of the
architecture (the option came with v21.05).

```
$ din -e DPDK_MESON_OPTS=-Dplatform=generic ghcr.io/anyakichi/dpdk-builder:main
```

You can build DPDK in another environment by changing Docker image.

- Debian (Latest stable): ghcr.io/anyakichi/dpdk-builder:main-debian
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

Cross-build the latest DPDK for Ubuntu 22.04 ARM64 in the default
environment (debian:latest).

```
$ din --privileged \
    -e CROSS_IMAGE=ubuntu:jammy -e CROSS_ARCH=aarch64 \
    ghcr.io/anyakichi/dpdk-builder:main-cross
```

You can use individual parameters instead of `--privileged` (but
required parameters depend on your environment).

```
$ din --cap-add SYS_ADMIN --security-opt systempaths=unconfined --device /dev/fuse \
    -e CROSS_IMAGE=ubuntu:jammy -e CROSS_ARCH=aarch64 \
    ghcr.io/anyakichi/dpdk-builder:main-cross
```

`CROSS_IMAGE` must be a debian, ubuntu, fedora, almalinux, rockylinux,
alpine or archlinux image.  If not specified, the container will run
with self-compile mode.

`CROSS_ARCH` must be either x86_64 or aarch64.  If not specified, the
architecture of the container will be used.

A cross build is not for the machine it is built on, so what the
binaries are built for is named by a variable of the architecture, and
`-Dplatform=generic` does nothing here.  `CROSS_X86_64_MARCH` is the
-march of the compiler for x86_64, x86-64-v3 unless set, which is what
the processors of the last ten years or so have.  `CROSS_AARCH64_SOC`
is the SoC DPDK builds for on aarch64, one of the names in its
config/arm/meson.build, generic unless set.  Cross-build for Graviton3.

```
$ din --privileged \
    -e CROSS_IMAGE=ubuntu:noble -e CROSS_ARCH=aarch64 \
    -e CROSS_AARCH64_SOC=graviton3 \
    ghcr.io/anyakichi/dpdk-builder:main-cross
```

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

setup writes the cross file of meson to `meson-cross.txt` in the
mounted directory, next to the sysroot, so that the manual of `setup -m`
shows the file as it is written and a build of your own can use it too.
The file points pkg-config into the sysroot as well, at the directories
the pkg-config of the container searches, which extract writes down in
`sysroot/.pc_path`, and names the sysroot by `WORKDIR`, which is the
mounted directory in the container.  Without `CROSS_IMAGE` it is the
native file, `meson-native.txt`.

install installs DPDK into the sysroot instead of the container, so
that a program cross-built against the sysroot finds it there.
