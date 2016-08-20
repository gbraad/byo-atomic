FROM fedora:23

# Run update and install packages
RUN dnf update -y; \
    dnf install -y ansible rpm-ostree git polipo python; \
    dnf clean all

# Create working dir, clone fedora and centos atomic definitions
RUN mkdir -p /workspace ; \

# Create and initialize repo directory

    mkdir -p /srv/repo && \
    ostree --repo=/srv/repo init --mode=archive-z2

# Disable SELinux
RUN echo SELINUX=disabled > /etc/selinux/config

# Expose default SimpleHTTPServer port, set working dir
EXPOSE 8000
WORKDIR /workspace
VOLUME /workspace

# Start web proxy and SimpleHTTPServer
CMD polipo; pushd /srv/repo; python -m SimpleHTTPServer; popd
