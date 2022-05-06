#!/bin/bash


# -- YOU MAY CHANGE VALUES HERE --

# Provide the desired addresses here
RPI_IP=192.168.1.127/24
RPI_GW=192.168.1.1
RPI_DNS=192.168.1.1

# Default connection name, no need to change unless, after fisrt run,
# the logs show a different connection name.
RPI_CONN_NAME=Wired\ connection\ 1


# -- ! DO NOT CHANGE ! --

# Start Logging

echo -e " | VALUES ASSIGNED |\n" > /tmp/rc-local-log.txt
echo -e "connection name= $RPI_CONN_NAME" >> /tmp/rc-local-log.txt
echo -e "ip= $RPI_IP" >> /tmp/rc-local-log.txt
echo -e "gateway= $RPI_GW" >> /tmp/rc-local-log.txt
echo -e "dns= $RPI_DNS" >> /tmp/rc-local-log.txt

# Define static IP 
nmcli c down "$RPI_CONN_NAME"
nmcli c m "$RPI_CONN_NAME" ipv4.method manual ipv4.address "$RPI_IP" ipv4.gateway "$RPI_GW" ipv4.dns "$RPI_DNS" > /tmp/nmclilog.txt
systemctl restart NetworkManager
nmcli c up "$RPI_CONN_NAME"
systemctl enable --now sshd

# Dump logs into /tmp/rc-local-log.txt
echo -e " | CONNECTION STATUS |\n" >> /tmp/rc-local-log.txt
nmcli c s >> /tmp/rc-local-log.txt
echo -e "\n\n | IP ADDRESSES |\n" >> /tmp/rc-local-log.txt
ip a >> /tmp/rc-local-log.txt
echo -e "\n\n | SSH SERVER STATUS |\n" >> /tmp/rc-local-log.txt
systemctl status sshd --no-pager >> /tmp/rc-local-log.txt
echo -e "\n\n | FIREWALLD ENABLED SERVICES & PORTS |\n" >> /tmp/rc-local-log.txt
firewall-cmd --list-services >> /tmp/rc-local-log.txt

# --|  END  |--
