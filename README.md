h1. Apache Docker Proxy

h2. Usage:

```
docker run -e proxyhost="pie" --link pie -v `pwd`/ssl:/ssl -d --rm -p 80:80 -p 443:443 webserver
```

proxyhost is the name of your sidecar container (which you also ```link``` to as well)

/ssl is the directory to your SSL certificates, called certificate.crt & certificate.key
