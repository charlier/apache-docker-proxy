
# Apache Docker Proxy

A Docker image to launch an [Apache](https://httpd.apache.org) proxy service, handy for separating concerns between the [DMZ](https://en.wikipedia.org/wiki/DMZ_%28computing%29) world and your application.


## Setup
This assumes you've already [installed Docker](https://docs.docker.com/install/).
We're going to be using [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/) here, so the first thing we'll need is a [swarm](https://docs.docker.com/engine/swarm/) (even if it's a single node).
```bash
docker swarm init
```

Next, we're going to want to create our own [overlay network](https://docs.docker.com/network/overlay/) (to allow communication between the [services](https://docs.docker.com/engine/swarm/how-swarm-mode-works/services/) we're about to create)
```bash
docker network create --driver overlay my-network
```

## Adding secrets
In this case, the secrets are the SSL certificate & private key.
Assuming you've got your certificate in a directory called ssl (and with the appropriate names for the certs)
```
docker secret create certificate.crt `pwd`/ssl/certificate.crt
docker secret create certificate.key `pwd`/ssl/certificate.key
```
Should return two nice UIDs.

## Create the swarm

The first thing you'll want to do is plop your application onto the swarm (change names where appropriate)
```
docker service create \
  --name my-app \
  --network my-network \
  my-app
```
Now for the new web server proxy, don't forget to update the ```proxyhost``` environment variable to match your application.
```
docker service create \
  --name webserver \
  --secret certificate.crt \
  --secret certificate.key \
  -e proxyhost="my-app" \
  -p 80:80 \
  -p 443:443 \
  --network my-network \
  webserver
```

That's it!
