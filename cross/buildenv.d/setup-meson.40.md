{% if "${CROSS_IMAGE}" && -z "$(meson-cross-env)" -%}

The sysroot is not there, or pkg-config cannot be run in it, and the
build is not configured without it; the message above says which.
This document is sourced, hence the return rather than an exit.

```
$ echo "buildenv: the sysroot in ${WORKDIR} is not usable; see above" >&2
$ return 1
```

{%- elif "${CROSS_IMAGE}" -%}

Configure the build in the dpdk directory with meson.  The cross files
of /assets/meson tell it the compiler, the architecture and the
sysroot, and the environment of pkg-config is pointed into the sysroot
too, so that the libraries found are the ones the binaries run
against.

```
$ cd dpdk
$ $(meson-cross-env) meson setup $(meson-cross-opts) ${DPDK_MESON_OPTS} build
```

{%- else -%}

Configure the build in the dpdk directory with meson.  The native file
of /assets/meson picks the compiler the cross build uses, and the
platform is set to generic where the release has that option, so that
the binaries run on any machine of the architecture and not only on
the one they are built on.

```
$ cd dpdk
{% if "$(cd dpdk 2>/dev/null && meson configure 2>/dev/null | grep -q '^  platform ' && echo yes)" -%}
$ meson setup $(meson-cross-opts) -Dplatform=generic ${DPDK_MESON_OPTS} build
{%- else -%}
$ meson setup $(meson-cross-opts) ${DPDK_MESON_OPTS} build
{%- endif %}
```

{%- endif %}
