Stop the container.

```
$ podman stop \$id
```

Extract container image.

```
$ mkdir -p sysroot
$ podman export \$id | tar -xf - -C sysroot
```

Remove the temporary container.

```
$ $([[ -z "${CROSS_CONTAINER:-}" ]] && echo podman rm \$id)
```

Change absolute symbolic links to relative ones.

```
$ sysroot-relativelinks sysroot || sudo sysroot-relativelinks sysroot
```
