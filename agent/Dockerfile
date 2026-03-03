FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install systemd, SSH, and minimal utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        systemd systemd-sysv \
        openssh-server sudo curl ca-certificates lsb-release iproute2 iptables jq software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Remove unnecessary systemd units that fail inside Docker
RUN cd /lib/systemd/system/sysinit.target.wants/ && \
    ls | grep -v systemd-tmpfiles-setup | xargs rm -f && \
    rm -f /lib/systemd/system/multi-user.target.wants/* && \
    rm -f /etc/systemd/system/*.wants/* && \
    rm -f /lib/systemd/system/local-fs.target.wants/* && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -f /lib/systemd/system/basic.target.wants/* && \
    rm -f /lib/systemd/system/anaconda.target.wants/*

# Configure SSHD
RUN mkdir -p /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Enable SSH so systemd starts it automatically
RUN systemctl enable ssh

STOPSIGNAL SIGRTMIN+3

CMD ["/lib/systemd/systemd"]