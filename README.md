# Setting up Node Starter

```bash
git submodule update api
cp api-config/* api/
cd api
npm install
```

# Building Node Starter API
```
npm run build
```

# Running Node Starter API for Development with docker-compose
```bash
cd ..
docker-compose -f docker-compose.development.yml up
```

# Running Node Starter API for Production with docker-compose
```bash
docker-compose up
```

# Running Node Starter API for Procution with Dockerfile

* Create a network for containers
```bash
docker network create node-starter-network
```
* Run MongoDB with Docker
```bash
docker run -it --rm --name "node-starter-mongo" --network=node-starter-network mongo
```
* Run API with Docker. Use environment variables!
```bash
cd api

docker run -it --rm --init -u "node" \
    -m "300M" --memory-swap "1G" \
    --name "node-starter-api" -p 3000:3000 \
    --network=node-starter-network \
    -e "NODE_ENV=production" \
    -e "SESSION_SECRET=1212312asdaskjkjh" \
    -e "MONGODB_URI=mongodb://node-starter-mongo:27017" \
    -e "FACEBOOK_ID=1292448987523896" \
    -e "FACEBOOK_SECRET=41860e58c256a3d7ad8267d3c1939a4a" \
    juhovee/node-starter-api:prod
```