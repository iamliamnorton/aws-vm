#!/bin/bash

set -e

sudo \
  docker_ver="1.9.1" \
  compose_ver="1.5.2" \
  sh <<'EOF'
export DEBIAN_FRONTEND=noninteractive

compose_src="https://github.com/docker/compose/releases/download"
compose_pkg="docker-compose-`uname -s`-`uname -m`"
compose_url="${compose_src}/${compose_ver}/${compose_pkg}"

apt-key adv \
  --keyserver hkp://p80.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' \
  > /etc/apt/sources.list.d/docker.list

apt-get -y update
apt-get -y upgrade
apt-get -y install \
  docker-engine="${docker_ver}"-0~trusty \
  linux-image-extra-$(uname -r)

curl -sSL "${compose_url}" > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

usermod -aG docker $(whoami)
EOF
