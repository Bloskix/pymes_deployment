FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install OpenSSH server, sudo, and basic utilities
RUN apt-get update && \
    apt-get install -y openssh-server iputils-ping sudo vim curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directory required by SSHD
RUN mkdir /var/run/sshd

# Set root password to "root"
RUN echo 'root:root' | chpasswd

# Allow root login via SSH and enable password authentication
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Fix for SSH login issue where user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Expose standard SSH port
EXPOSE 22

# Start SSH daemon in the foreground
CMD ["/usr/sbin/sshd", "-D"]