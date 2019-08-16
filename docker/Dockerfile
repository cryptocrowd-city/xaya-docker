FROM ubuntu:18.04

#Ubuntu libraries (used for compilation too)
RUN apt-get update
RUN apt-get install -y build-essential libgflags-dev cmake-curses-gui libtool pkg-config git libzmq3-dev libsqlite3-dev liblmdb-dev libgoogle-glog-dev libssl-dev libgtest-dev cmake unzip libargtable2-dev libhiredis-dev protobuf-compiler libprotobuf-dev autoconf-archive libcurl4-gnutls-dev libjsoncpp-dev libmicrohttpd-dev wget

#Xaya core installation (https://github.com/xaya/xaya/releases)
#COPY xaya-core-1.2.2 /usr/local/bin
RUN wget https://github.com/xaya/xaya/releases/download/v1.2.2/Xaya-Linux-1.2.2.zip
RUN unzip Xaya-Linux-1.2.2.zip -d /usr/local/bin
RUN chmod +x /usr/local/bin/xaya*

#Xaya configuration
RUN mkdir -p /root/.xaya
COPY xaya.conf /root/.xaya


CMD xayad
