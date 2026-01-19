Run a container from base image.

```
$ $(
  if [[ -z "${CROSS_CONTAINER:-}" ]]; then
    echo "id=\$(podman run ${PODMAN_RUN_OPTS} --platform $(platform) -d ${CROSS_IMAGE} tail -f /dev/null)"
  else
    echo id="$CROSS_CONTAINER"
    if podman inspect "$CROSS_CONTAINER" &>/dev/null; then
      echo "\$ podman start \$id"
    else
      echo "\$ podman run ${PODMAN_RUN_OPTS} --name \$id --platform $(platform) -d ${CROSS_IMAGE} tail -f /dev/null"
    fi
  fi
)
```
