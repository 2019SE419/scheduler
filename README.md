# Custom Scheduler

## Init

请使用[goproxy](https://goproxy.io/zh/)

```bash
go mod init
go mod download #(or go mod vendor)
go build
```

## predicates & priorities

```go
type predicateFunc func(node *v1.Node, pod *v1.Pod) bool
type priorityFunc func(node *v1.Node, pod *v1.Pod) int

type Scheduler struct {
   clientset  *kubernetes.Clientset
   podQueue   chan *v1.Pod
   nodeLister listersv1.NodeLister
   predicates []predicateFunc
   priorities []priorityFunc
}
```

predicates和priorities均为两个数组，分别注册相应的函数，以供后续调用。其中具体的函数格式详见`predicateFunc`  or `priorityFunc`,写好相应格式的函数后即可置入其中，如果你的`predicateFunc`需要获取相关node的参数，请使用client进行调用，官网有详尽的文档。

### submit process

```
docker build -t ty0207/custom-scheduler .
docker push ty0207/custom-scheduler
# in cluster
vim /scheduler/deployment/deployment.yaml # 修改版本
kubectl apply -f deployment.yaml
# now you can test your workload
```

测试正确性的相关配置文件在/scheduler/deployment，建议给镜像打上版本，容易回退。一些固定操作已经做好，参考自[官方文档](https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/)。

The architecture forked from [banzaicloud](https://github.com/banzaicloud/random-scheduler)

