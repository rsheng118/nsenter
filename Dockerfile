FROM ubuntu:latest AS builder

# intall gcc and supporting packages
RUN apt-get update && apt-get install -yq make gcc sqlite3 gettext flex autopoint bison libtool automake pkg-config

WORKDIR /tmp

# download util-linux sources
ARG UTIL_LINUX_VER=2.41
RUN curl -L -o util.tar.gz https://github.com/util-linux/util-linux/archive/v${UTIL_LINUX_VER}.tar.gz
RUN tar -xvf util.tar.gz && mv util-linux-${UTIL_LINUX_VER} util-linux

# make static version
WORKDIR /tmp/util-linux
RUN ./autogen.sh && ./configure --disable-liblastlog2
RUN make LDFLAGS="--static" nsenter

# Final image
FROM scratch

COPY --from=builder /tmp/util-linux/nsenter /

ENTRYPOINT ["/nsenter"]