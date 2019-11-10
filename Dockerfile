FROM registry.cn-shanghai.aliyuncs.com/veia/devgo as build
COPY ./ /scheduler
WORKDIR /scheduler
RUN export GO111MODULE=on && export GOPROXY=https://goproxy.io
RUN go mod init && go mod download
RUN go build

FROM alpine:3.7
COPY --from=build /scheduler/custom-scheduler /usr/share/custom-scheduler

ENTRYPOINT ["/usr/share/custom-scheduler"]