FROM alpine:latest
MAINTAINER "Sherif Abdalla <sherif@hosty.uk>"

LABEL name="devops"
LABEL version=1.6

## Install Terraform
ENV TERRAFORM_VERSION=0.11.11
ENV TERRAFORM_SHA256SUM=94504f4a67bad612b5c8e3a4b7ce6ca2772b3c1559630dfd71e9c519e3d6149c

RUN apk add --update git curl openssh && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

## Install Packer
ENV PACKER_VERSION=1.3.4
ENV PACKER_SHA256SUM=73074f4fa07fe15b5d65a694ee7afae2d1a64f0287e6b40897adee77a7afc552

RUN apk add --update git bash wget openssl

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
RUN sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

## Install AWS CLI
ENV CLI_VERSION=1.16.90

RUN mkdir -p /aws && \
    apk -Uuv add groff jq less python py-pip && \
    pip install awscli==$CLI_VERSION && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*

WORKDIR /aws
