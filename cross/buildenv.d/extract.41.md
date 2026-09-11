{% include extract-sysroot %}
{% if "$(distro)" == alpine %}

Patch DPDK for alpine, whose musl has no pread64 and pwrite64.  DPDK
before v24.07 calls them in the vfio driver of the PCI bus; a later one
does not, and the sed changes nothing there.

```
$ sed -i -E 's/p(read|write)64/p\1/' dpdk/drivers/bus/pci/linux/pci_vfio.c
```
{% endif %}
