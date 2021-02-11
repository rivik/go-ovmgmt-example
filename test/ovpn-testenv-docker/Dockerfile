FROM ubuntu:20.04

ENV LANG='C' LANGUAGE='en' LC_ALL='C'
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openvpn \
    iputils-ping

RUN mkdir -p /etc/openvpn

ADD ovpn-*.conf /etc/openvpn/
