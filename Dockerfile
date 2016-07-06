FROM fedora:23

# install needed packages

RUN dnf install -y rpm-ostree git polipo python; \
    dnf clean all

# create working dir, clone fedora and centos atomic definitions

RUN mkdir -p /home/working; \
    cd /home/working; \
    git clone https://github.com/CentOS/sig-atomic-buildscripts; \
    cd sig-atomic-buildscripts; \
    git checkout downstream; \
    cd ..; \
    git clone https://git.fedorahosted.org/git/fedora-atomic.git; \
    cd fedora-atomic; \
    git checkout f23; \

# create and initialize repo directory

    mkdir -p /srv/repo && \
    ostree --repo=/srv/repo init --mode=archive-z2

# expose default SimpleHTTPServer port, set working dir

EXPOSE 8000
WORKDIR /home/working

# start web proxy and SimpleHTTPServer

CMD polipo; pushd /srv/repo; python -m SimpleHTTPServer; popd
