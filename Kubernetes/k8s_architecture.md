# k8s Architecture

## Links
* https://thenewstack.io/a-deep-dive-into-architecting-a-kubernetes-infrastructure/
* https://github.com/terraform-google-modules/cloud-foundation-fabric
* https://cloud.google.com/solutions/best-practices-vpc-design

## Thoughts
* __Architect for Change__: "While it is very important to get it right before you start, mistakes can happen, and with a lot of research happening these days, you can often find any revolution happen any day which can make your old way of thinking obsolete."
* __Modular__: "Make your architecture as Modular as possible so that you have the flexibility to do incremental changes in the future if needed."


## Networking and Security Architecture
It can involve tasks like:
* Setting up the service discovery within the cluster (which can be handled by CoreDNS).
* Setting up a service mesh if needed (eg. LinkerD, Istio, Consul, etc.)
* Setting up Ingress controllers and API Gateways (eg. Nginx, Ambassador, Kong, Gloo, etc.)
* Setting up network plugins using CNI facilitating networking within the cluster.
* Setting up Network Policies moderating the inter-service communication and exposing the services as needed using the various service types.
* Setting up interservice communication between various services using protocols and tools like GRPC, Thrift or HTTP.
* Setting up A/B testing, which can be easier if you use a service mesh like Istio or Linkerd.

https://github.com/terraform-google-modules/cloud-foundation-fabric

## Kubernetes Management
"If you are managing Kubernetes yourself, you need to take care of many things like, backing up and encrypting the etcd store, setting up networking among various nodes in the clusters, patching your nodes periodically with the latest versions of OS, managing cluster upgrades to align with the upstream Kubernetes releases. This is only recommended if you can afford to have a dedicated team that does just this."

## Infrastructure
https://medium.com/timecampus/infrastructure-engineering-the-first-principles-9d7748e3b3fb

https://thefirstprinciples.dev/

"Infrastructure should be dumb... Asking your infrastructure to do too much for you will just raise the complexity. Or if you are indeed looking to create a smart infrastructure system, try to spread the complexity rather than keeping it locked into a single component."

"Considering [the various components to an infrastructure], it is very important to have discoverability in mind when designing these systems since they might often need to work together to complete a specific task which can happen only if they are discoverable as and when needed."

Eventual Consistency (don't expect consistency immediately).