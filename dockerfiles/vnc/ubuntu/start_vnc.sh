#!/usr/bin/env bash

set -euo pipefail

# default to "headless" when nothing is provided, don't fail
VNC_PASSWORD="${VNC_PASSWORD:-headless}"

# ensure we have a password set for the VNC server
test -n "$VNC_PASSWORD" || {
    echo "VNC_PASSWORD is required. Example: -e VNC_PASSWORD='strongpass'" >&2
    exit 1
}

DISPLAY="${DISPLAY:-:1}"
NOVNC_PORT="${NOVNC_PORT:-6080}"
VNC_GEOMETRY="${VNC_GEOMETRY:-1360x768}"
VNC_DEPTH="${VNC_DEPTH:-24}"
VNC_LOCALHOST="${VNC_LOCALHOST:-no}"

DISPLAY_NUMBER="${DISPLAY#:}"
VNC_PORT="$((5900 + DISPLAY_NUMBER))"

mkdir -p "${HOME}/.vnc"
PASSWD_PATH="${HOME}/.vnc/passwd"
touch "${HOME}/.Xauthority"

# TigerVNC uses the first 8 characters for VNC auth.
printf '%s\n' "${VNC_PASSWORD}" | vncpasswd -f > "${PASSWD_PATH}"
chmod 600 "${PASSWD_PATH}"

cat > "${HOME}/.vnc/xstartup" <<'XEOF'
#!/usr/bin/env bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4
XEOF
chmod +x "${HOME}/.vnc/xstartup"

cleanup() {
    vncserver -kill "${DISPLAY}" >/dev/null 2>&1 || true
    if [ -n "${NOVNC_PID:-}" ]; then
        kill "${NOVNC_PID}" >/dev/null 2>&1 || true
    fi
}
trap cleanup EXIT INT TERM

vncserver -kill "${DISPLAY}" >/dev/null 2>&1 || true
rm -rf /tmp/.X*-lock /tmp/.X11-unix/X* >/dev/null 2>&1 || true

VNC_ARGS=("${DISPLAY}" -depth "${VNC_DEPTH}" -geometry "${VNC_GEOMETRY}")
if [ "${VNC_LOCALHOST}" = "yes" ]; then
    VNC_ARGS+=("-localhost")
else
    VNC_ARGS+=("-localhost" "no")
fi

vncserver "${VNC_ARGS[@]}"

/usr/share/novnc/utils/novnc_proxy \
    --vnc "localhost:${VNC_PORT}" \
    --listen "${NOVNC_PORT}" \
    --web /usr/share/novnc &
NOVNC_PID=$!

echo "VNC server: ${DISPLAY} (port ${VNC_PORT})"
echo "noVNC URL: http://0.0.0.0:${NOVNC_PORT}/"

if [ "$#" -gt 0 ]; then
    exec "$@"
fi

wait "${NOVNC_PID}"
