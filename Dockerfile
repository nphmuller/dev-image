FROM ghcr.io/anomalyco/opencode:latest

RUN apk add --no-cache git github-cli

WORKDIR /home/workspace

VOLUME ["/home/workspace", "/root/.config/opencode", "/root/.local/share/opencode"]
