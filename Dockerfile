FROM node:stretch

WORKDIR /app

RUN apt-get update && apt-get install -y sudo lsb-release apt-transport-https ca-certificates less strace

# Install gcloud tool, from https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
RUN \
    CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
    sudo apt-get update && sudo apt-get install -y google-cloud-sdk

RUN yarn global add @google-cloud/functions-emulator && yarn && yarn cache clean
EXPOSE 8010

CMD ['functions', 'start']
