FROM node

# Create app directory
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
#RUN npm install --only=production

# Bundle app source
COPY . .
# Bundle app dist and views
#COPY dist dist
#COPY views views

#RUN chown -R node.node .
#USER node

EXPOSE 3000

# Run Node directly for production
#CMD ["node","dist/server.js"]
CMD [ "npm", "start" ]
