Run a container from base image.

```
$ $(
  if [[ -z "${CROSS_CONTAINER:-}" ]]; then
    echo "id=\$(sudo docker run --platform $(platform) -d ${CROSS_IMAGE} tail -f /dev/null)"
  else
    echo id="$CROSS_CONTAINER"
    if sudo docker inspect "$CROSS_CONTAINER" &>/dev/null; then
      echo "\$ sudo docker start \$id"
    else
      echo "\$ sudo docker run --name \$id --platform $(platform) -d ${CROSS_IMAGE} tail -f /dev/null"
    fi
  fi
)
```
