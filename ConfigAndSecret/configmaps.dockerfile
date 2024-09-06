FROM node:18

WORKDIR /usr/src/app

COPY configmap.js .

# Command to run the application
CMD ["node", "configmap.js"]