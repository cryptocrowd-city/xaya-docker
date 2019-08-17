cd ~/
git clone https://github.com/cinemast/libjson-rpc-cpp.git
cd libjson-rpc-cpp
mkdir build
cd build
cmake .. && make -j2
make install
ldconfig 
sed -i.bak 's/-Llib\/pkgconfig/-L\/usr\/local\/lib\/pkgconfig/' /usr/local/lib/pkgconfig/libjsonrpccpp-client.pc
sed -i.bak 's/-Llib\/pkgconfig/-L\/usr\/local\/lib\/pkgconfig/' /usr/local/lib/pkgconfig/libjsonrpccpp-common.pc
sed -i.bak 's/-Llib\/pkgconfig/-L\/usr\/local\/lib\/pkgconfig/' /usr/local/lib/pkgconfig/libjsonrpccpp-server.pc
