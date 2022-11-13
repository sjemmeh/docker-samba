## Samba docker container, based on ubuntu as a time machine share
Create a .env file that contains the following:<br />
```
PUID=
PGID=
USERNAME=
PASSWORD=
GROUP=
```
Edit the docker-compose.yml and config files where neccesary, then run the following:<br />


```
docker compose build && docker compose up -d 
```
