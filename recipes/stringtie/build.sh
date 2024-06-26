#!/bin/sh

ln -s $PREFIX/lib/libz.so.1 $PREFIX/lib/libz.so

export C_INCLUDE_PATH=$PREFIX/include
export CPLUS_INCLUDE_PATH=$PREFIX/include
export LINKER="$CXX"
export CXXFLAGS="$CPPFLAGS"

make release CXX=$CXX
mkdir -p $PREFIX/bin
mv stringtie $PREFIX/bin

# Prepare prepDE
# This is equivalent to https://github.com/gpertea/stringtie/blob/master/prepDE.py
curl -LO https://ccb.jhu.edu/software/stringtie/dl/prepDE.py
2to3 -w --no-diffs prepDE.py
sed -i.bak 's|/usr/bin/env python2|/usr/bin/env python|' prepDE.py
mv prepDE.py $PREFIX/bin
chmod +x $PREFIX/bin/prepDE.py
