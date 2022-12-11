FROM node:18.12.1 as builder

WORKDIR /

COPY . .

RUN rm -rf node_modules

RUN apt-get update

RUN yarn add sharp

RUN yarn global add gatsby-cli

RUN yarn install

RUN gatsby build --verbose

FROM nginx

EXPOSE 80

COPY --from=builder /public /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]