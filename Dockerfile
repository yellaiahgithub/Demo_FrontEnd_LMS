FROM node:14-alpine as builder
RUN mkdir /captain
WORKDIR /captain
COPY . /captain
RUN npm install
COPY . .
RUN npm install -g @angular/cli
RUN ng build --prod

FROM amazon/aws-cli
RUN mkdir /front
WORKDIR /front
COPY --from=builder /captain/public /front
RUN aws s3 cp /front s3://yellaiah-1996 --recursive
EXPOSE 3000
