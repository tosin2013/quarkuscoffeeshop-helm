# Deploy Quarkus Cafe Using a helm chart

## Administrator Tasks 
    
**Install Helm**
```
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

### OpenShift 4.x Instructions 
**Login to OpenShift and create project**
```
oc new-project quarkus-cafe-demo
```

**Run ansible playbook to install Red Hat AMQ and mongodb on target cluster**
* [admin-tasks](https://github.com/jeremyrdavis/quarkus-cafe-demo/tree/master/support/helm-deployment/admin-tasks)


### Kubernertes Cluster Instructions - WIP

**Add the Quarkuscoffeeshop Helm Chart repository**
```
helm repo add quarkuscoffeeshop https://quarkuscoffeeshop.github.io/quarkuscoffeeshop-helm/
```

Use 

**Add the Strimzi Helm Chart repository**
```
helm repo add strimzi https://strimzi.io/charts/
```

**Deploy the Cluster Operator using the Helm command line tool**
```
helm install strimzi/strimzi-kafka-operator
```

**Deploy monogodb using helm chart**  
work in progress

## Developer Tasks 
**cd into support/helm-deployment**

**Update the default values found in quarkus-helm-chart/values.yaml** 

**Test Install quarkus application**
```
helm install quarkuscoffeeshop-deployment ./charts/quarkus-helm-chart/ --values ./charts/quarkus-helm-chart/values.yaml --dry-run
```

**Install quarkus application**
```
helm install quarkuscoffeeshop-deployment ./charts/quarkus-helm-chart/ --values ./charts/quarkus-helm-chart/values.yaml
```
**Uninstall quarkus application**
```
helm uninstall quarkuscoffeeshop-deployment
```

**Expose routes for Web and Customermocker**

The Helm chart does not currently expose the routes for our Web UI or the Customermocker service.  You will need to log in and expose them using oc:

```shell script
oc expose svc/quarkuscoffeeshop-web
oc expose svc/quarkuscoffeeshop-customermocker
```