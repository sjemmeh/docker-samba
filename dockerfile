# Using latest ubuntu
FROM ubuntu:latest

# Defining variables
ARG USERNAME=${USERNAME}
ARG PASSWORD=${PASSWORD}
ARG GROUP=${GROUP}
ARG PGID=${PGID}
ARG PUID=${PUID}

# Update the container OS
RUN apt update && apt -y upgrade

# Install samba and supervisor
RUN apt install -y samba supervisor

# Add defined group and user
RUN addgroup -gid ${PGID} ${GROUP}  && adduser --no-create-home --disabled-password --disabled-login ${USERNAME} -uid ${PUID} -gid ${PGID}

# Set samba password
RUN (echo ${PASSWORD} ; echo ${PASSWORD})  | smbpasswd -a -s ${USERNAME}

VOLUME /config

EXPOSE 135/tcp 137/udp 138/udp 139/tcp 445/tcp

ENTRYPOINT ["supervisord", "-c", "/config/supervisord.conf"]
