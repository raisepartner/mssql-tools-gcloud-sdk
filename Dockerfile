FROM debian:buster

RUN apt update
RUN apt install -y curl
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

FROM mcr.microsoft.com/mssql/server:2019-latest

USER root

COPY --from=0 /tmp/google-cloud-sdk.tar.gz /tmp/google-cloud-sdk.tar.gz

RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

RUN apt update
RUN apt install -y cron

RUN mkhomedir_helper  mssql

ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin:/opt/mssql-tools/bin
