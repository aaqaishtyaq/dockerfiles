# Tailscale

## Docker Compose

```yaml
version: '3'
services:
  cgit:
    privileged: true
    network_mode: "host"
    restart: unless-stopped
    container_name: tailscaled
    image: ghcr.io/aaqaishtyaq/tailscale:latest
    volumes:
      - /var/lib:/var/lib
      - /dev/net/tun:/dev/net/tun
      - /media/AppData/tailscale:/var/lib/tailscale
    environment:
      AUTH_KEY: ${TS_AUTH_KEY}
```

## Docker Compose Start

```console
TS_AUTH_KEY=tskey-XXXXX docker compose up -d
```
