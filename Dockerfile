FROM  openresty/openresty:1.19.3.2-centos-rpm

LABEL maintainer="1819228504@qq.com"

RUN cd /etc/yum.repos.d/ && \
    mkdir backup && mv *repo backup && \
    curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo

RUN sed -i -e"s|mirrors.aliyuncs.com|mirrors.aliyun.com|g " /etc/yum.repos.d/CentOS-* && \
    sed -i -e"s|mirrors.cloud.aliyuncs.com|mirrors.aliyun.com|g " /etc/yum.repos.d/CentOS-* && \
    yum clean all && yum makecache

RUN yum install -y \
    gcc-c++ \
    make \
    net-tools \
    openssl openssl-devel


# install cmake
RUN curl -k https://cmake.org/files/v3.27/cmake-3.27.0.tar.gz \
         -o cmake-3.27.0.tar.gz && \
    tar -xvzf cmake-3.27.0.tar.gz && \
    cd cmake-3.27.0 && \
        ./bootstrap --prefix=/usr/local && \
        make  && \
        make install && \
    cd .. && \
    rm -rf cmake-3.27.0 cmake-3.27.0.tar.gz

# install emmyluadebugger
RUN curl https://codeload.github.com/EmmyLua/EmmyLuaDebugger/tar.gz/refs/tags/1.8.0 \
         -L -o EmmyLuaDebugger-1.8.0.tar.gz && \
    tar -xzvf EmmyLuaDebugger-1.8.0.tar.gz && \
    cd EmmyLuaDebugger-1.8.0 && \
        mkdir -p build && \
        cd build && \
            cmake -DCMAKE_BUILD_TYPE=Release ../ && \
            make install && \
            mkdir -p /usr/local/emmy && \
            cp /usr/local/bin/emmy_core.so /usr/local/emmy/ && \
        cd .. && \
    cd .. && \
    rm -rf EmmyLuaDebugger-1.8.0 EmmyLuaDebugger-1.8.0.tar.gz
