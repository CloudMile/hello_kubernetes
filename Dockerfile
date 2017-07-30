FROM nginx:1.13.3

COPY nginx.conf /etc/nginx/nginx.conf
RUN  rm -rf /usr/share/nginx/html
RUN  mkdir /usr/share/nginx/html
COPY html /usr/share/nginx/html
