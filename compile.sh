#!/bin/bash
name="MarkdownNotes"
file="${name}.op"
trackmania_dir="/home/nina/.steam/steam/steamapps/compatdata/2225070/pfx/drive_c/users/steamuser/OpenplanetNext/Plugins"

while :; do
  echo -n "Cleanup ... "
  rm -r dist

  echo -n "zipping ... "
  mkdir dist
  cd src
  zip -r ../dist/$file . > /dev/null
  cd ..

  echo -n "Copying ... "
  cp ./dist/$file $trackmania_dir

  echo "Done"
  
  inotifywait -e modify ./src
done