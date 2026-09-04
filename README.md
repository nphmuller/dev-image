# OpenCode development image

An Ubuntu-based development image with the OpenCode 2.0 beta, Git, the GitHub
CLI, Node.js, npm, and pnpm.

Scheduled builds resolve the current OpenCode beta version before building, so
new beta releases invalidate the cached installation layer automatically.

## Build

```sh
docker build -t opencode-dev .
```

## Run

The mount destinations match the container this repository was created in:

- `/home/workspace` contains checked-out projects.
- `/root/.config/opencode` contains OpenCode configuration.
- `/root/.local/share/opencode` contains credentials, sessions, and other
  persistent OpenCode data.

Dockerfiles can declare mount destinations with `VOLUME`, but host source paths
must be supplied when the container is run. For example:

```sh
docker run --rm -it \
  -p 4096:4096 \
  -v /path/to/workspace:/home/workspace \
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
