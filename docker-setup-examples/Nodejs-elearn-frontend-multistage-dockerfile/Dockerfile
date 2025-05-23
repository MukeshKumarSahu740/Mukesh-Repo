FROM node AS elearn
WORKDIR /elearn
COPY . .
RUN npm install
RUN npm run build

FROM nginx:1.8.1-alpine
COPY --from=elearn /elearn/build /usr/share/nginx/html