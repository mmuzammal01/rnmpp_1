RNMPP (Redis, Nginx, MySQL, PHP, Postgresql)
===========
This app will setup initial php environment ready for development by using docker containers.


# Install

- Clone this repository to your local machine.
- Run `docker network create rnmpp` to create rnmpp docker network
- Run `docker-compose up --build -d`

# Docker Containers

Build command `docker-compose up --build` will create following docker containers for you in rnmpp network 
- rnmpp_nginx
- rnmpp_php
- rnmpp_portainer
- rnmpp_mysql
- rnmpp_redis
- rnmpp_postgres

# Docker

The service uses docker-compose which will host a local containerised environment for the application.

Run `docker-compose up` from the root directory and this will build the application containers, start the webserver and PHP, install composer and run any migrations.

You can then simply view `http://localhost:8081` in your browser.

# Portainer

Portainer is a UI which allow you to easily manage your different Docker environments.
You can view your docker stacks and contrainer by opening `http://0.0.0.0:8888` in your browser. Default user is `admin` and password is `password`

# Running Commands

If you need to run commands on the container you can open a shell with `docker exec -it  rnmpp_php sh` to access php directly.

