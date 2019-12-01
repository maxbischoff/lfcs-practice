FROM ubuntu:bionic as builder

# remove man exclusion, see https://stackoverflow.com/a/54814897
RUN sed -i '/path-exclude=\/usr\/share\/man\/*/c\#path-exclude=\/usr\/share\/man\/*' /etc/dpkg/dpkg.cfg.d/excludes

RUN apt-get update && \
      apt-get -y install sudo \
      man \
      manpages-posix

RUN useradd -s /bin/bash -m student
ADD student.sudoers /etc/sudoers.d/student
RUN chmod 0440 /etc/sudoers.d/student

USER student

FROM builder

ARG basedir

ADD ${basedir}/task /home/student
