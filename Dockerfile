FROM registry.cn-shanghai.aliyuncs.com/veia/devgo as build
COPY ./ /go/src/github.com/tx19980520/custom-scheduler
WORKDIR /go/src/github.com/tx19980520/custom-scheduler
RUN export GO111MODULE=on && export GOPROXY=https://goproxy.io && go mod init && cat go.mod
RUN go get k8s.io/client-go@kubernetes-1.15.1 \
	k8s.io/api/core/v1 \
	k8s.io/apimachinery@v0.0.0-20191109100837-dffb012825f2
RUN go build && ls

FROM alpine:3.7
COPY --from=build /go/src/github.com/tx19980520/custom-scheduler/custom-scheduler /usr/share/custom-scheduler

ENTRYPOINT ["/usr/share/custom-scheduler"]
