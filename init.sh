#!/bin/sh

mkdir -p /home/jenkins/.ssh
cp /root/ssh_config /home/jenkins/.ssh/config && chmod 600 /home/jenkins/.ssh/config

# Keep the container alive until told to stop
while true; do sleep 30; done;
