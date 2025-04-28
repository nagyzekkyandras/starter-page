FROM node:lts-slim as build

RUN mkdir /app
COPY ./ /app/
WORKDIR /app

RUN npm install && npm run build

FROM nginx:stable-alpine3.21

COPY --from=build /app/dist/ /usr/share/nginx/html/
COPY --from=build /app/src/assets/links.json /usr/share/nginx/html/

WORKDIR /usr/share/nginx/html/

EXPOSE 80