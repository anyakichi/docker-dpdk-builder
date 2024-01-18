Extract sysroot from ${CROSS_IMAGE}.

$(buildenv extract-sysroot -d)

Patch to DPDK for alpine.

```
$ $([[ ${CROSS_IMAGE} == alpine* ]] && echo "sed -i -E 's/p(read|write)64/p\\1/' dpdk/drivers/bus/pci/linux/pci_vfio.c")
```
