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