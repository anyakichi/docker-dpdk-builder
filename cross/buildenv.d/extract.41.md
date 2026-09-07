{% include extract-sysroot %}
{% if "$(distro)" == alpine %}

Patch DPDK for alpine, whose musl has no pread64 and pwrite64.

```
$ sed -i -E 's/p(read|write)64/p\1/' dpdk/drivers/bus/pci/linux/pci_vfio.c
```
{% endif %}
