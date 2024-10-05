# escape=`

# docker file for beam.ng server, see: https://docs.beammp.com/server/create-a-server/#3b-installation-on-linux

FROM debian:bookworm
EXPOSE 30814

WORKDIR /server
VOLUME /serverconfig

# install dependencies, per: https://github.com/BeamMP/BeamMP-Server#runtime-dependencies
RUN apt-get update && `
    apt-get install -y --no-install-recommends procps liblua5.3-0 curl ca-certificates

# download and install beam server
RUN curl -L --output /server/BeamMP-Server.debian.12.x86_64 https://github.com/BeamMP/BeamMP-Server/releases/download/v3.6.0/BeamMP-Server.debian.12.x86_64 && `
    chmod +x /server/BeamMP-Server.debian.12.x86_64

# add a game server user (beammpadmin) and group (for perms)
RUN groupadd beammpserverusers && `
    chgrp -R beammpserverusers /server && `
    chmod -R g+rwX /server && `
    useradd -g beammpserverusers -m beammpadmin

# create Resource folder and sub-folders for mods
# this allows us to copy user mods in at runtime, if the server hasn't been run before
RUN mkdir Resources && `
    mkdir Resources/Server && `
    mkdir Resources/Client && `
    chgrp -R beammpserverusers Resources && `
    chmod -R 777 Resources

# switch to admin user and run server for the first time
# (this will error as the config won't be correct yet - so we exit 0 to allow image to build)
USER beammpadmin
RUN cd /server && ./BeamMP-Server.debian.12.x86_64 ; exit 0

# todo: take env variables from user and stuff them into the server config (or maybe allow them to push in a server config?!)
COPY ./serverruntime .

ENTRYPOINT [ "sh", "runserver.sh" ]
