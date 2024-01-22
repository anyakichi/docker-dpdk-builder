Stop the container.

```
$ sudo docker stop \$id
```

Extract container image.

```
$ mkdir -p sysroot
$ sudo docker export \$id | tar -xf - -C sysroot
```

Remove the temporary container.

```
$ $([[ -z "${CROSS_CONTAINER:-}" ]] && echo sudo docker rm \$id)
```

Change absolute symbolic links to relative ones.

```
$ sysroot-relativelinks sysroot || sudo sysroot-relativelinks sysroot
```
