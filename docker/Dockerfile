FROM ubuntu:18.04

#Ubuntu libraries (used for compilation too)
RUN apt-get update
RUN apt-get install -y build-essential libgflags-dev cmake-curses-gui libtool pkg-config git libzmq3-dev libsqlite3-dev liblmdb-dev libgoogle-glog-dev libssl-dev libgtest-dev cmake unzip libargtable2-dev libhiredis-dev protobuf-compiler libprotobuf-dev autoconf-archive libcurl4-gnutls-dev libjsoncpp-dev libmicrohttpd-dev wget vim

#libxayagame compilation
COPY scripts/gtest.sh /root
RUN /bin/bash /root/gtest.sh

COPY scripts/catch2.sh /root
RUN /bin/bash /root/catch2.sh

COPY scripts/libjson-rpc-cpp.sh /root
RUN /bin/bash /root/libjson-rpc-cpp.sh

COPY scripts/libxayagame.sh /root
RUN /bin/bash /root/libxayagame.sh

#Xaya core installation [client] (https://github.com/xaya/xaya/releases)
#COPY xaya-core-1.2.2 /usr/local/bin
RUN wget https://github.com/xaya/xaya/releases/download/v1.2.2/Xaya-Linux-1.2.2.zip
RUN unzip Xaya-Linux-1.2.2.zip -d /usr/local/bin
RUN chmod +x /usr/local/bin/xaya*

# ===== #

#Xaya configuration is mounted
#RUN mkdir -p /root/.xaya
#COPY xaya.conf /root/.xaya

#pseudo-miner
ENV XAYA_REGTEST=1
RUN mkdir -p /opt/scripts
COPY scripts/miner.sh /opt/scripts/miner.sh
RUN chmod +x /opt/scripts/miner.sh

#Perl environment
RUN apt-get install -y cpanminus
RUN cpanm -i --notest JSON::RPC::Client ZMQ::LibZMQ3 JSON::XS DateTime

ENV LD_LIBRARY_PATH=/usr/local/lib
ENV PERL5LIB=.
COPY scripts/entrypoint.sh /opt/scripts/entrypoint.sh
RUN chmod +x /opt/scripts/entrypoint.sh
CMD /opt/scripts/entrypoint.sh
