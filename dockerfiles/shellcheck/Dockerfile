FROM ghcr.io/aaqaishtyaq/base-debian:1c32996

RUN apt-get update && apt-get install -y \
    file \
    shellcheck \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

CMD ["shellcheck"]
