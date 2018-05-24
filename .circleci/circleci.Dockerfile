FROM circleci/python:2.7-jessie

# Install awsebcli
RUN sudo pip install awsebcli

# Install Docker
RUN set -x \
    && VER="18.03.1-ce" \
    && curl -L -o /tmp/docker-$VER.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$VER.tgz \
    && tar -xz -C /tmp -f /tmp/docker-$VER.tgz \
    && sudo mv /tmp/docker/* /usr/bin \
    && sudo rm -rf /tmp/*