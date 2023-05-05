FROM nginx:1-bullseye
COPY . /usr/share/nginx/html/
EXPOSE 80
