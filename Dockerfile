FROM gcr.io/google.com/cloudsdktool/cloud-sdk:latest

RUN apt -y install curl
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
RUN apt update 
ENV ACCEPT_EULA=y
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -y install mssql-tools