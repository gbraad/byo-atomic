Docker
======


Build and run this container with:

``` 
docker build --rm -t $USER/atomicrepo .
docker run --privileged -d -p 8000:8000 --name atomicrepo $USER/atomicrepo
docker exec -it atomicrepo bash 
```

Inside the container, mod tree file as described in Step Three of the [README](README.md)
 
Then, compose tree with:

```
rpm-ostree compose tree  --proxy=http://127.0.0.1:8123  --repo=/srv/repo fedora-atomic/fedora-atomic-docker-host.json
```

Or, for CentOS, with:

```
rpm-ostree compose tree  --proxy=http://127.0.0.1:8123  --repo=/srv/repo sig-atomic-buildscripts/centos-atomic-host.json
```

When the compose is complete, your tree will be accessible at 

   http://$YOUR_IP:8000/repo


To configure an Atomic host to receive updates from your build machine, 
run a pair of commands like the following to add a new "foo" repo definition 
to your host, and then rebase to that tree:

```
sudo ostree remote add foo http://$YOUR_IP:8000/repo --no-gpg-verify
sudo rpm-ostree rebase foo:fedora-atomic/f23/x86_64/docker-host
```
