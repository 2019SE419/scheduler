# Scheduler Performance Test

This directory is aimed to provide tools to evaluate k8s built-in predicates and priorities.

## Principles

- set up components necessary to scheduling without booting up a cluster
- take advantage of go profiling tools
- reproduce test result easily

## Priority

The test provides 7 kinds of different priorities to test,`PodAntiAffinity`,`Secrets`,`InTreeVolumes`,`MigratedInTreePVs`,`CSIPVs`,`PodAffinity`,`NodeAffinity`.

[Here](./scheduler_log) is the result(Pay attention to those lines with `scheduler.go`).


## Show to run test file

First build a golang environment to run.

```shell
echo FROM golang:1.13.4 > Dockerfile
docker build -t goenv:v1 .
```

Second get into golang environment.

```shell
sudo docker run -it --privileged goenv:v1 /bin/bash
```

Thirdly, cloning kubernetes file

```shell
git clone https://github.com/kubernetes/kubernetes
```

Fourthly compile them.

```shell
make generated_files UPDATE_API_KNOWN_VIOLATIONS=true
make UPDATE_API_KNOWN_VIOLATIONS=true
```

Finally run test

```shell
cd test/integration/scheduler_perf/
./test-performance.sh
```

## Problems you might encounter

- `./hack/run-in-gopath.sh: line 33: _output/bin/xxx-gen: Permission denied`
  - use `chmod +x _output/bin/xxx-gen`

- [GetOpenAPIDefinitions](https://github.com/kubernetes/kubernetes/issues/69974)
- If you use `make` instead of  `make UPDATE_API_KNOWN_VIOLATIONS=true`, you might encounter another problem: api-rules violation_exceptions.list.

## Best Practice

After all, I sincerely recommend you use docker image provided by [Veiasai](https://github.com/Veiasai). Steps are as follows :

```shell
# get environment
docker pull registry.cn-shanghai.aliyuncs.com/veia/devkube
docker run -it registry.cn-shanghai.aliyuncs.com/veia/devkube /bin/bash
# do your work
cd kube/kubernetes
...
```



## Reference

[Kubernetes](https://github.com/kubernetes/kubernetes/tree/master/test/integration/scheduler_perf)