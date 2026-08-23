FROM ghcr.io/anomalyco/opencode:latest

RUN apk add --no-cache git github-cli nodejs npm pnpm \
    && git config --global user.name "Nick Muller" \
    && git config --global user.email "3781551+nphmuller@users.noreply.github.com"

WORKDIR /home/workspace

VOLUME ["/home/workspace", "/root/.config/opencode", "/root/.local/share/opencode"]

CMD ["web", "--hostname", "0.0.0.0"]
