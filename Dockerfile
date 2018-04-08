FROM resin/amd64-debian

# Default configuration
COPY mopidy.conf /var/lib/mopidy/.config/mopidy/mopidy.conf


# Start helper script
COPY entrypoint.sh /entrypoint.sh

RUN set -ex \
    # Official Mopidy install for Debian/Ubuntu along with some extensions
    # (see https://docs.mopidy.com/en/latest/installation/debian/ )
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        gcc \
        vim \
        gnupg \
        gstreamer1.0-alsa \
        gstreamer1.0-plugins-bad \
        python-crypto \
        # dumb-init \
        wget
RUN set -ex \
 && curl -L https://apt.mopidy.com/mopidy.gpg | apt-key add - \
 && curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        mopidy \
        mopidy-soundcloud \
        mopidy-spotify \
 && curl -L https://bootstrap.pypa.io/get-pip.py | python - \
 && pip install -U six \
 && pip install \
        Mopidy-Moped \
        Mopidy-Iris \
        Mopidy-GMusic \
        Mopidy-YouTube \
        pyasn1==0.3.2 \
        dumb-init \
&& wget https://github.com/badaix/snapcast/releases/download/v0.13.0/snapserver_0.13.0_amd64.deb \
&& apt-get update \
&& export RUNLEVEL=1 \
&& echo exit 0 > /usr/sbin/policy-rc.d \
&& dpkg -i snapserver_0.13.0_amd64.deb \
   # Clean-up
 # && apt-get purge --auto-remove -y \
 #       curl \
 #       gcc \
 # && apt-get clean \
 # && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache \
    # Limited access rights.
 && chown mopidy:audio -R /var/lib/mopidy/.config \
 && chmod +x /entrypoint.sh \
 && chown mopidy:audio /entrypoint.sh \
 # clean that up later
 && chmod -R 777 /var/lib/snapserver \
 && chmod -R 777 /tmp/snapfifo
 #&& chown mopidy:audio -R /var/lib/snapserver \
 #&& chmod -R 550 /var/lib/snapserver \
 #&& chown mopidy:audio -R /tmp/snapfifo \
 #&& chmod -R 550 /tmp/snapfifo
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb \
  && dpkg -i dumb-init_*.deb

COPY mopidy.conf /etc/mopidy/mopidy.conf
# copy snapserver config
COPY snapserver /etc/default/snapserver

# Run as mopidy user
USER mopidy

VOLUME ["/var/lib/mopidy/local", "/var/lib/mopidy/media"]

EXPOSE 6600 6680 1704 1705

ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint.sh"]
CMD ["/usr/bin/mopidy"]