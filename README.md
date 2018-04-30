# Apache Docker Proxy

## Usage:

```
docker run -e proxyhost="pie" --link pie -v `pwd`/ssl:/ssl -d --rm -p 80:80 -p 443:443 --name webserver --restart always webserver
```

proxyhost is the name of your sidecar container (which you also ```link``` to as well)

/ssl is the directory to your SSL certificates, called certificate.crt & certificate.key
