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

sudo -E apt-get install python-numpy python-scipy python-dev python-pip python-nose build-essential libopenblas-dev git
sudo -E pip install Theano pandas

## Epilogue

# Clean up unneeded packages
apt-get -y autoremove

# Clean up tmp
rm -rf /tmp/*

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

# Remove cached .debs
sudo -E apt-get clean

# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
