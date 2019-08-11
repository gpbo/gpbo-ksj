FROM debian:stretch

## Install base packages ##
RUN apt-get update && apt-get install -yq \
        bash-completion \
        build-essential \
        less \
        sudo \
        vim \
        curl \
        ruby-full

## Create and run as gitpod user ##
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod \
    ## Passwordless sudo for users in the 'sudo' group ##
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
ENV HOME=/home/gitpod
WORKDIR $HOME
USER gitpod

## Set locales up right ##
RUN sudo locale-gen en_US en_US.UTF-8
RUN sudo dpkg-reconfigure locales

## Install brew ##
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
ENV PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

## Install branchout ##
RUN brew install branchout/branchout/branchout hub shellcheck

## Install skaffold ##
RUN brew install skaffold

## Install kubectl ##
RUN brew install kubernetes-cli

## Docker ##
RUN brew install docker docker-compose
