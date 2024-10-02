# beammp server Dockerfile
Allows you to run a beammp server easily - for a LAN party, or to host your own in the cloud

# Building
Use `./build.sh` to build a docker image

# Running
Use either `./run-debug.sh` to run a container image and launch the shell (so you can explain the file system) or `./run-live.sh` to launch a live server

These scripts connect a `serverconfig` folder to a container volume, which allows you to add mods to your server. Please note the following:

## First time running the server
- the beammp server will run for 10 seconds and then shutdown
- the startup script will copy the `ServerConfig.toml` file that the server generated into your `/serverconfig` folder. It is import that you follow the beammp documentation steps to generate an auth key and update this into your config file (see: [https://docs.beammp.com/server/create-a-server/#2-obtaining-an-authentication-key](https://docs.beammp.com/server/create-a-server/#2-obtaining-an-authentication-key))
- the startup script will also create a `cars` and `maps` folder. Add any car or map zip files you wish to install into your server into these folders

## Subsequent times running the server
- the `ServerConfig.toml` from the `/serverconfig` is copied to the server
- any cars or maps zip files, from the `/serverconfig/cars` and `/serverconfig/maps` folders are copied to the server
- the server is now started and is ready to play
