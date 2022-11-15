
# Projectwaldo

A greymatter.io tenant GitOps repository using CUE! :rocket:

## Prerequisites

* `greymatter` CLI v4.5+
* [CUE](https://cuelang.org/docs/install/)

## Getting Started

Let's get to know the in's and out's of a greymatter.io project!

### CUE

We write mesh configurations in [CUE](https://cuelang.org/), a fantastic data
validation language. It's quite cutting edge, but not hard to learn. We put
together a quick crash course you can read in TUTORIAL.md. You can also
checkout the official [CUE documentation](https://cuelang.org/docs/), [cuetorials](https://cuetorials.com/),
and the [CUE playground](https://cuelang.org/play/#cue@export@cue).

### Creating the example Grocery Store Project

`greymatter init` comes bundled with a full end-to-end example of a grocery store project. 
To generate, run the following command:
```
greymatter init --dir store --example grocerystore
```

### Creating a project scaffold

`greymatter init` also supports creating an empty project. This includes an edge node,
a globals file, a greymatter.io sync manifest, and a prefetched greymattter.io v1.8 dependencies.
Try running the following:
```
greymatter init --dir project myproject
```

## Project Layout

What comes in a greymatter project?

* `cue.mod`: A directory that marks this repo as a cue module.
* `cue.mod/module.cue`: Contains our module name: "examples.module". CUE modules
are logical groupings of packages and enable certain features like imports.
* `cue.mod/pkg`: A package that holds all greymatter and Envoy config
CUE schemas as well as other CUE fetched dependencies.
* `greymatter`: The target directory for your project CUE. All greymatter service configurations 
will live in this folder regardless of the package.
* `greymatter/core`: This directory hosts greymatter specific functionality such as edge nodes, bridges,
and other various core features.
* `./greymatter/globals.cue`: A CUE file in `package globals` that contains
defaults, overrides, and user generated values. This is the entry point to your configuration pipeline.
* `k8s`: A folder to host Kubernetes manifests.
* `k8s/sync.yaml`: A stateful set deploying the greymatter sync service.
* `TUTORIAL.md`: an introduction to CUE! :rocket:

## Exploring Config Outputs


## Applying Configs to a Mesh

### Prerequisites

- An operator managed greymatter.io mesh

### Setup

To apply the configurations provided through this project scaffold,
we recommend deploying the bundled sync service. There are a few things
to do before we launch that sync StatefulSet:

- Install the SSH key secret
```bash
# GitOps SSH key
# EDIT THIS to reflect your own, or some other SSH private key with access,
# to the repository you would like the operator to use for GitOps.
kubectl create secret generic greymatter-sync-secret \
    --from-file=ssh-private-key=$HOME/.ssh/id_ed25519 \
    --from-literal=password="REDACTED" \
    -n $MY_NAMESPACE
```

> NOTE: Please be sure that the git remote provided in the k8s/sync.yaml file is accurate and accessible.
> Also make sure to modify the namespaces in the `k8s/sync.yaml` to your target namespace.

Make sure to apply the starter k8s manifests in the `./k8s` folder.

```bash
kubectl apply -f ./k8s/manifests.yaml -n $MY_NAMESPACE # this file contains your project edge
kubectl apply -f ./k8s/sync.yaml -n $MY_NAMESPACE # this deploys the greymatter.io sync service
```

Once you've deployed your manifests retrieve the Kubernetes ingress service for your 
project's edge node:
```bash
kubectl get svc edge-projectwaldo -n $MY_NAMESPACE
```

Retrieve the hostname entry and port and populate the value in `greymatter/globals.cue`: `defaults.edge.endpoint`.
This will become the route that traffic will flow through to your services.

Commit the change, push to your repo, and happy requesting!

### Deployment

greymatter.io supports GitOps as a first-class function. Deploying new services is as easy 
applying a manifest and committing!

Given you have an existing manifest for your service, first deploy it into an operator watched namespace
with the proper sidecar annotations in the Kubernetes object `metadata` field:
```yaml
# Deployment metadata
metadata:
  name: my-new-service
  namespace: my-namespace
  annotations:
    greymatter.io/inject-sidecar-to: 10809
  
...

# Container spec metadata 
# This is required to associate your service with a data-plane group in greymatter.
# Note that the value provided on this annotation should be 
# the key defined in your services proxy object.
metadata:
  labels:
    greymatter.io/cluster: my_new_service
```

Then generate your greymatter.io configurations with the CLI:
```bash
greymatter init service --type=http --dir=greymatter/myproject --port 8080 --package=myproject myrestapi
```
Once that is generated add the service to the top file EXPORTS.cue.
After doing so, make a commit to your remote repository that you pointed the deployed sync service to and push! 
After a few moments your service should show up in the greymatter.io intelligence 
dashboard and go green once the sidecar can reach the upstream service.

### Using Secure Mode

By default, `greymatter init` will inject your service configurations with full mutual TLS termination happening at the sidecar. 
This means we'll have to create some certificates and mount them in a specific location on disk of each data-plane proxy container. 
We recommend using Kubernetes secrets and volume mounts to independently manage certificates for sidecars in their respective namespaces.

#### Securing Your Gateway
A hook is provided for setting up TLS on the given edge gateway for your project. Please create a secret at the following location:
```bash
kubectl create secret generic greymatter-projectwaldo-edge-certs \
	--from-file=ca.crt=./ca.crt \
	--from-file=server.crt=./server.crt \
	--from-file=server.key=./server.key \
	-n $MY_NAMESPACE
```

#### Securing Services

Certificates are required at the following locations in individual sidecar containers:

__Trust:__  `/etc/proxy/tls/sidecar/ca.crt`
__Certificate:__ `/etc/proxy/tls/sidecar/server.crt`
__Key:__ `/etc/proxy/tls/sidecar/server.key`
> Note: The path + file name is important and should be exactly what is outlined above.
 
greymatter.io mesh configurations have been setup for your service to look at these paths. 
It is up to you to get them there! Following the pattern defined in the `k8s/manifests.yaml` edge-projectwaldo Deployment 
is a great way to get your certs mounted and available to the greymatter.io data plane.

> Note: your enterprise will need to make sure the core mesh configurations support volume mounted certificates
> so sidecars will have the files when the start. If they are not there, registration into the mesh will never occur.

By default, we look for a secret in your namespace at the following location: `gm-edge-ingress-certs`. 
If this is populated with the required certificates, the volume mounts for injected sidecars will work appropriately.

## Troubleshooting and Gotchas

#### No Sidecar Injection?

- You need to add your projects namespace to the `watched_namespaces` 
array in the core greymatter.io enterprise configs.
- Make sure the injection annotations are in the correct location inside your 
StatefulSet/Deployment. *Hint: they should be in the k8s object metadata.*

####  Services not showing up in the greymatter.io dashboard?

- Make sure the `sync.yaml` manifest is pointed at the correct git remote repository. This can be found in the co-located ConfigMap inside the file.
- Verify your generated service as a `#catalog_entry` with proper keys/names.
- Make sure the greymatter.io sync has no reported errors inside the pod logs.
- Verify you have added your services into the `EXPORTS.cue` configuration arrays.

#### CUE is not evaluating?

- Make sure your intermediates.cue/inputs.cue package matches your service.cue's package. If they do not, then CUE will not evaluate them together.
- Verify all imports/package names are correct.

#### Still stuck?

Check out our [troubleshooting guide](https://docs.greymatter.io/troubleshoot/errors/) at docs.greymatter.io. 
