# GNU Radio 3.8 on Docker
This repository contains a dockerfile that will build a Docker image of Ubuntu 20.04 that has GNU Radio 3.8 installed.

## Required Software
- Docker engine (not desktop)
- Recommend at least 4 GB of space
<br />**NOTE**: The instructions focus on executing Docker in the terminal. Make sure it works in the terminal by typing `docker`.

## Using the Dockerfile
Using Docker requires sudo permissions. Make sure you have sudo permissions for your user on the system.

### Building the Image
1. Enter the folder of the cloned repository.
<br /> `cd <folder name>`
2. Build the Dockerfile as an image.
<br />If you are using the root user, the command is `docker build -t <image name> .`
<br />Otherwise, if you have sudo permissions, the command is `sudo docker build -t <image name> .` This applies to all Docker commands used in the terminal.
<br />The choice of image name does not matter. It is the name you will reference when creating a container.
3. Process the build
<br />This step takes some time to complete as it is if you are installing software on a computer.
<br />If you see an error that says `debconf: delaying package configuration, since apt-utils is not installed`, **ignore it**. This error shows because of how Docker functions, but the image will compile fine regardless of this error.

**Side Note:** If you have made changes to commands that use `RUN` in the Dockerfile, ensure there are tags to provide an automatic reply (i.e. `-y` for `apt-get install`). Not providing an automatic reply causes the build process to hang.
<br />This works similarly for the setup of an operating system. If you find a different Linux OS also causes the build to hang because of polling for a reply, you might need to keep the line `ENV DEBIAN_FRONTEND noninteractive`.

#### Cleaning Images
If for any reason an image stops building mid-way through, the only commands I've found so far that removes it from the images list are `docker system prune` and `docker system prune -a --volumes`.
<br />It is important to remove images such as these as they will hog memory on a computer.
<br />**Keep in mind the second command will remove all your images, containers, and volumes from Docker. Execute that command under extreme caution.**

### Using the Image in a Container
A container is what Docker uses to run images.
<br />
1. Creating the container
<br />Use the command `docker container create -i -t --name <container name> <image name>`.
2. Starting the container
<br />Use the command `docker container start --attach -i <container name>.`

