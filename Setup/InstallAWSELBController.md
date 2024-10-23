Install eksctl https://eksctl.io/installation/

Ref: https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

add the iam policy
step 1: curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.2/docs/install/iam_policy.json

step 2: aws iam create-policy \
 --policy-name MQ2AWSLoadBalancerControllerIAMPolicy \
 --policy-document file://iam_policy.json \
 --profile default

add iam open id

eksctl utils associate-iam-oidc-provider --region=ap-southeast-1 --cluster=minhquangeks --profile default --approve

add service account

eksctl create iamserviceaccount \
--override-existing-serviceaccounts \
--cluster=minhquangeks \
--namespace=kube-system \
--name=mq2-awslb-controller \
--role-name MQ2AmazonEKSLoadBalancerControllerRole \
--attach-policy-arn=arn:aws:iam::084375555299:policy/MQ2AWSLoadBalancerControllerIAMPolicy \
--approve \
--profile default \
--region ap-southeast-1

add helm

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
-n kube-system \
--set clusterName=minhquangeks \
--set serviceAccount.create=false \
--set serviceAccount.name=mq2-awslb-controller \
--set region=ap-southeast-1 \
--set vpcId=vpc-04a4803405e1065f7

verify

kubectl get deployment -n kube-system aws-load-balancer-controller

```sh {"id":"01J8MRBEVD2D0WAZQ0PF9VC61J"}
setup game to test

curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.2/docs/examples/2048/2048_full.yaml

kubectl apply -f 2048_full.yaml


```
