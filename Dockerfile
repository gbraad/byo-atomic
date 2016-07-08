FROM fedora:23

# Install packages
RUN dnf install -y ansible rpm-ostree git polipo python; \
    dnf clean all

# Create working dir, clone fedora and centos atomic definitions
RUN mkdir -p /home/working; \

# Create and initialize repo directory

    mkdir -p /srv/repo && \
    ostree --repo=/srv/repo init --mode=archive-z2

# Expose default SimpleHTTPServer port, set working dir
EXPOSE 8000
WORKDIR /home/working

# Start web proxy and SimpleHTTPServer
CMD polipo; pushd /srv/repo; python -m SimpleHTTPServer; popd
