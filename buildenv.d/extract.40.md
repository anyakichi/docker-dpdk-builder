Clone the DPDK repository.

```
$ git clone ${DPDK_GIT_URL:-https://github.com/DPDK/dpdk} dpdk
{% if "${DPDK_REV:-}" %}
$ git -C dpdk checkout ${DPDK_REV}
{% endif %}
```
