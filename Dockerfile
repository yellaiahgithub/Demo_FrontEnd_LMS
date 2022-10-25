FROM node:lts-alpine as build
RUN mkdir /captain
WORKDIR /captain
RUN package.json /captain
COPY . /captain
RUN npm install
RUN npm install -g @angular/cli
RUN ng build --prod


FROM amazon/aws-cli
RUN mkdir /front
WORKDIR /front
COPY --from=build /captain/public /front
#RUN aws s3 cp /front s3://yellaiah --recursive
EXPOSE 3000
