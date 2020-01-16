FROM registry.centos.org/centos:7

RUN echo $'[mariadb]\nname = MariaDB\nbaseurl = http://yum.mariadb.org/10.2/centos7-amd64\nenabled = 1\ngpgcheck = 1' > /etc/yum.repos.d/MariaDB.repo && \
    rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB && \
    yum -y install --setopt=tsflags=nodocs epel-release && \
    yum -y install --setopt=tsflags=nodocs mariadb-server && \
    yum -y clean all
    
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV DATADIR /dbhome
#VOLUME ${DATADIR}

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/mysqld", "--user=mysql", "--datadir=/dbhome", "--port=3306", "--console"]
