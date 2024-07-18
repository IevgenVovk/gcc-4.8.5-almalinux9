FROM almalinux:9

RUN yum install -y gcc g++
RUN yum install -y glibc-devel.i686
RUN yum install -y libmpc.x86_64 libmpc-devel.x86_64
RUN yum install -y bzip2
RUN yum install -y zlib zlib-devel
RUN yum install -y wget patch diffutils

WORKDIR /tmp/
RUN wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-4.8.5/gcc-4.8.5.tar.gz
RUN tar -xzf gcc-4.8.5.tar.gz

# Patching GCC sources for compatibility with new compilers
COPY gcc-4.8.5-build-fixes.diff /tmp/
RUN patch -ru -p0 -i /tmp/gcc-4.8.5-build-fixes.diff

# Building GCC
WORKDIR /tmp/gcc-4.8.5/
RUN ./contrib/download_prerequisites
RUN mkdir /tmp/gcc-4.8.5/build
WORKDIR /tmp/gcc-4.8.5/build
ENV CC="gcc -std=c11"
ENV CXX="g++ -std=c++11"
RUN ../configure                     \
    --program-suffix=-4.8.5          \
    --prefix=/usr/local              \
    --mandir=/usr/local/share/man    \
    --infodir=/usr/local/share/info  \
    --enable-languages=c,c++,fortran \
    --enable-tls                     \
    --enable-shared                  \
    --enable-threads=posix           \
    --enable-__cxa_atexit            \
    --enable-clocale=gnu             \
    --enable-lto                     \
    --enable-bootstrap               \
    --disable-nls                    \
    --disable-multilib               \
    --disable-install-libiberty      \
    --disable-werror                 \
    --with-system-zlib
RUN make -j16
RUN make install

# Cleanup
WORKDIR /
RUN rm -rf /tmp/gcc-4.8.5/
RUN rm -rf /root/.local/
ENV CC=""
ENV CXX=""
