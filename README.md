# Learning Docker

## Introduction

Containers are a convenient way of packaging all the applications that you need and deploy it anywhere you want, and Docker is a software that allows you to do this. To put it simply, Docker solves the problem of "It works on my computer, why doesn't it work on yours?". 

To understand what containers are, one must first understand what virtual machines are. The way I understand virtual machines is the following. Imagine your laptop, where you are typing away and interacting with what's shown on the screen. Now imagine it, except without the keyboard, glass screen, plastic covering, battery, motherboard, CPUs and all the internal hardware inside it. All of the hardware has been abstracted away, with only the operating system and running applications remaining, which makes your laptop a virtual machine. In this way virtual machines "virtualize" the underlying hardware.

![Virtual Machines and Containers Comparison](images/vms_vs_containers.jpg "Comparison between VMs and Containers (from SDxCentral)")

Containers take it one step further. They virtualize the underlying operating system as well, leaving only the applications on top. This makes them very lightweight compared to virtual machines, where an entire operating system (such as Windows or macOS) has to be installed in order for us to use them. Docker uses Linux as its operating system kernel (a kernel is the operating system's core, which directly interacts with and runs on top of the hardware), and most containers use the lightweight Alpine flavour of Linux because of its size. Compared to virtual machines, which has sizes on the order of several gigabytes, container sizes are only on the order of megabytes.

## Common Docker Commands

Docker commands cheat sheets: from [Docker Labs](https://dockerlabs.collabnix.com/docker/cheatsheet/) and [PhoenixNap](https://phoenixnap.com/kb/list-of-docker-commands-cheat-sheet)

![Docker cheat sheet](https://phoenixnap.com/kb/wp-content/uploads/2021/04/docker-commands-cheatsheet-webpage.jpg "Docker cheat sheet")

0. Help for Docker

        docker --help

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

7. Build Docker image using the following (can optionally specify version of image)

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

13. Run a Docker container interactively `-it` (which means I can access a Bash shell inside the container) and access this shell using `exec -it`

        docker run -it image_name
        docker exec -it container_name bash
        [e.g.] docker exec -it nginx-automation bash

## Nginx Automation

Nginx, among its many uses, can be used as a server for hosting web content. Here, an Nginx Docker image can be built and the container can be used to host a simple HTML file (`index.html`).

By connecting the DockerHub repo with the GitHub repo, any changes made to the HTML file will result in an automated build after pushing changes to the GitHub repo, i.e. after running `git push`.



