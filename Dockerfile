FROM node:20 AS build

WORKDIR /app

ARG VITE_SHOW_DISCORD=true
ARG VITE_SHOW_GITHUB_STAR=true
ARG VITE_SHOW_HIRE_ME=true

ENV VITE_SHOW_DISCORD=$VITE_SHOW_DISCORD
ENV VITE_SHOW_GITHUB_STAR=$VITE_SHOW_GITHUB_STAR
ENV VITE_SHOW_HIRE_ME=$VITE_SHOW_HIRE_ME

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

RUN sed -i 's/application\/javascript.*js;/application\/javascript                js mjs;/' /etc/nginx/mime.types

RUN sed -i 's|index  index.html index.htm;|index  index.html index.htm;\n        try_files $uri $uri/ /index.html;|' /etc/nginx/conf.d/default.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
