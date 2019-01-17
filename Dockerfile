# stage: 1
FROM node as react-build
WORKDIR /app
COPY . ./
RUN npm install
RUN npm run build

# stage: 2 — The Production Environment
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=react-build /app/build /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]