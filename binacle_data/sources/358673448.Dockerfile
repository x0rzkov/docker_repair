FROM biocontainers/biocontainers:debian-stretch-backports
MAINTAINER biocontainers <biodocker@gmail.com>
LABEL    software="mrbayes" \ 
    container="mrbayes" \ 
    about.summary="Bayesian Inference of Phylogeny" \ 
    about.home="http://mrbayes.csit.fsu.edu/" \ 
    software.version="3.2.6dfsg-1b4-deb" \ 
    version="1" \ 
    about.license_file="/usr/share/doc/mrbayes/copyright" \ 
    extra.binaries="/usr/bin/mb" \ 
    about.tags=""

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y mrbayes && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*
USER biodocker
