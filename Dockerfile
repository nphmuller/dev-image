FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_MAJOR=24
ENV SHELL=/bin/bash
ENV PATH="/root/.opencode/bin:${PATH}"

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        gh \
        git \
        gnupg \
        libgcc-s1 \
        libstdc++6 \
        ripgrep \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
        | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" \
        > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install --yes --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN node --version \
    && npm --version \
    && npm install --global pnpm@10 \
    && pnpm --version

ARG OPENCODE_VERSION
RUN curl -fsSL https://opencode.ai/v2/install | bash -s -- --version "${OPENCODE_VERSION}" \
    && /root/.opencode/bin/opencode2 --version

RUN git config --global user.name "Nick Muller" \
    && git config --global user.email "3781551+nphmuller@users.noreply.github.com"

WORKDIR /home/workspace

VOLUME ["/home/workspace", "/root/.config/opencode", "/root/.local/share/opencode"]

EXPOSE 4096

ENTRYPOINT ["/root/.opencode/bin/opencode2"]
CMD ["serve", "--hostname", "0.0.0.0", "--port", "4096"]
