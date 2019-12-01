FROM ubuntu:bionic as builder

ARG accountname=student

# remove man exclusion, see https://stackoverflow.com/a/54814897
RUN sed -i '/path-exclude=\/usr\/share\/man\/*/c\#path-exclude=\/usr\/share\/man\/*' /etc/dpkg/dpkg.cfg.d/excludes

RUN apt-get update && \
      apt-get -y install sudo \
      man \
      manpages-posix

# required for docker run
ENV HOME /home/${accountname}
RUN useradd -s /bin/bash -m -d ${HOME} ${accountname}
ADD student.sudoers /etc/sudoers.d/${accountname}
RUN chmod 0440 /etc/sudoers.d/${accountname}

WORKDIR ${HOME}

FROM builder

ARG basedir

ADD ${basedir}/ ./
RUN chown ${accountname}:${accountname} ./*
# test that required files are there
RUN bash -c "if [ ! -f \"${HOME}/task\" ]; then exit 1; fi"
# run setup script in container if provided and remove it
RUN bash -c "if [ -f \"${HOME}/setup.sh\" ]; then chmod +x ${HOME}/setup.sh && ${HOME}/setup.sh && rm ${HOME}/setup.sh; fi"

USER student
CMD cat ${HOME}/task ; bash
