FROM nginx:alpine

ADD conf.d /etc/nginx/conf.d
ADD options-ssl-nginx.conf /etc/nginx/
RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 4096
