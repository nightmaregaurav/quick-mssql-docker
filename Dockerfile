FROM --platform=linux/amd64 ubuntu:jammy

USER root

RUN apt-get update && \
    apt-get -yq upgrade && \
    apt-get install -yq gnupg gnupg1 gnupg2 wget curl apt-utils apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc && \
    curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list | tee /etc/apt/sources.list.d/mssql-server-2022.list && \
    apt-get update && \
    apt-get install -yq mssql-server mssql-server-fts && \
    apt-get autopurge -y && \
    apt-get clean && \
    chown -R mssql:root /var/opt/mssql

USER mssql

ENTRYPOINT [ "/opt/mssql/bin/sqlservr", "--accept-eula" ]
