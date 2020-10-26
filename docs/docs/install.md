# Installation

Latest Version: **GITHUB_VERSION**

?> Before starting Cheat you may read [Configuration](config.md).

!> TLS is required for Cheat to work. Either enable TLS inside Cheat or 
   use a reverse proxy to serve Cheat via TLS.

## Docker

Setting up Cheat with docker is pretty easy, you basically just have to start the docker container, and you are ready to go:

The [newtorn/cheat](https://hub.docker.com/r/newtorn/cheat) docker images are multi-arch docker images. 
This means the image will work for `amd64`, `i386`, `ppc64le` (power pc), `arm64`, `arm v7` (Raspberry PI).

When using [TURN](nat-traversal.md), Cheat will allocate ports for relay connections.

The ports must be mapped that the host system forwards them to the Cheat container.

By default, Cheat runs on port 5050.

?> Replace `YOUREXTERNALIP` with your external IP. One way to find your external ip is with ipify.
   ```bash
   $ curl 'https://api.ipify.org'
   ```

### Network Host (recommended)

```bash
$ docker run --net=host -e CHEAT_EXTERNAL_IP=YOUREXTERNALIP newtorn/cheat:GITHUB_VERSION
```

#### docker-compose.yml

```yaml
version: "3.7"
services:
  cheat:
    image: newtorn/cheat:GITHUB_VERSION
    network_mode: host
    environment:
      CHEAT_EXTERNAL_IP: "YOUREXTERNALIP"
```

### Port Range

`CHEAT_TURN_STRICT_AUTH` should only be disabled if you enable TLS inside
Cheat and not use a reverse proxy with `CHEAT_TRUST_PROXY_HEADERS=true`.


```bash
$ docker run \
    -e CHEAT_TURN_PORT_RANGE=50000:50100 \
    -e CHEAT_TURN_STRICT_AUTH=false \
    -e CHEAT_EXTERNAL_IP=YOUREXTERNALIP \
    -p 5178:5178 \
    -p 3478:3478 \
    -p 50000-50100:50000-50100/udp \
    newtorn/cheat:GITHUB_VERSION
```

#### docker-compose.yml

```yaml
version: "3.7"
services:
  cheat:
    image: newtorn/cheat:GITHUB_VERSION
    ports:
      - 5178:5178
      - 3478:3478
      - 50000-50100:50000-50100/udp
    environment:
      CHEAT_TURN_PORT_RANGE: "50000:50100"
      CHEAT_EXTERNAL_IP: "YOUREXTERNALIP"
      CHEAT_TURN_STRICT_AUTH: "false"
```

## Binary

### Supported Platforms:

* linux_amd64 (64bit)
* linux_i386 (32bit)
* armv7 (32bit used for Raspberry Pi)
* armv6
* arm64 (ARMv8)
* ppc64
* ppc64le
* windows_i386.exe (32bit)
* windows_amd64.exe (64bit)

Download the zip with the binary for your platform from [newtorn/cheat Releases](https://github.com/newtorn/cheat/releases).

```bash
$ wget https://github.com/newtorn/cheat/releases/download/vGITHUB_VERSION/cheat_GITHUB_VERSION_{PLATFORM}.tar.gz
```

Unzip the archive.

```bash
$ tar xvf cheat_GITHUB_VERSION_{PLATFORM}.tar.gz
```

Make the binary executable (linux only).

```bash
$ chmod +x cheat
```

Execute cheat:

```bash
$ ./cheat
# on windows
$ cheat.exe
```

## Arch-Linux(aur)

TODO

## Source

[See Development#build](development.md#build)
