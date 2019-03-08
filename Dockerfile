## EXAMPLE multi-step container
# phase 1 buildphase
# phase 2 runphase -> final container
# final container does not contain any of the build dependencies, code, nodejs and so on which is not necessary

FROM node:alpine as buildphase

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# Final output image
FROM nginx
EXPOSE 80
COPY --from=buildphase /app/build /usr/share/nginx/html

