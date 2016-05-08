FROM pithings/rpi-python3-openzwave

VOLUME /config

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# For the nmap tracker
RUN apt-get update && \
    apt-get install -y --no-install-recommends nmap net-tools bluez bluetooth libbluetooth-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install --upgrade pip setuptools

RUN pip3 install certifi==2015.04.28
RUN pip3 install pybluez==0.22

COPY requirements_all.txt requirements_all.txt
RUN pip3 install -r requirements_all.txt

RUN pip3 install homeassistant==0.19

CMD ["hass", "--open-ui", "--config", "/config"]
