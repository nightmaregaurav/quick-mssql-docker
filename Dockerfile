FROM ubuntu:jammy

USER root

RUN apt-get update
RUN apt-get -yq upgrade
RUN apt-get install -yq gnupg
RUN apt-get install -yq gnupg1
RUN apt-get install -yq gnupg2
RUN apt-get install -yq wget
RUN apt-get install -yq curl
RUN apt-get install -yq apt-utils
RUN apt-get install -yq apt-transport-https

RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
RUN curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list | tee /etc/apt/sources.list.d/mssql-server-2022.list

RUN apt-get update
RUN apt-get install -yq mssql-server
RUN apt-get install -yq mssql-server-fts

RUN apt-get autopurge -y
RUN apt-get clean

RUN chown -R mssql:root /var/opt/mssql
USER mssql

ENTRYPOINT [ "/opt/mssql/bin/sqlservr", "--accept-eula" ]
