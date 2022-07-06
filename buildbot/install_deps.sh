#!/bin/bash

(
  SLEEP=0
  for i in `seq 1 5`; do
    sleep $SLEEP
    SLEEP=$(( SLEEP + 10))

    (
      set -ex
      apt-get -qq -y update || exit 1
      apt-get install -qq -y gnupg || exit 1

      dpkg --add-architecture i386
      echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
      dpkg --configure -a
      apt-get -qq -y update || exit 1
      
      apt-get install -qq -y \
        automake \
        bc \
        binutils-dev \
        binutils \
        bison \
        buildbot-worker \
        ccache \
        cmake \
        debootstrap \
        dos2unix \
        e2fsprogs \
        flex \
        g++ \
        g++-multilib \
        gawk \
        gcc-multilib \
        git \
        inetutils-ping \
        jq \
        libattr1-dev \
        libc6-dev \
        libc6-dev:i386 \
        libcap-ng-dev \
        libelf-dev \
        libfdt-dev \
        libgcrypt-dev \
        libglib2.0-dev \
        libgss-dev \
        liblzma-dev \
        libpixman-1-dev \
        libssl-dev \
        libstdc++*-dev-*-cross \
        libtinfo-dev \
        libtinfo5 \
        libtool \
        libxml2-dev \
        mc \
        mdadm \
        m4 \
        make \
        ninja-build \
        openssh-client \
        pkg-config \
        python-is-python3 \
        python3-dev \
        python3-distutils \
        python3-psutil \
        psmisc \
        rsync \
        wget \
        xfsprogs \
        zlib1g-dev || exit 1
    ) && exit 0
  done
  exit 1
) || $ON_ERROR

# Optional, ingore if it fails.
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
bash add-google-cloud-ops-agent-repo.sh --also-install

update-alternatives --install "/usr/bin/ld" "ld" "/usr/bin/ld.gold" 20
update-alternatives --install "/usr/bin/ld" "ld" "/usr/bin/ld.bfd" 10
