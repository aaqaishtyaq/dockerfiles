#/usr/bin/env sh
set -e

AUTH_KEY="${AUTH_KEY:-}"

echo "Starting tailscaled"
tailscaled &
PID=$!

echo "Running tailscaled tailscale up"
tailscale up --authkey="${AUTH_KEY}"

wait ${PID}
