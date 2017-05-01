![Docker Pulls](https://img.shields.io/docker/pulls/gentlezhou/laravel-xdebug.svg)

This project is base from [hitalos/laravel](https://hub.docker.com/r/hitalos/laravel/), thanks !


#Laravel


* php
    * composer
* nodejs
    * npm
    * yarn
* supervisor
* nginx



# laravel

Docker image to run PHP (supporting Laravel) and Node projects.

This image it's for development. **Optimize to use in production!**

In the latest update, I changed the base image to `php:alpine` for size optimizing.

## Tags
* [**`latest`**:](https://github.com/gentlezhou/laravel-xdebug/blob/master/Dockerfile)
* `php` 7.1.3
   * `composer` 1.4.1
* `nodejs` 7.9.0
   * `npm` 4.4.4
   * `yarn` 0.22.0

## Supported Databases (**PDO**)
* `mssql` (via dblib)
* `mysql`
* `pgsql`
* `sqlite`

## Extra supported extensions
* `curl`
* `exif`
* `gd`
* `ldap`
* `mongodb`

## Installing
    docker pull gentlezhou/laravel-xdebug

## Using

### With `docker`
    docker run -e XDEBUG_CONFIG="idekey=PHPSTORM remote_host=192.168.1.xxx --name <container_name> -d -v $PWD:/var/www -p 80:80 gentlezhou/laravel-xdebug
Where $PWD is the laravel installation folder.

"192.168.1.xxx" is your host's IP, please checkout your host with `ifconfig`. DO NOT use localhost or 127.0.0.1, because xdebug in the container wants to connect back your PHPSTORM IDE outside.

If you want to set remote_host to loopback interface instead, you can create an alias.
For Mac: `sudo ifconfig lo0 alias 10.200.10.1`


### With `docker-compose`

Create a `docker-compose.yml` file in the root folder of project using this as a template:
```
web:
    image: gentlezhou/laravel-xdebug:latest
    ports:
        - 80:80
    volumes:
        - ./:/var/www
    environment:
        - XDEBUG_CONFIG="idekey=PHPSTORM remote_host=10.200.10.1 remote_log=/var/log/xdebug.log"
    # If you don't want to use default 'artisan serve' command, edit and uncomment the line below.
    # command: php -S 0.0.0.0:80 -t public public/index.php
```

Then run using this command:

    docker-compose up


If you want to use a database, you can create your `docker-compose.yml` with two containers.
```
web:
    image: gentlezhou/laravel-xdebug:latest
    ports:
        - 80:80
    volumes:
        - ./:/var/www
    links:
        - db
    environment:
        DB_HOST: db
        DB_DATABASE: dbname
        DB_USERNAME: username
        DB_PASSWORD: p455w0rd
        DB_CONNECTION: [pgsql or mysql]
        XDEBUG_CONFIG: "idekey=PHPSTORM remote_host=10.200.10.1"
db:
    image: [postgres or mysql]
    environment:
        # with mysql
        MYSQL_DATABASE: dbname
        MYSQL_USER: username
        MYSQL_PASSWORD: p455w0rd

        # with postgres
        POSTGRES_DB: dbname
        POSTGRES_USER: username
        POSTGRES_PASSWORD: p455w0rd
```



You have saw that , the env variable `XDEBUG_CONFIG`  can set any thing which listed by `php -i | grep xdebug`


