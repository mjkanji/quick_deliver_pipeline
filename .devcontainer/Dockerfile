FROM ghcr.io/prefix-dev/pixi

ENV APT_INSTALL="apt-get install -y --no-install-recommends"

# Install git and ca-certificates (which are needed when connecting to GitLab)
RUN apt-get update && \
    $APT_INSTALL git && \
    $APT_INSTALL --reinstall ca-certificates && \
    # cleanup apt cache
    rm -rf /var/lib/apt/lists/*
