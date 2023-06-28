# EKS

Demonstrate how to use awscli to query EKS.  

```sh
export AWS_PROFILE=
export AWS_REGION=
```

## Listing clusters

```sh
aws eks list-clusters
```

## Addons

```sh
# coredns
aws eks describe-addon --cluster-name my-cluster --addon-name coredns --query addon.addonVersion --output text

# kubeproxy
aws eks describe-addon --cluster-name my-cluster --addon-name kube-proxy --query addon.addonVersion --output text
```

## Resources

* Working with the CoreDNS Amazon EKS add-on [here](https://docs.aws.amazon.com/eks/latest/userguide/managing-coredns.html)  

