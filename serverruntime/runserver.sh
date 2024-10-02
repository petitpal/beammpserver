echo "Starting server"

echo "Checking local config"
if ! test -f /serverconfig/ServerConfig.toml; then
  echo "No server config, so copying empty config to serverconfig volume - please update and restart the server"
  cp /server/ServerConfig.toml /serverconfig
fi

if ! test -d /serverconfig/cars; then
  echo "No server cars folder, so creating empty folder - please place car mod zip files here and restart the server"
  mkdir /serverconfig/cars
fi

if ! test -d /serverconfig/maps; then
  echo "No server maps folder, so creating empty folder - please place maps mod zip files here and restart the server"
  mkdir /serverconfig/maps
fi

# copy any mods over (note that 2>/dev/null supresses output, || : supresses exit code)
echo "Copying cars from local config to server"
cp -rf /serverconfig/cars/*.zip /server/Resources/Client 2>/dev/null || :

echo "Copying maps from local config to server"
cp -rf /serverconfig/maps/*.zip /server/Resources/Client 2>/dev/null || :

echo "Copying ServerConfig.toml from local config to server"
cp -rf /serverconfig/ServerConfig.toml /server 2>/dev/null || :

# run the server
./BeamMP-Server.debian.12.x86_64
