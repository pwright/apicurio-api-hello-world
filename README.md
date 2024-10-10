<!-- NOTE: This file is generated from skewer.yaml.  Do not edit it directly. -->

# Apicurio Registry Hello World

[![main](https://github.com/pwright/apicurio-api-hello-world/actions/workflows/main.yaml/badge.svg)](https://github.com/pwright/apicurio-api-hello-world/actions/workflows/main.yaml)

#### A minimal registry

This example is part of a [suite of examples][examples] showing the
different ways you can use [Apicurio Registry][website] a high performance, 
runtime registry for API designs and schemas .

[website]: https://www.apicur.io/
[examples]: https://www.apicur.io/examples/index.html

#### Contents

* [Overview](#overview)
* [Prerequisites](#prerequisites)
* [Step 1: Set up your cluster](#step-1-set-up-your-cluster)
* [Step 2: Deploy Apicurio Registry](#step-2-deploy-apicurio-registry)
* [Step 3: Expose the Registry](#step-3-expose-the-registry)
* [Step 4: Populate the Registry](#step-4-populate-the-registry)
* [Next steps](#next-steps)
* [About this example](#about-this-example)

## Overview

In this example, we'll run Apicurio Registry and populate it with a few 
schemas using the API.
Then, we use the API to query the

## Prerequisites

Access to a Kubernetes cluster. If you don't have access, skip the setup
steps and use Docker to set up Apicurio Registry as described in 
([Using Docker][getting-started])
[getting-started]: https://www.apicur.io/registry/docs/apicurio-registry/2.6.x/getting-started/assembly-installing-registry-docker.html

## Step 1: Set up your cluster

Set up the `kubectl` command to use your
[kubeconfig][kubeconfig] and current context to select the cluster
and namespace where they operate.

[kubeconfig]: https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/

Your kubeconfig is stored in a file in your home directory.  The
`skupper` and `kubectl` commands use the `KUBECONFIG` environment
variable to locate it.

A single kubeconfig supports only one active context per user.
Since you will be using multiple contexts at once in this
exercise, you need to create distinct kubeconfigs.

**Note:** The login procedure varies by provider.  See the
documentation for yours:

* [Minikube](https://skupper.io/start/minikube.html#cluster-access)
* [Amazon Elastic Kubernetes Service (EKS)](https://skupper.io/start/eks.html#cluster-access)
* [Azure Kubernetes Service (AKS)](https://skupper.io/start/aks.html#cluster-access)
* [Google Kubernetes Engine (GKE)](https://skupper.io/start/gke.html#cluster-access)
* [IBM Kubernetes Service](https://skupper.io/start/ibmks.html#cluster-access)
* [OpenShift](https://skupper.io/start/openshift.html#cluster-access)

_**Registry:**_

~~~ shell
export KUBECONFIG=~/.kube/config-apicurio
# Enter your provider-specific login command
kubectl create namespace apicurio
kubectl config set-context --current --namespace apicurio
~~~

## Step 2: Deploy Apicurio Registry

_**Registry:**_

~~~ shell
kubectl apply -f apicurio-deployment.yaml
~~~

## Step 3: Expose the Registry

_**Registry:**_

~~~ shell
kubectl port-forward deployment/apicurio-registry 8080:8080
~~~

## Step 4: Populate the Registry

_**Registry:**_

~~~ shell
curl -X POST -H "Content-type: application/json; artifactType=AVRO" -H "X-Registry-ArtifactId: share-price" --data '{"type":"record","name":"price","namespace":"com.example","fields":[{"name":"symbol","type":"string"},{"name":"price","type":"string"}]}' http://localhost:8080/apis/registry/v2/groups/my-group/artifacts
~~~

## Next steps

Check out the other [examples][examples] on the Apicurio Registry website.

## About this example

This example was produced using [Skewer][skewer], a library for
documenting and testing examples.

[skewer]: https://github.com/skupperproject/skewer

Skewer provides utility functions for generating the README and
running the example steps.  Use the `./plano` command in the project
root to see what is available.

To quickly stand up the example using Minikube, try the `./plano demo`
command.
