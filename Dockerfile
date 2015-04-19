FROM ubuntu:latest

MAINTAINER jeroen@jeroenvd.nl

RUN apt-get update
RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes && apt-get update && apt-get -y install apt-show-versions wget curl
#RUN apt-get -y install apt-show-versions && apt-get update && apt-get install -f

RUN curl -O http://vestacp.com/pub/vst-install.sh && bash vst-install.sh

# Git clone scripts repo
RUN cd / && git clone https://github.com/appdesign1987/scripts.git

# Make sure scripts are executable
RUN cd /scripts && chmod +x *.sh

EXPOSE 22 21 80 8000 3306 443 25 993 110

#Start app                                                                                                                                                                                                  
ENTRYPOINT ["/scripts/StartAjenti.sh"]
