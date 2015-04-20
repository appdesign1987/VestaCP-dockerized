FROM ubuntu:latest

MAINTAINER jeroen@jeroenvd.nl

RUN apt-get update
RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes && apt-get update && apt-get -y install apt-show-versions wget git curl
#RUN apt-get -y install apt-show-versions && apt-get update && apt-get install -f

RUN mkdir /install
ADD install-ubuntu.sh /install/install-ubuntu.sh
RUN chmod 0755 /install/*
RUN chmod a+x /install/*
RUN cd /install && sh ./install-ubuntu.sh -e admin@domain.com -f -s vestahosting 

# Git clone scripts repo
RUN cd / && git clone https://github.com/appdesign1987/scripts.git

# Make sure scripts are executable
RUN cd /scripts && chmod +x *.sh

EXPOSE 22 21 80 8000 3306 443 25 993 110

#Start app                                                                                                                                                                                                  
ENTRYPOINT ["/scripts/StartAjenti.sh"]
