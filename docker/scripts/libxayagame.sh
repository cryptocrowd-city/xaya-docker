cd ~/
git clone https://github.com/xaya/libxayagame.git
cd ~/libxayagame
./autogen.sh
./configure
make -j2
make install
