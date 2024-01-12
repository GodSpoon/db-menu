# Start with an Alpine base image
FROM alpine:latest

# Install 
RUN apk update && \
    apk add --no-cache python3 py3-setuptools pipx go git make lxc bash shadow

# Set bash
SHELL ["/bin/bash", "-c"]

# Install yq
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

# Clone and build distrobuilder
RUN mkdir -p $HOME/go/src/github.com/lxc/ && cd $HOME/go/src/github.com/lxc/ && \
    git clone https://github.com/lxc/distrobuilder && cd ./distrobuilder && \
    make

# Install dbmenu using pipx
RUN pipx install git+https://github.com/itoffshore/distrobuilder-menu.git && \
    pipx ensurepath && \
    . ~/.profile

# Default command to run on container start
CMD ["dbmenu"]
