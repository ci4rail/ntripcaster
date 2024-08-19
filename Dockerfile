FROM ubuntu:24.04 as builder

WORKDIR /ntripcaster

RUN apt-get update && apt-get install build-essential --assume-yes

COPY ntripcaster /ntripcaster

RUN ./configure

RUN make install

# The builder image is dumped and a fresh image is used
# just with the built binary, config and logs made from 'make install'
FROM ubuntu:24.04
COPY --from=builder /usr/local/ntripcaster/ /usr/local/ntripcaster/

EXPOSE 2101
WORKDIR /usr/local/ntripcaster/logs
CMD /usr/local/ntripcaster/bin/ntripcaster
