# Cytoscape Desktop in a Docker Image - HEADLESS

Cytoscape Desktop in Docker image withOUT GUI running using xvfb.

This Docker image is built on top of the ubuntu:20.04 image.

https://hub.docker.com/_/ubuntu

Cytoscape content at DockerHub can be found here:

https://hub.docker.com/u/cytoscape

If you exposed the correct port (`5900` by default), you can still use the VNC server.
The `x11vnc` server is installed and can be run with

```
docker exec cy x11vnc -display :99 -auth /root/.Xauth
```

# Pull or Build
You have the option of pulling the latest container from DockerHub,
```
docker pull jvansan/cytoscape-desktop-headless:latest
```

or you can clone this repo, cd into it and build the container yourself

```
docker build -t jvansan/cytoscape-desktop-headless .
```

# Run
## Launch Cytoscape in Docker
In a local terminal window, issue the following commands to run this docker container and launch Cytoscape:

```
docker run --rm --name cy -v $HOME/cytoscape:/root/data -p 1234:1234 jvansan/cytoscape-desktop-headless:latest
```
 
_Pro-tip: Before shutting down the container, be sure to check that all your output files have indeed been saved locally._

## Interact

### Local Shell

```
docker exec -it cy bash
```

### CyREST

All interactions with Cytoscape should be made through CyREST, which 
is available at http://localhost:1234/v1 if you connect this port in Docker.