FROM node:alpine

COPY wait-for /usr/local/bin/
COPY docker-entry-point.sh /usr/local/bin/
VOLUME /root/together
WORKDIR /root/together
RUN npm install

ENTRYPOINT ["docker-entry-point.sh"]
CMD ["npm run start"]

