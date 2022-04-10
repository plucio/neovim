FROM alpine:latest

ARG GOLANG_URL="https://go.dev/dl/go1.18.linux-amd64.tar.gz"

# User config
ENV USER_NAME="neovim" \
    USER_GROUP="neovim" \
    USER_UID="1000" \
    USER_GID="1000" \
    USER_SHELL="/bin/bash"

ENV USER_HOME="/home/${USER_NAME}"


# Running config
ENV WORKSPACE="/workspace"


# Install basic packages
RUN apk --no-cache add \
    git \
    curl \
    shadow \
    sudo \
    su-exec \
    python3 \
    py3-virtualenv \
    py3-pynvim \
    neovim \
    neovim-doc \
    bash \
    nodejs \
    npm \
    gcompat
    

# Install golang
RUN curl -SL ${GOLANG_URL} | tar -xzC /usr/local


COPY entrypoint.sh /usr/local/bin/


ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
