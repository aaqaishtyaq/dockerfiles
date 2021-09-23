FROM ghcr.io/aaqaishtyaq/openvscode-server-arm:3 as artifact
RUN tar xvzf "openvscode-server-v1.60.0-linux-aarch64.tar.gz"

FROM node:16 as final
WORKDIR /ide
COPY --from=artifact /code/openvscode-server-v1.60.0-linux-aarch64/ .
EXPOSE 3000
USER node
CMD ["./server.sh"]
