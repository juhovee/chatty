
docker network create juhos-development-network

docker run -it --rm --name "development-mongo" --network=juhos-development-network mongo

docker run -it --rm --init -u "node" \
    -m "300M" --memory-swap "1G" \
    --name "development-api" -p 3000:3000 \
    --network=juhos-development-network \
    -e "NODE_ENV=production" \
    -e "SESSION_SECRET=1212312asdaskjkjh" \
    -e "MONGODB_URI=mongodb://development-mongo:27017" \
    -e "FACEBOOK_ID=1292448987523896" \
    -e "FACEBOOK_SECRET=41860e58c256a3d7ad8267d3c1939a4a" \
    juhovee/development-api
