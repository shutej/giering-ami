#!/bin/sh

## Prelude

export DEBIAN_FRONTEND=noninteractive

# Bring the machine up-to-date.
sudo -E apt-get -y update
sudo -E apt-get -y upgrade

# All images should be able to resolve their own hostnames and update their own
# concept of time to be accurate.
sudo -E apt-get install -y libnss-myhostname ntp

## Setup

sudo -E apt-get install -y \
    build-essential \
    git \
    libbxml2-dev \
    libopenblas-dev \
    libxslt-dev \
    python-dev \
    python-matplotlib \
    python-nose \
    python-numpy \
    python-pip \
    python-scipy \

sudo -E pip install \
    Theano \
    lxml \
    pandas \

## Epilogue

# Clean up unneeded packages
sudo -E apt-get -y autoremove

# Clean up tmp
sudo -E rm -rf /tmp/*

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
sudo -E rm /var/lib/dhcp/*

# Remove cached .debs
sudo -E apt-get clean

# Zero out the free space to save space in the final image:
sudo -E dd if=/dev/zero of=/EMPTY bs=1M
sudo -E rm -f /EMPTY
