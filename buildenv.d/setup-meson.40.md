Configure the build in the dpdk directory with meson.  The platform is
set to generic where the release has that option, so that the binaries
run on any machine of the architecture and not only on the one they
are built on.

```
$ cd dpdk
{% if "$(cd dpdk 2>/dev/null && meson configure 2>/dev/null | grep -q '^  platform ' && echo yes)" -%}
$ meson setup -Dplatform=generic ${DPDK_MESON_OPTS} build
{%- else -%}
$ meson setup ${DPDK_MESON_OPTS} build
{%- endif %}
```
