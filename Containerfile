FROM ghcr.io/warewulf/warewulf-rockylinux:8
RUN echo "assumeyes=1" >> /etc/yum.conf
RUN yum install -y epel-release
RUN dnf config-manager --set-enabled powertools 
RUN dnf update -y \
    && dnf install -y --allowerasing \
      #nmap \
      coreutils \
      cpio \
      dhclient \
      e2fsprogs \
      ethtool \
      findutils \
      initscripts \
      ipmitool \
      iproute \
      kernel-core \
      kernel-modules \
      net-tools \
      NetworkManager \
      nfs-utils \
      openssh-clients \
      openssh-server \
      pciutils \
      psmisc \
      rsync \
      rsyslog \
      strace \
      wget \
      which \
      words \
      slurm-slurmd \
    aria2 \
    bzip2-devel \
    byobu \
    dos2unix \
    emacs \
    fftw \
    fftw2 \
    fftw-devel \
    fftw2-devel \
    fftw-libs \
    fftw-libs-double \
    fftw-libs-long \
    fftw-libs-single \
    ftp \
    gd \
    gdal \
    gdal-devel \
    glx-utils \
    gmp \
    gmp-devel \
    gnuplot \
    golang \
    gromacs \
    gromacs-devel \
    gromacs-libs \
    gsl \
    gsl-devel \
    gstreamer1 \
    PackageKit-gstreamer-plugin \
    hdf5-openmpi-devel \
    hdf5-openmpi-static \
    htop \
    java-1.8.0-openjdk-devel \
    kitty \
    jsoncpp \
    jsoncpp-devel \
    lftp \
    libarchive-devel \
    libcurl-devel \
    libffi-devel \
    libibverbs-devel \
    libjpeg-turbo-devel \
    libmpc-devel \
    libnotify-devel \
    libssh2-devel \
    libstdc++-static \
    libtiff-devel \
    libuser \
    libX11-devel \
    libXaw-devel \
    libxml2-devel \
    libXmu-devel \
    libXt-devel \
    libxc \
    libxc-devel \
    lpsolve \
    lpsolve-devel \
    mariadb-devel \
    mesa-dri-drivers \
    mesa-filesystem \
    mesa-libGLU \
    mesa-libOSMesa \
    motif \
    mpfr \
    mpfr-devel \
    munge-devel \
    ncl \
    nco \
    ncurses-devel \
    openldap-clients \
    openssl-devel \
    p7zip \
    p7zip-plugins \
    pam-devel \
    pam_krb5 \
    pandoc \
    pango-devel \
    parallel \
    pcre2 \
    pcre2-devel \
    pcre2-tools \
    perl-App-cpanminus \
    perl-Archive-Tar \
    perl-Config-Tiny \
    perl-CPAN \
    perl-Digest-MD5 \
    perl-Digest-SHA \
    perl-Env \
    perl-JSON \
    perl-libwww-perl \
    perl-List-MoreUtils \
    perl-Module-Build \
    perl-Path-Tiny \
    perl-Test-Fatal \
    perl-Text-Soundex \
    petsc \
    petsc-devel \
    petsc64 \
    petsc-openmpi \
    pkgconfig \
    proj \
    proj-devel \
    python36-devel \
    rdma-core-devel \
    readline-devel \
    samba-common-tools \
    samba-libs \
    sqlite-devel \
    squashfs-tools \
    suitesparse \
    suitesparse-devel \
    sysstat \
    tcl-devel \
    texinfo \
    tk-devel \
    tree \
    txt2tags \
    udunits2 \
    udunits2-devel \
    lapack \
    xorg-x11-server-Xvfb \
    xorg-x11-server-devel \
    xterm \
    xz-devel \
    yum-utils \
    python3-pyOpenSSL \
    libtool-ltdl-devel \
    libxkbcommon-x11 \
    zsh \
    python3-libselinux \
    compat-openssl10 \
    htop \
    libXScrnSaver \
    ncurses-compat-libs \
    glibc \
    glibc-common \ 
    glibc-devel \
    glibc-gconv-extra \ 
    glibc-headers \
    glibc-langpack-en \
    valgrind \
    Lmod \
    libnsl \
    && dnf clean all

RUN systemctl unmask \
      console-getty.service \
      dev-hugepages.mount \
      getty.target \
      sys-fs-fuse-connections.mount \
      systemd-logind.service \
      systemd-remount-fs.service 

COPY munge.key  /etc/munge/
RUN chown munge: /etc/munge/munge.key
#CMD munge start
CMD systemctl start munge
#CMD slurmd start
CMD systemctl start slurmd

COPY excludes /etc/warewulf/
COPY container_exit.sh /etc/warewulf/

CMD [ "/bin/echo", "-e", \
      "This image is intended to be used with the Warewulf cluster management and", \
      "\nprovisioning system.", \
      "\n", \
      "\nFor more information about Warewulf, visit https://warewulf.org" ]

