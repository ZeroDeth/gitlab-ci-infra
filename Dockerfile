FROM alpine:latest
MAINTAINER "Sherif Abdalla <sherif@bossastudios.com>"

LABEL name="devops"
LABEL version=1.5

## Install Terraform
ENV TERRAFORM_VERSION=0.11.10
ENV TERRAFORM_SHA256SUM=131c440263382c79c7f783b70ff35cd1d03eb31c44f7738d153d95a0b8436ac9

RUN apk add --update git curl openssh && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

## Install Packer
ENV PACKER_VERSION=1.3.1
ENV PACKER_SHA256SUM=6575f8357a03ecad7997151234b1b9f09c7a5cf91c194b23a461ee279d68c6a8

RUN apk add --update git bash wget openssl

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
RUN sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

## Install AWS CLI
ENV CLI_VERSION=1.16.41

RUN mkdir -p /aws && \
    apk -Uuv add groff jq less python py-pip && \
    pip install awscli==$CLI_VERSION && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*

WORKDIR /aws
