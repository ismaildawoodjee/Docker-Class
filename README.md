# Learning Docker

## Contents

- [Learning Docker](#learning-docker)
  - [Contents](#contents)
  - [Introduction](#introduction)
  - [Common Docker Commands](#common-docker-commands)
  - [Nginx (Automating Builds)](#nginx-automating-builds)
  - [Scrapy Spider (Mounting Volumes / Copying Files)](#scrapy-spider-mounting-volumes--copying-files)
  - [Docker Compose](#docker-compose)
    - [Jupyter Notebook Container Environment](#jupyter-notebook-container-environment)
    - [Nginx, Flask, MySQL App](#nginx-flask-mysql-app)
  - [Docker Swarm](#docker-swarm)
    - [Voting App with Docker Swarm](#voting-app-with-docker-swarm)

## Introduction

Containers are a convenient way of packaging all the applications that you need
and deploy it anywhere you want, and Docker is a software that allows you to do
this. To put it simply, Docker solves the problem of "It works on my computer,
why doesn't it work on yours?".

To understand what containers are, one must first understand what virtual
machines are. The way I understand virtual machines is the following. Imagine
your laptop, where you are typing away and interacting with what's shown on the
screen. Now imagine it, except without the keyboard, glass screen, plastic
covering, battery, motherboard, CPUs and all the internal hardware inside it.
All of the hardware has been abstracted away, with only the operating system
and running applications remaining, which makes your laptop a virtual machine.
In this way virtual machines "virtualize" the underlying hardware.

![Virtual Machines and Containers Comparison](images/vms_vs_containers.jpg "Comparison between VMs and Containers (from SDxCentral)")

Containers take it one step further. They virtualize the underlying operating
system as well, leaving only the applications on top. This makes them very
lightweight compared to virtual machines, where an entire operating system
(such as Windows or macOS) has to be installed in order for us to use them.
Docker uses Linux as its operating system kernel (a kernel is the operating
system's core, which directly interacts with and runs on top of the hardware),
and most containers use the lightweight Alpine flavour of Linux because of its
size. Compared to virtual machines, which has sizes on the order of several
gigabytes, container sizes are only on the order of megabytes.
17. Delete all

## Common Docker Commands

Docker commands cheat sheets: from [Docker Labs](https://dockerlabs.collabnix.com/docker/cheatsheet/) and [PhoenixNap](https://phoenixnap.com/kb/list-of-docker-commands-cheat-sheet)

![Docker cheat sheet](https://phoenixnap.com/kb/wp-content/uploads/2021/04/docker-commands-cheatsheet-webpage.jpg "Docker cheat sheet")

0. Help for Docker, and check if Docker is running

        docker --help
        docker info

1. See running Docker containers

        docker ps

2. See all Docker containers (including the exited ones)

        docker ps -a

3. See Docker images

        docker images
        docker image ls

4. Check the logs of a container

        docker logs container_name
        [e.g.] docker logs flask-container

5. Remove containers with

        docker rm container_name
        [e.g.] docker rm flask-container

6. Remove images with

        docker rmi image_name
        [e.g.] docker rmi flask-app

7. Build Docker image using the following (can optionally specify version of
image)

        docker build -t give_image_name[:version_number] .
        [e.g.] docker build -t flask-app .

8. Run Docker container

        docker run --name container_name -p port_no:port_no image_name
        [e.g.] docker run --name flask-container -p 5000:5000 flask-app 

        [or just] docker run image_name:tag
        docker run postgres:latest

9. Login to Docker hub

        docker login

10. Tag an existing repo on local machine with the repo created on DockerHub

        docker tag image_name user_name/dockerhub_image_name:tag
        [e.g.] docker tag flask-app ismaildawoodjee/flask-app-repo:hubtest

11. Push the local repo to DockerHub

        docker push user_name/dockerhub_image_name:tag
        [e.g.] docker push ismaildawoodjee/flask-app-repo:hubtest

12. Pull an image from DockerHub

        docker pull image_name
        [e.g.] docker pull postgres

13. Run a Docker container interactively `-i` (which means I can access a Bash
shell inside the container) and access this shell using `exec -i. Running a
container with flag`-d` means the container will keep running in the background
(detached mode).

        docker run --name [CONTAINER_NAME] -td [IMAGE_NAME] [COMMAND]
        [e.g.] docker run --name spider -td scrapy-spider:1.0 bash
        docker exec -it [CONTAINER_NAME] bash
        [e.g.] docker exec -it spider bash

14. Start/stop/restart or see status of Docker service

        service docker {start|stop|restart|status}

15. Copy files/folder from container to local working directory

        docker cp [CONTAINER]:[/path/inside/container] .

16. Mount a volume from a local directory to the container (running the
container in the process)

        docker run -v /absolute/path/to/local/directory:/app/data [IMAGE_NAME]

17. Remove (all) stopped containers and dangling images

        docker system prune [-a]

## Nginx (Automating Builds)

Nginx, among its many uses, can be used as a server for hosting web content.
Here, an Nginx Docker image can be built and the container can be used to host
a simple HTML file (`index.html`). By connecting the DockerHub repo with the
GitHub repo, any changes made to the HTML file will result in an automated
build after pushing changes to the GitHub repo, i.e. after running `git push`.
17. Delete all

## Scrapy Spider (Mounting Volumes / Copying Files)

The Scrapy spider crawls the two websites specified in the `dockerspider.py`
file and outputs their HTML pages. These pages can be transferred to the local
file by mounting a volume to the container, or more easily by using the
`docker cp` command to copy files.
17. Delete all

## Docker Compose

"Docker Compose is a tool for defining and running multi-container Docker
applications." It is written in a `yaml` or `yml` file, and can be run using
the `docker-compose up` command. Useful for a project where many containers
or services are needed for an application to run. For example a web application
requiring backend database, messaging, and frontend services. No need to
install all the individual components on your own system.

After you finish working, tear down the containers using `docker-compose down`.
17. Delete all

### Jupyter Notebook Container Environment

Running the `docker-compose.yml` file for building the Jupyter Notebook image
will produce the required `ipv4:port/?token=some_token` (in my case, it is
`http://0.0.0.0:8888/?token=some_token`) to open the notebook in my browser.
If for some reason, I lost this address, I can find it back by running the
container shell

    docker exec -it compose-notebook bash

and type in

    jupyter notebook list

to recover the lost address. Jupyter notebooks in this container environment
are kept in the `~/work` directory of the container and will appear there.
17. Delete all

### Nginx, Flask, MySQL App

An example of working with pre-written Docker Compose file from the official
Docker GitHub page. Simply `git clone` the repo, copy the app that is needed
(in this case, the `nginx-flask-mysql` folder) and delete the rest. Then run
`docker-compose up -d` to build the images and run the application container.
(Had to remove the `depends_on` key because it was giving an error).

Confirm that the three containers are running by typing in `docker ps`. Check
out the Flask website on `localhost:80`. Finally, tear down the containers
by typing in `docker-compose down`.
17. Delete all

## Docker Swarm

Docker Swarm is used to orchestrate several containers across several machines.
Think about managing several Docker containers deployed in several laptops/VMs.
Docker Swarm uses a `docker-stack.yml` file and it is not only for orchestration,
but also used for high availability (failed containers get replaced) and scalability.
17. Delete all

### Voting App with Docker Swarm

First check if Docker Swarm is active by typing in

    docker info

or more precisely,

    docker info | grep -i "swarm"

and finding that `Swarm: inactive` Swarm is inactive. Activate this using the
command

    docker swarm init

to initialize the Docker Swarm. Git clone the Example-Voting-App repo and run
within the directory

    docker stack deploy --compose-file docker-stack.yml vote

To see the bunch of running containers, type in

    docker stack services vote

The websites will be up on `localhost:5000` and `localhost:5001`. Tear down the
containers using

    docker stack rm vote
