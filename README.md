Devolo dLAN AVpro Manager
=========================

This docker image makes it possible to run the dLAN AVpro Manager software in dockers, without having to install it on your Ubuntu/Windows server. The X11 GUI is exposed via a WebGUI. The docker image requires to run with the "macvlan" option to assign a routable IP address, because the AVpro Manager does a scan of the network, and that's not possible with a NAT'ed docker network.

NOTE: The "--net host" option won't work, because X11 to WebGUI requires the same ports as your Linux system, and it will fail to start the X11 within the docker container.

Ports exposed
-------------

- `5800` : AVpro Manager GUI

Volumes
-------

`/config`

Run
---

Launch the AVpro Manager docker container with the following command:

```

docker network create -d macvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  -o parent=eth0 net-pub

docker run [-d] \
    --name=avpro \
    --network net-pub \
    --ip 192.168.1.10 \
    -e TZ=Europe/Amsterdam \
    -v /docker/avpro/config:/config \
    ualex73/devolo-avpromanager
```

Where:
  - `/docker/avpro/config`: This is where AVpro Manager stores its configuration.
  - `--network net-pub` - TBD
  - `--ip 192.168.1.10` - TBD

Browse to `http://your-host-ip:5800` to access the AVpro Manager GUI.


Docker-compose.yaml Example
---
```
version: '3'

networks:

  net-pub:
    driver: macvlan
    driver_opts:
      parent: eth0
    ipam:
      config:
        - subnet: 192.168.1.0/24

services:

  avpro:
    container_name: avpro
    image: ualex73/devolo-avpromanager:latest
    restart: unless-stopped
    networks:
      net-pub:
        ipv4_address: 192.168.1.10
    environment:
     - TZ=Europe/Amsterdam
    volumes:
      - /docker/avpro/config:/config
```

