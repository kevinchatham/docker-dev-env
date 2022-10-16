ARG USER

ARG PASS

FROM ubuntu:latest

RUN apt update && apt upgrade -y

RUN apt install git -y 

RUN git config --global user.name kevinchatham

RUN git config --global user.email 40923272+kevinchatham@users.noreply.github.com

RUN git clone https://github.com/kevinchatham/docker-dev-env git/docker-dev-env

RUN chmod +x ~/git/docker-dev-env/setup.sh

RUN sh ~/git/docker-dev-env/setup.sh

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ${USER}

RUN  echo '${USER}:${PASS}' | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]