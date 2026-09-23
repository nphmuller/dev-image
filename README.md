# OpenCode development image

An Ubuntu-based development image with OpenCode, Git, the GitHub
CLI, Node.js, npm, pnpm, and Google Chrome (amd64).

Scheduled builds resolve the latest OpenCode version before building, so new
releases invalidate the cached OpenCode installation layer automatically.
Chrome is installed in an earlier layer, which can be reused across OpenCode
updates. Rebuild without that layer's cache to pick up a newer Chrome release.

## Build

```sh
docker build -t opencode-dev .
```

## Run

The mount destinations match the container this repository was created in:

- `/home/workspace` contains checked-out projects.
- `/root/.config/gh` contains GitHub CLI credentials and configuration.
- `/root/.config/opencode` contains OpenCode configuration.
- `/root/.local/share/opencode` contains credentials, sessions, and other
  persistent OpenCode data.

Dockerfiles can declare mount destinations with `VOLUME`, but host source paths
must be supplied when the container is run. For example:

```sh
docker run --rm -it \
  -p 4096:4096 \
  -v /path/to/workspace:/home/workspace \
  -v /path/to/github/config:/root/.config/gh \
  -v /path/to/opencode/config:/root/.config/opencode \
  -v /path/to/opencode/storage:/root/.local/share/opencode \
  opencode-dev
```

The image runs the OpenCode 2.0 web server on port 4096 by default. Append
OpenCode CLI arguments to the command above, or override the entrypoint for a
shell:

```sh
docker run --rm -it --entrypoint /bin/sh opencode-dev
```

Chrome is available as `google-chrome`. For headless use in the default
root-run container, pass `--no-sandbox`; `--disable-dev-shm-usage` avoids
Docker's small default shared-memory limit. For example:

```sh
google-chrome --headless --no-sandbox --disable-dev-shm-usage \
  --dump-dom 'data:text/html,<h1>Chrome works</h1>'
```
