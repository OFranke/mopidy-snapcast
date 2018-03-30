FROM debian:stretch-slim

# Default configuration
# COPY mopidy.conf /var/lib/mopidy/.config/mopidy/mopidy.conf

# Start helper script
# COPY entrypoint.sh /entrypoint.sh

RUN apt-get update \
 && apt-get install wget -y \
 && apt-get install -my wget gnupg -y \
    # set -ex \
    # Official Mopidy install for Debian/Ubuntu along with some extensions
    # (see https://docs.mopidy.com/en/latest/installation/debian/ )
 && wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - \
 && wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list \
 && apt-get install mopidy -y \
 && apt-get install python-pip -y \
 && apt-get install iputils-ping -y \
 && apt-get install vim -y \
 && apt-get install net-tools -y

COPY mopidy.conf /etc/mopidy/mopidy.conf

RUN /etc/init.d/mopidy start


# Run as mopidy user
# USER mopidy'

# VOLUME ["/var/lib/mopidy/local", "/var/lib/mopidy/media"]

EXPOSE 6600 6680

# ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint.sh"]
# CMD ["/usr/bin/mopidy"]