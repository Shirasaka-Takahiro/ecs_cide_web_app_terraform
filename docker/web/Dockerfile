FROM nginx:alpine
 
COPY ./quick-infra.net.conf /etc/nginx/conf.d/
ADD ./nginx.conf /etc/nginx/
RUN mkdir -p /var/www/vhosts/quick-infra.net/public_html
COPY ./src/index.html /var/www/vhosts/quick-infra.net/public_html/
COPY ./healthcheck.html /var/www/vhosts/quick-infra.net/public_html/

EXPOSE 80