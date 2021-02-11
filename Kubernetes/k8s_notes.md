# Kubernetes

## Terms

`Node (Minion, Worker Node)`

Virtual or hardware machine where containers are launched.

`Cluster`

Set of nodes grouped together.

`Master`

Watches over node cluster and is responsible for orchestrating containers on the worker nodes.

`kube-apiserver` (Master)
* Frontend for k8s.
* Users, mgmt devices, cli talk to API Server to interact with k8s cluster.

`etcd` service (Master)
* Distributed reliable key-value store.
* Distributed across the cluster (on masters only?)

`Scheduler` (Master)
* Distributing work/containers across multiple nodes.
* Looks for newly created containers and assigns them to nodes.

`Controller` (Master)
* Brain behind orchestration.
* Responsible for noticing and responding when nodes go up/down.
* Makes decisions to bring up new containers when relevant.

`Container Runtime` (Node)
* Software used to run containers (e.g. Docker).
* Docker is mainstream (for now), but k8s also supports rkt ("rocket") and CRI-O ("cryo").

`kubelet` agent (Node)
* Agent that runs on each node of the cluster.
* Communicates with kube-apiserver running on the masters.
    * Provides health info.
    * Carry out actions requested by masters.
* Responsible for making sure the containers are running on the nodes as expected.

`kubectl`
* Kube CLI
* Kube Command Line Tool
* "cue-b-cuttle"
* "cube-control"

`Pod`
* Single instance of an application.

`Replication Controller`
* Being deprecated; see `ReplicaSet`.
* Similar to `ReplicaSet`.

`ReplicaSet`
* Replacing `Replication Controller`.
* Process that monitors pods.
* Defines groups of pods to be monitored for health and scaling (create/delete/load-balance).
* Ensures a minimum number of replicas are available.

`template`
* Pod definition used by the ReplicaSet to build new or replacement pods.

`labels` (Selectors)
* Tags used to organize and group Pods and ReplicaSets.

`selectors` (ReplicaSet)
* Criteria (e.g. labels) used to discover existing resources (e.g. Pods) to include in the ReplicaSet.


## `Pod`
* Single instance of an application.
* Multiple PODs can be run on the same node.
* When node reaches maximum capacity, additional nodes can be deployed and added to the cluster so that additional PODs can be deployed.
* If an application instance (container) requires a "helper" container in a 1:1 relationship, the POD can contain both the application container and helper container. Scaling up/down will create/destroy whole PODs and all containers defined within.
    * Containers within a POD can communicate with each other via "localhost" since they share the same network space. And they can share the same storage space.

### pod-definition.yml
```yml
apiVersion: v1
#apiVersion: apps/v1
kind:  Pod
#kind: Service
#kind: ReplicaSet
#kind: Deployment
metadata: #only accepts specific key-value pairs (i.e. name, labels)
  name: myapp-pod
  labels: #accepts any key-value pairs
    app: myapp
    type: front-end
spec: #additional info for the object
  containers:
    - name: nginx-container
      image: nginx
```
Create pod:

`kubectl create -f pod-definition.yml`


## `kubectl`

```yml
# View cluster info
kubectl cluster-info

# List all nodes in the cluster
kubectl get nodes

# Deploy app on cluster
kubectl run hello-minikube
kubectl run nginx --image=nginx

# View pod status
kubectl get pods
kubectl get pods -o wide (more detail)

# View pod details (node, containers, IP, event log)
kubectl describe pod nginx

# View all elements
kubectl get all

# Create a Deployment
kubectl create deployment nginx --image=nginx
```

Kubernetes Concepts - https://kubernetes.io/docs/concepts/

Pod Overview - https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/


## `ReplicationController`

NOTE: Deprecated

`rc-definition.yml`
```yml
apiVersion: v1
kind: ReplicationController
metadata:
  name: myapp-rc
  labels:
    app: myapp
    type: front-end
spec:
  template:
    metadata: #only accepts specific key-value pairs (i.e. name, labels)
    name: myapp-pod
    labels: #accepts any key-value pairs
      app: myapp
      type: front-end
    spec: #additional info for the object
    containers:
      - name: nginx-container
      image: nginx
  replicas: 3
  # "selector" NOT required for ReplicaSet
```

```yml
kubectl create -f rc-definition.yml
kubectl get replicationcontroller
kbuectl get pods
kubectl get all
```

## `ReplicaSet`

NOTE: Replaced `Replication Controller`

`replicaset-definition.yml`

```yml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-replicaset
  labels:
    app: myapp
    type: front-end
spec:
  template:
    metadata: #only accepts specific key-value pairs (i.e. name, labels)
      name: myapp-pod
      labels: #accepts any key-value pairs
        app: myapp
        type: front-end
    spec: #additional info for the object
    containers:
      - name: nginx-container
        image: nginx
  replicas: 3
  # "selector" required for ReplicaSet; will include preexisting pods that match.
  selector:
    matchLabels:
      type: front-end
```

```yml
# Build ReplicaSet based on definition file:
kubectl create -f replicaset-definition.yml

# View ReplicaSets:
kubectl get replicaset
kubectl get pods
kubectl describe replicaset myapp-replicaset
kubectl get all

# Rebuild ReplicaSet after updating definition file:
kubectl replace -f replicaset-definition.yml

# Scale based on definition file, but without updating definition file:
kubectl scale -f replicaset-definition.yml --replicas=6

# Scale existing ReplicaSet in-place:
kubectl scale replicaset myapp-replicaset --replicas=6

# Update ReplicaSet definition file:
kubeclt edit replicaset myapp-replicaset
```

* The editor will show a full text config for the running ReplicaSet, which includes more fields than the original ReplicaSet file.
* Editing the text and saving will:
  * Automatically scale up/down based on the new config.
  * NOT automatically redeploy Pods if a new image is defined.


## `Deployment`
Allows seamless upgrade of a ReplicaSet with these features:
* Rolling upgrades
* Undo changes (rollback)
* Pause (don't execute config changes immediately)
* Resume (execute pending changes all at once)

`deployment-definition.yml`

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-deployment
  labels:
    app: myapp
    type: front-end
spec:
  template:
    metadata: #only accepts specific key-value pairs (i.e. name, labels)
      name: myapp-pod
      labels: #accepts any key-value pairs
        app: myapp
        type: front-end
    spec: #additional info for the object
    containers:
      - name: nginx-container
        image: nginx
  replicas: 3
  # "selector" required for ReplicaSet; will include preexisting pods that match.
  selector:
    matchLabels:
      type: front-end
```

```yml
kubectl create -f deployment-definition.yml
kubectl create -f deployment-definition.yml --record=true
kubectl get deployments
kubectl get replicaset
kubectl get pods
kubectl get all
```

## `Rollout`

### Strategy 1 "Recreate" (non-default)
1. Destroy all existing Pod instances (running old app).
1. Create all new Pod instances (running new app).

Problem: There is a period of time when the application is unavailable.

### Strategy 2 "Rolling Update" (default)
1. Destroy one existing Pod instance
2. Create one new Pod instance
3. [repeat steps 1 and 2 until all Pods have been replaced.]

Benefit: Application is always available.

Note: If no strategy is defined then "rolling update" will be used.

### Under the hood
1. Create a new ReplicaSet for the new Pods.
2. Deploy a new Pod instance in the new ReplicaSet.
3. Destroy an old Pod instance.
4. [repeat steps 2 and 3 until all Pods have been replaced.]

```yml
# View Rollout status and history:
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment

# Update Deployment file, then apply (this is permanent):
kubectl apply -f deployment-definition.yml

# Update Deployment in-place (this leaves Deployment file out of sync):
kubectl edit deployment myapp-deployment --record=true
kubectl set image deployent/myapp-deployment nginx=nginx:1.9.1
```

## `Rollback`

`kubectl rollout undo deployment/myapp-deployment`


## Example Deployment and Rollback

```yml
kubectl get all
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment

kubectl create -f deployment-definition.yml --record=true
kubectl rollout status deployment/myapp-deployment

kubectl rollout history deployment/myapp-deployment

kubectl edit deployment myapp-deployment --record=true
# Find "image" and update from "nginx" to "nginx:1.18"
kubectl rollout status deployment/myapp-deployment

kubectl describe deployment myapp-deployment
kubectl rollout history deployment/myapp-deployment

kubectl set image deployment myapp-deployment nginx=nginx:1.18-perl --record=true
# Note that REVISION 2 will disappear...since we used "undo".

kubectl describe deployment myapp-deployment
# Check nginx version.

kubectl edit deployment myapp-deployment --record=true
# Find "image" and update from "nginx" to "nginx:1.18"
kubectl rollout status deployment/myapp-deployment
kubectl get pods
# Review STATUS

kubectl rollout undo deployment/myapp-deployment
kubectl rollout status deployment/myapp-deployment
kubectl get pods
# Review STATUS

```