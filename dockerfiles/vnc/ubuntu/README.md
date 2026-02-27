# Ubuntu 24.04 XFCE + VNC/noVNC

Headless Ubuntu 24.04 desktop container with:

- TigerVNC (`tigervnc-standalone-server`)
- noVNC (`novnc` + `websockify` from Ubuntu packages)
- XFCE desktop

## Build

```bash
docker build -t vnc-ubuntu:24.04 .
```

## Run

```bash
docker run --rm -it \
  -e VNC_PASSWORD='change-me' \
  -p 5901:5901 \
  -p 6080:6080 \
  vnc-ubuntu:24.04
```

## Access

- VNC: `localhost:5901`
- noVNC: `http://localhost:6080/vnc.html`

## Optional environment variables

- `DISPLAY` (default: `:1`)
- `VNC_GEOMETRY` (default: `1360x768`)
- `VNC_DEPTH` (default: `24`)
- `NOVNC_PORT` (default: `6080`)
- `VNC_LOCALHOST` (default: `no`)
