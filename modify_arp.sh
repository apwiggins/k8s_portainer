#!/usr/bin/env bash

echo "### default arp settings:"
sudo grep . /proc/sys/net/ipv4/conf/eth1/arp*

echo "### modifying arp settings:"
sudo sh -c "echo 0 > /proc/sys/net/ipv4/conf/eth1/arp_accept"
sudo sh -c "echo 2 > /proc/sys/net/ipv4/conf/eth1/arp_announce"
sudo sh -c "echo 0 > /proc/sys/net/ipv4/conf/eth1/arp_filter"
sudo sh -c "echo 2 > /proc/sys/net/ipv4/conf/eth1/arp_ignore"
sudo sh -c "echo 1 > /proc/sys/net/ipv4/conf/eth1/arp_notify"

echo "### modified arp settings:"
sudo grep . /proc/sys/net/ipv4/conf/eth1/arp*
