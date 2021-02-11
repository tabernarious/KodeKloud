# Kubernetes Networking

## Cluster Networking
* An IP is assigned to every Pod, not to every container.
* Pod IPs come from a network defined within the k8s node/cluster.
* Pod IPs are managed and assigned by a network routing platform (Flannel, Calico, etc.).
* Pods can talk to each other using these IPs, but due to turnover and readdressing as part of Pod lifecycling, there are better ways for Pod-to-Pod communication (see ClusterIP).

## Network Requirements
* All containers/Pods can communicate to one another without NAT.
* All nodes can communicate with all containers and vice-versa without NAT.

## Common Network Platforms
* Cisco ACI
* Flannel
* Bit Cloud Fabric
* VMware NSX-T
* Cilium
* Calico
* Weavenet

## Kubernetes Services
An object, just like Pods, ReplicaSets, and Deployments.

Enable communication between various components inside and outside of the k8s cluster.

"Loose coupling between microservices within an application."

```
        Users
          |
      [Services]
          |
       Frontend
         Pods
         |  |
[Services]  [Services]
    |           |
 Backend1    Backend2
   Pods        Pods
                |
            [Services]
                |
                DB
```

`TargetPort`: Pod Port (on Pod IP)

`Port`: Service Port (on Cluster IP)
* If not defined, `Port` will be set to `TargetPort` value.

`selector`: Looks for matching labels in Pod Definitions.
* If multiple Pods match within a single Node, the load is distributed across Pods using:

    ````
    Algorithm: Random
    SessionAffinity: Yes
    ````

* If multile Pods match across multiple Nodes, the service spans all the Nodes and uses the same NodePort on each Node (even for nodes that do not contain matching Pods), but this results in multiple IP:Port definitions (Node1:NodePort, Node2:NodePort, etc.). This can be unified using a LoadBalancer service.

### NodePort Service
Listens on the Node's IP on a specific Port (NodeIP:Port) and forwards requests to the Pod's IP and Port (PodIP:Port).

`NodePort`: Node Port (on Node IP)
* Valid port range: 30000-32767
* If not defined, `NodePort` will allocate any free port 30000-32767.

`service-nodeport-definition.yml`
```yml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  type: NodePort
  ports:
    - targetPort: 80
      port: 80
      nodePort: 30008
  selector:
    app: myapp
    type: front-end
```

```yml
# Review existing configuration
kubectl get deployment
kubectl get pods

# Create a service
kubectl create -f service-definition.yml

# View service status
kubectl get service
# Note ClusterIP and NodePort definitions.

# In minikube, get a URL of the service
minikube service myapp-service --url
```


### ClusterIP
Creates a virtual IP inside the cluster to enable communication between different services (frontend to backend).

`service-clusterip-definition.yml`
```yml
apiVersion: v1
kind: Service
metadata:
  name: back-end
spec:
  type: ClusterIP
  ports:
    - targetPort: 80
      port: 80
  selector:
    app: myapp
    type: back-end
```

```yml
# Review existing configuration
kubectl get deployment
kubectl get pods

# Create a service
kubectl create -f service-definition.yml

# View service status
kubectl get service
# Note ClusterIP and NodePort definitions.

# In minikube, get a URL of the service
minikube service myapp-service --url
```

### LoadBalancer
Creates a load balancer for an application **in supported cloud providers**. This distributes load across Pods.

In unsupported environments the LoadBalancer service will look just like a NodePort service--no external load balancer will be configured.

`service-loadbalancer-definition.yml`
```yml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  type: LoadBalancer
  ports:
    - targetPort: 80
      port: 80
      nodePort: 30008
???
```

```yml
# Review existing configuration
kubectl get deployment
kubectl get pods

# Create a service
kubectl create -f service-definition.yml

# View service status
kubectl get service
# Note ClusterIP and NodePort definitions.

# In minikube, get a URL of the service
minikube service myapp-service --url
```