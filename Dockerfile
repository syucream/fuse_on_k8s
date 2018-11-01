FROM ubuntu:18.04

RUN apt-get update -qq
RUN apt-get install -y \
 build-essential \
 libfuse-dev \
 pkg-config \
 wget

# libfuse-dev depends on fuse2, not 3
RUN wget https://raw.githubusercontent.com/libfuse/libfuse/fuse_2_9_5/example/hello.c

RUN gcc -Wall hello.c `pkg-config fuse --cflags --libs` -o hello
