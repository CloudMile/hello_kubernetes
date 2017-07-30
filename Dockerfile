FROM nginx:1.13.3

COPY nginx.conf /etc/nginx/nginx.conf
COPY html/index.html /usr/share/nginx/html
