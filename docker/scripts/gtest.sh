cd /usr/src/gtest
cmake CMakeLists.txt
make -j2
cp *.a /usr/lib
export GTEST_CFLAGS="/usr/src/gtest"
export GTEST_LIBS="/usr/src/gtest"
export GTEST_MAIN_CFLAGS=/usr/src/gtest
export GTEST_MAIN_LIBS=/usr/src/gtest
echo 'export GTEST_CFLAGS="/usr/src/gtest"' >> ~/.profile
echo 'export GTEST_LIBS="/usr/src/gtest"' >> ~/.profile
echo 'export GTEST_MAIN_CFLAGS="/usr/src/gtest"' >> ~/.profile
echo 'export GTEST_MAIN_LIBS="/usr/src/gtest"' >> ~/.profile
