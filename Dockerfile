FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -y wget lib32gcc1 lib32tinfo5 unzip

RUN useradd -ms /bin/bash steam


#Steamcmd installation
RUN mkdir -p /server/steamcmd
RUN mkdir -p /server/cs
WORKDIR /server/steamcmd
RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
RUN tar -xvzf steamcmd_linux.tar.gz
# Install server
RUN cd /server/steamcmd && ./steamcmd.sh +login anonymous \
                 +force_install_dir /server/cs \
                 +app_update 90 validate \
                 +quit 
#Server Start
WORKDIR /server/cs
ADD start.sh /server/cs/start.sh
RUN chmod 755 /server/cs/start.sh

CMD ["/server/cs/start.sh"]