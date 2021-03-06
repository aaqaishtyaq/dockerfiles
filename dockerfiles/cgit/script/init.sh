#!/bin/sh

CGIT_VARS='$CGIT_TITLE:$CGIT_DESC:$CGIT_VROOT:$CGIT_SECTION_FROM_STARTPATH:$CGIT_MAX_REPO_COUNT'

# Number of fcgi workers
if [ -z "$FCGI_CHILDREN" ]; then
    FCGI_CHILDREN=$(nproc)
fi

envsubst "$CGIT_VARS" < /etc/cgitrc.template > /etc/cgitrc

/usr/bin/spawn-fcgi -F $FCGI_CHILDREN -M 666 -s /run/fcgiwrap.socket /usr/bin/fcgiwrap;
chmod 777 /run/fcgiwrap.socket
/usr/sbin/nginx -g "daemon off;"
