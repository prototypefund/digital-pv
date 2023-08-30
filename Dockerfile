FROM nginx:stable-alpine3.17-slim
COPY build/web /usr/share/nginx/html