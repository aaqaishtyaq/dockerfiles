FROM ubuntu:24.04
LABEL maintainer="Aaqa Ishtyaq <aaqaishtyaq@gmail.com>"

ENV \
    DEBIAN_FRONTEND=noninteractive \
    DEBIAN_PRIORITY=high \
    DISPLAY=:1 \
    HOME=/home/user \
    NOVNC_PORT=6080 \
    STARTUP_DIR=/home/user/startup \
    VNC_DEPTH=24 \
    VNC_GEOMETRY=1360x768 \
    VNC_PORT=5901

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dbus-x11 \
        git \
        locales \
        net-tools \
        novnc \
        procps \
        python3-numpy \
        sudo \
        tigervnc-common \
        tigervnc-standalone-server \
        tigervnc-tools \
        websockify \
        wget \
        xfce4 \
        xfce4-goodies \
        xfce4-terminal \
        xauth \
    && ln -sf /usr/share/novnc/vnc.html /usr/share/novnc/index.html \
    && locale-gen en_US.UTF-8 \
    && if ! id -u user >/dev/null 2>&1; then useradd -m -s /bin/bash user; fi \
    && usermod -aG sudo user \
    && echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-user \
    && chmod 0440 /etc/sudoers.d/90-user \
    && mkdir -p /home/user/.vnc "${STARTUP_DIR}" \
    && chown -R user:user /home/user \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

COPY start_vnc.sh /usr/local/bin/start_vnc.sh
RUN chmod +x /usr/local/bin/start_vnc.sh

USER user
WORKDIR /home/user

EXPOSE 5901 6080
ENTRYPOINT ["/usr/local/bin/start_vnc.sh"]
