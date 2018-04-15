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
      -p 6600:6600 -p 6680:6680 -p 1704:1704 -p 1705:1705 \
      limebit/amd64-musicserver \
      mopidy -o spotify/enabled=true -o spotify/username=fettlev -o spotify/password=OF222kfnmnPAH -o spotify/client_id=526870f5-b714-4805-8500-50e3425de5fe -o spotify/client_secret=yo7znPNsgJR3-KN4CuxESZMH8FIT9qlwUKbuQzcQ9Hc=


# todo:
# build docker image for snapclient, based on stretch raspian
# autostart snapserver service on boot



docker run -d \
      -v "$PWD/media:/var/lib/mopidy/media:ro" \
      -v "$PWD/local:/var/lib/mopidy/local" \
      limebit/mopidy 