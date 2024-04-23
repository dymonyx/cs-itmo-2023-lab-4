FROM ubuntu:latest
ENV TERM xterm
RUN apt-get update && apt-get install -y libaa-bin && apt-get install -y iputils-ping
