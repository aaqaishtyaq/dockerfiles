FROM jupyter/datascience-notebook

ENV TERM xterm-256color
USER root

RUN : \
	&& usermod -aG sudo jovyan \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
	&& :

RUN : \
	&& apt-get update -y \
	&& apt-get install vim tmux -y \
	&& apt-get -y autoremove \
	&& apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& :

USER jovyan
