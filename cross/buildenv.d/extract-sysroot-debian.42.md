Stop the container.

```
$ sudo docker stop \$id
```

Extract container image.

```
$ mkdir -p target
$ sudo docker export \$id | tar -xf - -C target
```

Remove the temporary container.

```
$ $([[ -z "${CROSS_CONTAINER:-}" ]] && echo sudo docker rm \$id)
```

Change absolute symbolic links to relative ones.

```
$ sysroot-relativelinks target || sudo sysroot-relativelinks target
```
