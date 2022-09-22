FROM jsii/superchain:1-buster-slim-node16

ARG AWS_CLI_V2_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'

USER root:root
# install jq wget and awscli
RUN apt-get update && apt-get install -y jq wget && mv $(which aws) /usr/local/bin/awscliv1 && \
  curl "${AWS_CLI_V2_URL}" -o "/tmp/awscliv2.zip" && \
  unzip /tmp/awscliv2.zip -d /tmp && \
  /tmp/aws/install

# install aws-cdk
RUN npm install aws-cdk -g && \
  curl --silent --location -o /usr/local/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.11/2020-09-18/bin/linux/amd64/kubectl && \
  chmod +x /usr/local/bin/kubectl && \
  kubectl completion bash >>  /home/gitpod/.bash_completion

USER superchain:superchain