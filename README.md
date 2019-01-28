# docker-zenoss4
`docker-zenoss4` is a dockerized, Debian 7 based, image for [Zenoss Core v4.2.5](http://wiki.zenoss.org/Install_Zenoss#Zenoss_Core_4.2.5), based on [Hydruid's core-autodeploy for Ubuntu/Debian](https://github.com/hydruid/zenoss/), with alterations, enhancements and security improvements in accordance to Docker's ephemeral ecosystem. Hydruid's work was based on OS Virtualization/Bare-metal installs, and for its time was sufficient for the task.

## description
In continuing my journey to learn Docker's Best Practices, I had the need to dockerize the Battle-tested, Zenoss 4.2.5. This time around, I knew that Zenoss4 has dependencies on other processes to work properly at 100%. So in true, docker spirit, I have segregated all the major services that comprises the Zenoss4 Stack into its own dockerized images, utilizing docker's default image library for the following:

* [memcached](https://cloud.docker.com/repository/docker/stdnwbeheer/memcached/), a distributed memory caching system, named `zenoss4-memcached`
* [rabbitmq](https://hub.docker.com/_/rabbitmq/), the Advanced Message Queuing Protocol (AMQP), named `zenoss4-rabbitmq`
* [redis](https://hub.docker.com/_/redis/), a networked, in-memory, key-value data store, named `zenoss4-redis`
* [mariadb](https://hub.docker.com/_/mariadb/), SQL Database backwards compatible to `mysql 5.5`, named `zenoss4-mariadb` 
* [nginx](https://hub.docker.com/_/nginx/), reverse http proxy, named `zenoss4-nginx`

The dockerized image of zenoss v4.2.5 is aptly named `zenoss4-core`.

The main glue for all of this orchestration is really the [docker-compose.yml file](https://github.com/krull/docker-zenoss4/blob/master/docker-compose.yml) which pulls everything together. You can read more information on `docker-compose` and how to install it on your docker host at [docker's website](https://docs.docker.com/compose/).

The [Dockerfile](https://github.com/krull/docker-zenoss4/blob/master/Dockerfile) for the `zenoss4-core` build has directives that points to the necessary hostnames of each dockerized services mentioned above to function properly and collectively. There is a `.dockerignore` file that ignores the whole `init_fs` folder upon build time. Moreover, I have excluded some environmental variables in files called `.env` and `.env_make`. I have added sample `.smpl` files. Just rename them accordingly.

Many thanks for [hydruid](https://github.com/hydruid/zenoss/) for providing us a way to install zenoss4 on debian-based systems! Thanks for all the fish, Hydruid!

I have tried to build the image with docker best practices in mind. Should there be anything of note you notice, please do not hesitate to leave a comment.

## quickstart 
```
root@mcroth:~/sandbox# git clone https://github.com/stdnwbeheer/docker-zenoss4.git
Cloning into 'docker-zenoss4'...
remote: Counting objects: 69, done.
remote: Compressing objects: 100% (53/53), done.
remote: Total 69 (delta 19), reused 59 (delta 13), pack-reused 0
Unpacking objects: 100% (69/69), done.
Checking connectivity... done.
root@mcroth:~/sandbox# cd docker-zenoss4/
root@mcroth:~/sandbox/docker-zenoss4# docker-compose up -d
Creating network "dockerzenoss4_zenoss" with driver "bridge"
Creating zenoss4-memcached
Creating zenoss4-rabbitmq
Creating zenoss4-redis
Creating zenoss4-mariadb
Creating zenoss4-core
Attaching to zenoss4-memcached, zenoss4-rabbitmq, zenoss4-redis, zenoss4-mariadb, zenoss4-core
...

root@mcroth:~/sandbox/docker-zenoss4# docker ps -a
CONTAINER ID        IMAGE                   COMMAND                  CREATED              STATUS              PORTS                                                    NAMES
0690ca546ee7        mcroth/docker-zenoss4   "docker-entrypoint.sh"   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp                                   zenoss4-core
c75bb844f5d3        mariadb:5.5             "docker-entrypoint.sh"   About a minute ago   Up About a minute   0.0.0.0:32832->3306/tcp                                  zenoss4-mariadb
69a71a9d3151        redis:3.0               "docker-entrypoint.sh"   About a minute ago   Up About a minute   0.0.0.0:32831->6379/tcp                                  zenoss4-redis
5814c80111c3        rabbitmq:3.6            "docker-entrypoint.sh"   About a minute ago   Up About a minute   4369/tcp, 5671/tcp, 25672/tcp, 0.0.0.0:32830->5672/tcp   zenoss4-rabbitmq
97f1d528d9eb        memcached:1.4           "docker-entrypoint.sh"   About a minute ago   Up About a minute   0.0.0.0:32829->11211/tcp                                 zenoss4-memcached
```

Once the init is done, you ought to have a full, 100% working `zenoss4` docker install located at `http://localhost:8080`! Default zenoss logins: `admin`/`zenoss`
