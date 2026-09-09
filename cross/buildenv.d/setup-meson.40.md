{% if "${CROSS_IMAGE}" && -z "$(meson-machine-file)" -%}

The sysroot is not there, or pkg-config cannot be run in it, or
CROSS_ARCH is not one of x86_64 and aarch64, and the build is not
configured without them; the message above says which.  This document
is sourced by setup and included by build and install, hence the
return where there is a caller to return to, and the exit where there
is none, since a return fails there and would end the script with a
message and a status of its own.

```
$ echo "buildenv: the build cannot be configured; see above" >&2
$ return 1 2>/dev/null || exit 1
```

{%- elif "${CROSS_IMAGE}" -%}

Write the cross file of meson, which tells it the compiler, the
architecture and the sysroot, and points pkg-config into the sysroot
as well, so that the libraries found are the ones the binaries run
against.

```
$ cat > meson-cross.txt <<EOF
$(meson-machine-file | sed -e 's/^/> /' -e 's/^> $/>/')
> EOF
```

Configure the build in the dpdk directory with meson.

```
$ cd dpdk
$ meson setup --cross-file ../meson-cross.txt ${DPDK_MESON_OPTS} build
```

{%- else -%}

Write the native file of meson, which picks the compiler the cross
build uses.

```
$ cat > meson-native.txt <<EOF
$(meson-machine-file | sed -e 's/^/> /' -e 's/^> $/>/')
> EOF
```

Configure the build in the dpdk directory with meson.  The platform is
set to generic where the release has that option, so that the binaries
run on any machine of the architecture and not only on the one they
are built on.

```
$ cd dpdk
{% if "$(cd dpdk 2>/dev/null && meson configure 2>/dev/null | grep -q '^  platform ' && echo yes)" -%}
$ meson setup --native-file ../meson-native.txt -Dplatform=generic ${DPDK_MESON_OPTS} build
{%- else -%}
$ meson setup --native-file ../meson-native.txt ${DPDK_MESON_OPTS} build
{%- endif %}
```

{%- endif %}
