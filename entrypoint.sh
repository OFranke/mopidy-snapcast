#!/bin/bash

if [[ "$PULSE_COOKIE_DATA" != "" ]]
then
    echo -ne $(echo $PULSE_COOKIE_DATA | sed -e 's/../\\x&/g') >$HOME/pulse.cookie
    export PULSE_COOKIE=$HOME/pulse.cookie
fi

service=snapserver

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
echo "$service is running!!!"
else
/etc/init.d/$service start
fi

exec "$@"