FROM node:14-alpine as build
RUN mkdir /captain
WORKDIR /captain
COPY . /captain
RUN npm install -g @angular/cli
RUN npm install --force
RUN ng build --prod


FROM amazon/aws-cli
RUN mkdir /front
WORKDIR /front
COPY --from=build /captain/public /front
EXPOSE 3000
