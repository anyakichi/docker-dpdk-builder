Run a container from base image.

```
$ $(
  if [[ -z "${CROSS_CONTAINER:-}" ]]; then
    echo "id=\$(podman run --network host --platform $(platform) -d ${CROSS_IMAGE} tail -f /dev/null)"
  else
    echo id="$CROSS_CONTAINER"
    if podman inspect "$CROSS_CONTAINER" &>/dev/null; then
      echo "\$ podman start \$id"
    else
      echo "\$ podman run --name \$id --network host --platform $(platform) -d ${CROSS_IMAGE} tail -f /dev/null"
    fi
  fi
)
```
