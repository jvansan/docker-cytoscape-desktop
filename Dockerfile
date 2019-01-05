FROM selenium/standalone-chrome-debug:3.13.0

# PARAMETERS
ENV CYTOSCAPE_VERSION 3.7.1

# CHANGE USER
USER root

RUN apt-get update

# INSTALL JAVA
RUN apt-get -y install default-jdk

# Set JAVA_HOME From sudo update-alternatives --config java
RUN echo '/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java' >> /etc/environment

# INSTALL ADDITIONAL TOOLS
RUN apt-get install -y nano links git wget curl htop

# INSTALL SUPERVISOR
RUN apt-get install -y supervisor

# INSTALL CYTOSCAPE
USER seluser

RUN mkdir /home/seluser/cytoscape
WORKDIR /home/seluser/cytoscape
RUN wget --progress=dot:giga --local-encoding=UTF-8 -v https://github.com/cytoscape/cytoscape/releases/download/$CYTOSCAPE_VERSION/cytoscape-$CYTOSCAPE_VERSION.tar.gz -O cytoscape-$CYTOSCAPE_VERSION.tar.gz

RUN tar -zxvf cytoscape-$CYTOSCAPE_VERSION.tar.gz
RUN rm cytoscape-$CYTOSCAPE_VERSION.tar.gz

# To launch it:
RUN echo "/home/seluser/cytoscape/cytoscape-unix-$CYTOSCAPE_VERSION/cytoscape.sh --rest 1234" > /home/seluser/cytoscape/start.sh
RUN chmod 777 /home/seluser/cytoscape/start.sh

# INSTALL NOVNC
WORKDIR /home/seluser
RUN git clone https://github.com/novnc/noVNC.git

# CONFIGURE supervisord
COPY supervisor/*.conf /etc/supervisor/conf.d/

# CLEAN UP
USER root
## Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#USER seluser

WORKDIR /home/seluser/cytoscape

CMD ["sudo", "/usr/bin/supervisord"]
