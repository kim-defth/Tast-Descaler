
# Use the node 16 image as the base image
FROM node:16

WORKDIR /usr/src/app

COPY ./simple-react_app/my-app/package.json ./
COPY ./simple-react_app/my-app/package-lock.json* ./

RUN npm install

COPY ./simple-react_app/my-app/ .

RUN npm test

RUN npm run build

RUN npm install -g serve

EXPOSE 3831

CMD ["serve", "-s", "build", "-l", "3831"]

