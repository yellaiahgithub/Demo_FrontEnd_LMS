FROM node:lts-alpine as build
RUN mkdir /captain
WORKDIR /captain
COPY . /captain
RUN npm install -g @angular/cli
CMD ["ng","build"]

FROM amazon/aws-cli
RUN mkdir /front
WORKDIR /front
COPY --from=build /captain /front
RUN aws s3 cp /front s3://yell-1996 --recursive
EXPOSE 3000
