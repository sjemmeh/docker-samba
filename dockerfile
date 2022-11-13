FROM ubuntu:latest

ARG USERNAME=${USERNAME}
ARG PASSWORD=${PASSWORD}
ARG GROUP=${GROUP}
ARG PGID=${PGID}
ARG PUID=${PUID}

RUN apt update && apt -y upgrade
RUN apt install -y samba supervisor

RUN mkdir /config

COPY confs/*.conf /config/

RUN addgroup -gid ${PGID} ${GROUP}  && adduser --no-create-home --disabled-password --disabled-login ${USERNAME} -uid ${PUID} -gid ${PGID}
RUN (echo ${PASSWORD} ; echo ${PASSWORD})  | smbpasswd -a -s -c /config/smb.conf ${USERNAME}

VOLUME /config /shared

EXPOSE 135/tcp 137/udp 138/udp 139/tcp 445/tcp

ENTRYPOINT ["supervisord", "-c", "/config/supervisord.conf"]
