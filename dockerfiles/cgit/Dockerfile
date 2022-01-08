FROM nginx:alpine as builder

LABEL org.opencontainers.image.authors="Aaqa Ishtyaq <aaqaishtyaq@gmail.com>"
LABEL org.opencontainers.image.source https://github.com/aaqaishtyaq/dockerfiles

RUN : \
    && apk update \
    # Install dependencies
    && apk add \
        cgit \
        fcgiwrap \
        gettext \
        git \
        groff \
        highlight \
        python3 \
        py3-pip \
        spawn-fcgi \
    && pip install \
        pygments \
        markdown \
    # Setup git user
    && addgroup -S git \
    && adduser -S git -G git \
    # Save nginx logs
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && mkdir /repositories/ \
    && chown -R git:git /repositories/ \
    && :

COPY config/nginx.conf /etc/nginx/conf.d/git.conf
COPY config/cgitrc.template /etc/

# Enable nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

COPY script/init.sh /opt/init.sh
COPY 404.html /usr/share/nginx/html
COPY 401.html /usr/share/nginx/html

FROM scratch
COPY --from=builder / /
EXPOSE 80
CMD ["sh", "/opt/init.sh"]
