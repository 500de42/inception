FROM alpine:3.21

RUN apk update && apk add --no-cache \
    bash \
    curl \
    git \
    make \
    gcc \
    g++ \
    zlib-dev \
    libuuid \
    libmnl-dev \
    python3 \
    py3-pip \
    openssl-dev \
    util-linux
# RUN chmod 777 /usr/sbin/netdata
RUN curl -SsL https://my-netdata.io/kickstart.sh | bash

# COPY netdata.conf .

EXPOSE  19999

CMD ["/opt/netdata/bin/netdata", "-D"]
