{% if "${CROSS_IMAGE}" && -z "$(meson-machine-file)" -%}

CROSS_ARCH is not one of x86_64 and aarch64, as the message above
says, and the build is not configured without it.  This document is
sourced by setup and included by build and install, hence the return
where there is a caller to return to, and the exit where there is
none, since a return fails there and would end the script with a
message and a status of its own.

```
$ echo "buildenv: the build cannot be configured; see above" >&2
$ return 1 2>/dev/null || exit 1
```

{%- elif "${CROSS_IMAGE}" -%}

Write the cross file of meson, which tells it the compiler, the
architecture and the sysroot.  WORKDIR is this directory, the one the
sysroot was extracted into.

```
$ cat > meson-cross.txt <<EOF
$(meson-machine-file | sed -e 's/^/> /' -e 's/^> $/>/')
> EOF
```

Point pkg-config into the sysroot as well, at the directories the
pkg-config of the container searches, which extract wrote down in
sysroot/.pc_path, so that the libraries found are the ones the
binaries run against.

```
$ sed "s|/\([^:]*\)|sysroot / '\1'|g; s|:|, |g; s|.*|pkg_config_libdir = [&]|" sysroot/.pc_path >> meson-cross.txt
```

Configure the build in the dpdk directory with meson.

```
$ cd dpdk
$ meson setup --cross-file ../meson-cross.txt${DPDK_MESON_OPTS:+ ${DPDK_MESON_OPTS}} build
```

{%- else -%}

Write the native file of meson, which picks the compiler the cross
build uses.

```
$ cat > meson-native.txt <<EOF
$(meson-machine-file | sed -e 's/^/> /' -e 's/^> $/>/')
> EOF
```

Configure the build in the dpdk directory with meson.  DPDK builds for
the machine it is built on unless told otherwise; -Dplatform=generic
makes binaries that run on any machine of the architecture.

```
$ cd dpdk
$ meson setup --native-file ../meson-native.txt${DPDK_MESON_OPTS:+ ${DPDK_MESON_OPTS}} build
```

{%- endif %}
