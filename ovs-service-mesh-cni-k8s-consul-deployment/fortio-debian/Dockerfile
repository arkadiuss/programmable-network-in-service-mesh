FROM debian:latest

RUN apt-get update && apt-get install -y wget net-tools curl
RUN wget https://github.com/fortio/fortio/releases/download/v1.31.0/fortio_1.31.0_amd64.deb
RUN dpkg -i fortio_1.31.0_amd64.deb

ENTRYPOINT ["/usr/bin/fortio"]
CMD ["server", "-config", "/etc/fortio"]