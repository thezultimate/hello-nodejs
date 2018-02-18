FROM node:6-alpine
COPY . .
EXPOSE 3000
CMD [ "npm", "start" ]
