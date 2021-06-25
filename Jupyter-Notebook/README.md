# Jupyter Notebook Container

To run a Jupyter notebook container using Docker Compose, open the terminal 
and type in

    docker-compose up

This will build the image and run the container after the build finishes. 
After that the terminal will provide a link to open the Jupyter notebook, for
instance

    http://0.0.0.0:8888/?token=ee8d80d2bc7dd5d0910e0a445e2ca8d6c3b1cd6eb31e0110

If this address is lost for some reason, run the container interactively using

    docker exec -it compose-notebook bash

and type in 

    jupyter notebook list

to see the running notebooks in the container. All the notebooks are kept in
the `~/work` directory within the container and files can be saved by mounting 
a volume or copying them into local host. After working on a notebook, I 
can push the container to Docker Hub, and anyone wishing to see my work or
contribute to it can pull it down and run it on their machine.
