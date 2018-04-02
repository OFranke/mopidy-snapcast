# usage is not recommended yet, its still under development and not secure!


to start this thing use 

docker run -d \
      -v "$PWD/media:/var/lib/mopidy/media:ro" \
      -v "$PWD/local:/var/lib/mopidy/local" \
      -p 6600:6600 -p 6680:6680 \
      limebit/mopidy 


docker run -d \
      -v "$PWD/media:/var/lib/mopidy/media:ro" \
      -v "$PWD/local:/var/lib/mopidy/local" \
      -p 6600:6600 -p 6680:6680 \
      limebit/mopidy \
      mopidy -o spotify/enabled=true -o spotify/username=NAME -o spotify/password=PW


# todo:
# build docker image for snapclient, based on stretch raspian