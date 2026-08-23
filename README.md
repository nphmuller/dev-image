# OpenCode development image

The official Alpine-based OpenCode image with Git, the GitHub CLI, Node.js, npm,
and pnpm added.

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
  -v /path/to/workspace:/home/workspace \
  -v /path/to/opencode/config:/root/.config/opencode \
  -v /path/to/opencode/storage:/root/.local/share/opencode \
  opencode-dev
```

The image inherits OpenCode as its entrypoint. Append OpenCode CLI arguments to
the command above, or override the entrypoint for a shell:

```sh
docker run --rm -it --entrypoint /bin/sh opencode-dev
```
