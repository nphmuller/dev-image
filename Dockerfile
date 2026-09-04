FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash
ENV PATH="/root/.opencode/bin:${PATH}"

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        gh \
        git \
        libgcc-s1 \
        libstdc++6 \
        nodejs \
        npm \
        ripgrep \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN npm install --global pnpm \
    && curl -fsSL https://opencode.ai/v2/install | bash \
    && git config --global user.name "Nick Muller" \
    && git config --global user.email "3781551+nphmuller@users.noreply.github.com"

WORKDIR /home/workspace

VOLUME ["/home/workspace", "/root/.config/opencode", "/root/.local/share/opencode"]

EXPOSE 4096

ENTRYPOINT ["opencode2"]
CMD ["serve", "--hostname", "0.0.0.0", "--port", "4096"]
