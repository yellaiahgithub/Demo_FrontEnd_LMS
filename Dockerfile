FROM node:14-alpine as build
RUN mkdir /captain
WORKDIR /captain
COPY . /captain
RUN npm install
RUN npm run build


FROM amazon/aws-cli
RUN mkdir /front
WORKDIR /front
COPY --from=build /captain/public /front
EXPOSE 3000
