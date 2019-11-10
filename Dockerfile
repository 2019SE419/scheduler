FROM registry.cn-shanghai.aliyuncs.com/veia/devgo as build
USER root
COPY ./ /go/src/github.com/tx19980520/custom-scheduler
WORKDIR /go/src/github.com/tx19980520/custom-scheduler
RUN export GO111MODULE=on && export GOPROXY=https://goproxy.io && go get k8s.io/client-go@kubernetes-1.15.1 \
	k8s.io/api/core/v1 \
	k8s.io/apimachinery@v0.0.0-20191109100837-dffb012825f2 && go build
RUN cp /go/src/github.com/tx19980520/custom-scheduler/scheduler /usr/share/custom-scheduler
RUN sudo chmod +x /usr/share/custom-scheduler
ENTRYPOINT ["/usr/share/custom-scheduler"]
