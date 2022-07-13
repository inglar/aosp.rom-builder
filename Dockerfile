FROM ubuntu:22.04

RUN apt-get update \
  && apt-get install -y \
    bison \
    build-essential \
    ccache \
    curl \
    flex \
    g++-multilib \
    gcc-multilib \
    git \
    gnupg \
    gperf \
    lib32ncurses5-dev \
    lib32z-dev \
    libc6-dev-i386 \
    libgl1-mesa-dev \
    libx11-dev \
    libxml2-utils \
    openjdk-8-jdk \
    unzip \
    x11proto-core-dev \
    xsltproc \
    zip \
    zlib1g-dev \
    # extra
    libncurses5 \
    libssl-dev \
    openssh-client \
    # extra from los
    bc \
    imagemagick \
    lib32readline-dev \
    #lib32z1-dev
    liblz4-tool \
    libncurses5 \
    libncurses5-dev \
    libsdl1.2-dev \
    libssl-dev \
    libxml2 \
    libxml2-utils \
    lzop \
    pngcrush \
    rsync \
    schedtool \
    squashfs-tools \
    xsltproc \
    zip \
    zlib1g-dev
    #libwxgtk3.0-dev

RUN apt-get clean \
  && apt-get autoclean \
  && apt-get autoremove

RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo \
  && chmod a+x /usr/local/bin/repo

# Fix python not found
RUN ln -s /usr/bin/python3 /usr/local/bin/python

# Connection issues fix for Linux
RUN echo "net.ipv4.tcp_window_scaling=0" | tee /etc/sysctl.d/10-repo.conf

RUN useradd -ms /bin/bash builder \
  && chown -R builder:builder /home/builder

ADD init.sh /home/builder/
ADD copy-local-manifests.sh /home/builder/
ADD gitconfig /home/builder/.gitconfig

RUN chown builder:builder /home/builder/init.sh \
  && chmod +x /home/builder/init.sh \
  && chown builder:builder /home/builder/copy-local-manifests.sh \
  && chmod +x /home/builder/copy-local-manifests.sh

USER builder

# enable ccache
ENV USE_CCACHE=1
ENV CCACHE_EXEC=/usr/bin/ccache
ENV HOME_DIR=/home/builder

RUN ccache -M 50G \
  && ccache -o compression=true

WORKDIR /home/builder

ENTRYPOINT /home/builder/init.sh
