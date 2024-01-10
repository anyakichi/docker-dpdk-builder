Run a container from base image.

```
$ id=\$(sudo docker run --platform $(case "${CROSS_ARCH:-$(uname -m)}" in aarch64) echo arm64;; x86_64) echo amd64;; esac) -d ${CROSS_IMAGE} tail -f /dev/null)
```
