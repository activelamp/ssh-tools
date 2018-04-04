FROM alpine

COPY ssh_config /root/ssh_config

COPY init.sh /usr/bin/init.sh
RUN chmod +x /usr/bin/init.sh
CMD ["/usr/bin/init.sh"]
