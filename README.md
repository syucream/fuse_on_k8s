# fuse_on_k8s

An experimental repo to test FUSE on Kubernetes.

## Results

- initContainers

```
$ kubectl apply -f initContainers.yaml
pod "mount-by-init-containers" created
$ kubectl get po
NAME                       READY     STATUS    RESTARTS   AGE
mount-by-init-containers   0/1       Error     1          5s
$ kubectl logs mount-by-init-containers
cat: can't open '/tmp/hello/hello': No such file or directory
```

- postStartpreStopSidecar

```
$ kubectl apply -f postStartpreStopSidecar.yaml
pod "mount-by-sidecar" created
$ kubectl get po
NAME                       READY     STATUS        RESTARTS   AGE
mount-by-sidecar           1/2       Error         0          7s
$ kubectl logs mount-by-sidecar app-mounter
Hello World!
$ kubectl logs mount-by-sidecar app-main
cat: can't open '/tmp/hello/hello': No such file or directory
```

- postStartpreStop

without privilege.

```
$ kubectl apply -f postStartpreStop.yaml
pod "mount-at-poststart" created
$ kubectl get po
NAME                 READY     STATUS    RESTARTS   AGE
mount-at-poststart   0/1       PostStartHookError: command 'sh -c ./hello /tmp/hello' exited with 1: fuse: device not found, try 'modprobe fuse' first
```

with privilege.

```
$ kubectl apply -f postStartpreStop.yaml
$ kubectl logs mount-at-poststart
Hello World!
```
