```bash
curl http://host.docker.internal:5500/main.sh | bash
```

```bash
docker run -it --rm alpine sh -c "apk update && apk add bash curl jq && bash"
```