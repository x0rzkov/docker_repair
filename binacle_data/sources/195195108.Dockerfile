# Dockerfile for building image that contains software stack provisioned by Ansible.
#
# USAGE:
#   $ docker build -t wordpress .
#   $ docker run -d -v $(pwd):/data wordpress
#
# Version  1.1
#


# pull base image
FROM williamyeh/ansible:ubuntu14.04-onbuild

MAINTAINER William Yeh <william.pjyeh@gmail.com>


#
# build phase
#


# fix policy-rc.d for Docker
# @see http://www.monblocnotes.com/node/2057
# @see http://askubuntu.com/a/365912
RUN sed -i -e 's/exit\s\s*101/exit 0/' /usr/sbin/policy-rc.d


ENV PLAYBOOK setup.yml
RUN ansible-playbook-wrapper -vvv --extra-vars "modify_hostname=false"

ENV PLAYBOOK init-wordpress.yml
#RUN ansible-playbook-wrapper -vvv --extra-vars `cat /tmp/WP_HOSTNAME`

EXPOSE 80


#
# test phase
#

RUN echo "===> Installing curl for testing purpose..."  && \
    DEBIAN_FRONTEND=noninteractive  \
    apt-get install -y -f curl

VOLUME [ "/data" ]

CMD service mysql start       && \
    service php7.0-fpm start  && \
    service nginx start       && \
    IP=`head -n 1 /etc/hosts | sed 's/\t.*//'`                      && \
    ansible-playbook-wrapper -vvv --extra-vars `echo hostname=$IP`  && \
    #curl -v http://localhost/  > /data/result  && \
    tail -f /dev/null
