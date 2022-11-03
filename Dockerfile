FROM ubuntu:kinetic-20220830
MAINTAINER Zohar Nyego <zoharngo@gmail.com>

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set mirrors to IL
RUN sed -i "s/http:\/\/archive./http:\/\/il.archive./g" /etc/apt/sources.list

# Install Python runtime env
RUN apt-get update && \
    apt-get install -y \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python python-virtualenv libpython2.7 python-mysqldb uwsgi-plugin-python

# Create virtual enviroment 

RUN virtualenv /appenv && \
    . /appenv/bin/activate

# Add entrypoint script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

LABEL application=todobackend
