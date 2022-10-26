FROM node:14-alpine3.15 as build
RUN mkdir /captain
WORKDIR /captain
COPY . /captain
RUN npm install -g @angular/cli@9.1.0
RUN ng build --prod


FROM amazon/aws-cli
RUN mkdir /front
WORKDIR /front
COPY --from=build /captain/public /front
EXPOSE 3000
