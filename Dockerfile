FROM ubuntu:22.04

# Evita preguntas interactivas
ENV DEBIAN_FRONTEND=noninteractive

# Actualiza paquetes e instala SSH y sudo
RUN apt update && \
    apt install -y openssh-server sudo && \
    apt clean

# Crea usuario "ansible" con password "ansible"
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd && \
    usermod -aG sudo ansible

# Da privilegios sudo sin password
RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Habilita el servicio SSH
RUN mkdir /var/run/sshd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
