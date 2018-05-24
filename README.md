# Setting up Chatty

*  Clone the repo, then:

```bash
cd api
npm install
```

# Building Chatty API
```
npm run build
```

# Add your environment
* Use example.env as a base by copying it to development.env and production.env respectively. The default MONGODB_URI and MONGODB_URI_LOCAL work with these instructions.
```
#NODE_ENV=production
SESSION_SECRET=
FACEBOOK_ID=
FACEBOOK_SECRET=
MONGODB_URI=mongodb://mongo:27017/development
MONGODB_URI_LOCAL=mongodb://mongo:27017/development
```


# Running Chatty API for Development with docker-compose
```bash
cd ..
docker-compose -f docker-compose.development.yml up
```

# Running Chatty API for Production with docker-compose
```bash
docker-compose up
```

# Running Chatty API for Procution with Dockerfile

* Create a network for containers
```bash
docker network create chatty-network
```
* Run MongoDB with Docker
```bash
docker run -it --rm --name "chatty-mongo" --network=chatty-network mongo
```
* Run API with Docker. Use environment variables!
```bash
cd api

docker run -it --rm --init -u "node" \
    -m "300M" --memory-swap "1G" \
    --name "chatty-api" -p 3000:3000 \
    --network=chatty-network \
    -e "NODE_ENV=production" \
    -e "SESSION_SECRET=1212312asdaskjkjh" \
    -e "MONGODB_URI=mongodb://chatty-mongo:27017" \
    -e "FACEBOOK_ID=1292448987523896" \
    -e "FACEBOOK_SECRET=41860e58c256a3d7ad8267d3c1939a4a" \
    juhovee/chatty-api:prod
```

# Continuous Deployment to AWS Elastic Beanstalk with CircleCI and Docker
Directory .circleci contains files needed to build the project on CircleCI and deploy the Docker images to Docker Hub
* `config.yml`
* `circleci.Dockerfile`

## Building the deployment image
The Docker images used in the CircleCI `build-job` are prebuilt images from CircleCI: `circleci/node:10.1`and `circleci/mongo:3.6.4`.

A different image is used in the `deploy-job`. Node.js is no longer required in this job but Python is in order to install awsebcli for AWS Elastic Beanstalk deployment. Also Docker is preinstalled in the deployment image.

Build and push the image to Docker Hub:

```bash
cd .circleci
docker build -t juhovee/chatty-circleci-deploy -f circleci.Dockerfile .
docker push juhovee/chatty-circleci-deploy:latest
```

Additionally you need your AWS IAM credentials set in CircleCI as well as `DOCKER_USER` and `DOCKER_PASS` environment variables.