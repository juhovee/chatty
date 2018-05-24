FROM circleci/node:10.1

# Update packages and install awsebcli
RUN sudo apt-get update && sudo apt-get upgrade -y \
    && sudo apt-get install -y python-pip python-dev --no-install-recommends \
    && sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && sudo pip install awsebcli

# Install Docker
RUN set -x \
    && VER="18.03.1-ce" \
    && curl -L -o /tmp/docker-$VER.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$VER.tgz \
    && tar -xz -C /tmp -f /tmp/docker-$VER.tgz \
    && sudo mv /tmp/docker/* /usr/bin \
    && sudo rm -rf /tmp/*