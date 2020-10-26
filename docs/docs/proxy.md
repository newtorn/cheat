# Proxy

!> When using a proxy enable `CHEAT_TRUST_PROXY_HEADERS`. See [Configuration](config.md).

## nginx

### At root path

```nginx
upstream cheat {
  # Set this to the address configured in
  # CHEAT_SERVER_ADDRESS. Default 5178
  server 127.0.0.1:5178;
}

server {
  listen 80;

  # Here goes your domain / subdomain
  server_name cheat.example.com;

  location / {
    # Proxy to cheat
    proxy_pass         http://cheat;
    proxy_http_version 1.1;

    # Set headers for proxying WebSocket
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header   Connection "upgrade";
    proxy_redirect     http:// $scheme://;

    # Set proxy headers
    proxy_set_header   X-Real-IP $remote_addr;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Proto http;

    # The proxy must preserve the host because cheat verifies it with the origin
    # for WebSocket connections
    proxy_set_header   Host $http_host;
  }
}
```

### At a sub path

```nginx
upstream cheat {
  # Set this to the address configured in
  # CHEAT_SERVER_ADDRESS. Default 5178
  server 127.0.0.1:5178;
}

server {
  listen 80;

  # Here goes your domain / subdomain
  server_name cheat.example.com;

  location /cheat/ {
    rewrite ^/cheat(/.*) $1 break;
  
    # Proxy to cheat
    proxy_pass         http://cheat;
    proxy_http_version 1.1;

    # Set headers for proxying WebSocket
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header   Connection "upgrade";
    proxy_redirect     http:// $scheme://;

    # Set proxy headers
    proxy_set_header   X-Real-IP $remote_addr;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Proto http;

    # The proxy must preserve the host because cheat verifies it with the origin
    # for WebSocket connections
    proxy_set_header   Host $http_host;
  }
}
```

## Apache (httpd)

The following modules are required:

* mod_proxy
* mod_proxy_wstunnel
* mod_proxy_http

### At root path

```apache
<VirtualHost *:80>
    ServerName cheat.example.com
    Keepalive On

    # The proxy must preserve the host because cheat verifies it with the origin
    # for WebSocket connections
    ProxyPreserveHost On

    # Replace 5178 with the port defined in CHEAT_SERVER_ADDRESS.
    # Default 5178

    # Proxy web socket requests to /stream
    ProxyPass "/stream" ws://127.0.0.1:5178/stream retry=0 timeout=5

    # Proxy all other requests to /
    ProxyPass "/" http://127.0.0.1:5178/ retry=0 timeout=5

    ProxyPassReverse / http://127.0.0.1:5178/
</VirtualHost>
```

### At a sub path

```apache
<VirtualHost *:80>
    ServerName cheat.example.com
    Keepalive On

    Redirect 301 "/cheat" "/cheat/"

    # The proxy must preserve the host because cheat verifies it with the origin
    # for WebSocket connections
    ProxyPreserveHost On

    # Proxy web socket requests to /stream
    ProxyPass "/cheat/stream" ws://127.0.0.1:5178/stream retry=0 timeout=5

    # Proxy all other requests to /
    ProxyPass "/cheat/" http://127.0.0.1:5178/ retry=0 timeout=5
    #                 ^- !!trailing slash is required!!

    ProxyPassReverse /cheat/ http://127.0.0.1:5178/
</VirtualHost>
```
