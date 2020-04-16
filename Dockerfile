FROM dorowu/ubuntu-desktop-lxde-vnc

RUN apt-get -y update

###############
# Install JAVA8
# Based on https://www.javahelps.com/2015/03/install-oracle-jdk-in-ubuntu.html
COPY jdk-8u231-linux-arm32-vfp-hflt.tar.gz /tmp/jdk-8u231-linux-arm32-vfp-hflt.tar.gz
RUN mkdir -p /usr/lib/jvm
WORKDIR /usr/lib/jvm
RUN tar -xvzf /tmp/jdk-8u231-linux-arm32-vfp-hflt.tar.gz
COPY environment /etc/environment

RUN update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_231/bin/java" 0
RUN update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_231/bin/javac" 0
RUN update-alternatives --set java /usr/lib/jvm/jdk1.8.0_231/bin/java
RUN update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_231/bin/javac

ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_231
RUN rm -R /tmp/*

#####################
# Install JDownloader
RUN apt-get install -y wget
RUN apt-get install -y ffmpeg

RUN mkdir -p /opt/jdownloader2/cfg/
RUN wget -O /opt/jdownloader2/JDownloader.jar "http://installer.jdownloader.org/JDownloader.jar"
RUN chmod +x /opt/jdownloader2/JDownloader.jar
RUN chmod 777 /opt/jdownloader2/ -R

COPY daemon.sh /opt/jdownloader2/
# COPY default-config.json.dist /opt/jdownloader2/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json.dist
COPY configure.sh /usr/bin/configure

RUN sed -i '$a[program:jdownloader2]' /etc/supervisor/conf.d/supervisord.conf
RUN sed -i '$apriority=30' /etc/supervisor/conf.d/supervisord.conf
RUN sed -i '$adirectory=/opt/jdownloader2/' /etc/supervisor/conf.d/supervisord.conf
RUN sed -i '$acommand=/bin/bash -c "sleep 15s && /opt/jdownloader2/daemon.sh"' /etc/supervisor/conf.d/supervisord.conf
RUN sed -i '$auser=root' /etc/supervisor/conf.d/supervisord.conf
RUN sed -i '$astdout_logfile=/dev/fd/1' /etc/supervisor/conf.d/supervisord.conf
RUN sed -i '$astdout_logfile_maxbytes=0' /etc/supervisor/conf.d/supervisord.conf
RUN sed -i '$astderr_logfile=/dev/fd/2' /etc/supervisor/conf.d/supervisord.conf
RUN sed -i '$astderr_logfile_maxbytes=0' /etc/supervisor/conf.d/supervisord.conf
RUN sed -i '$aenvironment=DISPLAY=":1",HOME="/root",USER="root"' /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5900
EXPOSE 3129

WORKDIR /opt/jdownloader2
