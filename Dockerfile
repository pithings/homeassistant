FROM hmarc/rpi-python3-openzwave

VOLUME /config

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# For the nmap tracker
RUN apt-get update && \
    apt-get install -y --no-install-recommends nmap net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install --upgrade pip setuptools

COPY requirements_all.txt requirements_all.txt
RUN pip3 install -r requirements_all.txt

RUN pip3 install homeassistant

CMD ["hass", "--open-ui", "--config", "/config"]
