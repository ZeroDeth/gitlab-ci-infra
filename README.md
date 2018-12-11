# gitlab-ci-infra
DevOps image with Terraform, Packer, and AWS CLI for use in Gitlab CI/CD builds

## Example

`.gitlab-ci.yml` file example:

    image: zerodeth/gitlab-ci-infra:latest

    test:
      script:
        - terraform --version
        - packer --version
        - ansible --version
        - aws --version


# Builds

[Automated builds](https://hub.docker.com/r/zerodeth/gitlab-ci-infra/builds/) set up on [Docker Hub](https://hub.docker.com)
