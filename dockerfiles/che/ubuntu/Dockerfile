FROM ubuntu:20.04
LABEL org.opencontainers.image.source https://github.com/aaqaishtyaq/dockerfiles

RUN apt update && \
    echo 'tzdata tzdata/Areas select Asia' | debconf-set-selections && \
    echo 'tzdata tzdata/Zones/Asia select Kolkata' | debconf-set-selections && \
    DEBIAN_FRONTEND="noninteractive" apt install -y tzdata  && \
    apt install -y \
    bash-completion \
    ca-certificates \
    curl \
    locales \
    mc \
    openssh-server \
    procps \
    rsync \
    software-properties-common \
    sudo \
    tmux \
    unzip \
    vim \
    wget && \
    mkdir /var/run/sshd && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,sudo,root -d /home/user --shell /bin/bash -m user && \
    usermod -p "*" user && \
    apt -y clean && \
    apt -y autoremove && \
    rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV TERM xterm-256color
USER user
WORKDIR /projects

ENV HOME /home/user
COPY ["entrypoint","/home/user/entrypoint"]

# The following instructions set the right
# permissions and scripts to allow the container
# to be run by an arbitrary user (i.e. a user
# that doesn't already exist in /etc/passwd)
RUN for f in "/home/user" "/etc/passwd" "/etc/group" "/projects"; do\
        sudo chgrp -R 0 ${f} && \
        sudo chmod -R g+rwX ${f}; \
    done && \
    # Generate passwd.template \
    cat /etc/passwd | \
    sed s#user:x.*#user:x:\${USER_ID}:\${GROUP_ID}::\${HOME}:/bin/bash#g \
    > /home/user/passwd.template && \
    # Generate group.template \
    cat /etc/group | \
    sed s#root:x:0:#root:x:0:0,\${USER_ID}:#g \
    > /home/user/group.template && \
    sudo sed -ri 's/StrictModes yes/StrictModes no/g' /etc/ssh/sshd_config

ENTRYPOINT ["/home/user/entrypoint"]
CMD tail -f /dev/null
