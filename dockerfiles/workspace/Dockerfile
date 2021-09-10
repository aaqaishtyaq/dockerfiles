FROM ubuntu:21.04

ENV DEBIAN_FRONTEND="noninteractive"
RUN : \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y \
        build-essential \
        cmake \
        git \
        libjson-c-dev \
        libwebsockets-dev \
        sudo \
        vim \
        tmux \
        zsh \
        # for column
        bsdmainutils \
    && git clone https://github.com/tsl0922/ttyd.git \
    && cd ttyd \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && cd \
    && echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && useradd -u 1000 -G users,sudo,root -d /home/user --shell /bin/zsh -m user \
    && usermod -p "*" user \
    && :
USER user
COPY . /usr/local/bin/
RUN : \
    && git clone https://github.com/aaqaishtyaq/dotfiles "/home/user/.dotfiles" \
    && cd "/home/user/.dotfiles" \
    && echo "NEW_PROMPT=true" >> "config/zsh.d/local.zsh" \
    && make zsh tmux nvim dircolors \
    && bash "scripts/install-zsh.sh" \
    && :

RUN sudo chown -R user /usr/local/bin/
WORKDIR /workspace
ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["/usr/local/bin/exec_ttyd"]
