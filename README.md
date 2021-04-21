# Production Deployment with Jar Packaging

Web Developers Toolkit: https://www.youtube.com/channel/UCdLqxzh_bocMmfgAdssvngg/featured

## Backend build command
* docker build -t backend -f openjdk.prod.dockerfile .
* docker tag backend:latest <repo-tag>/backend:v1
* docker push <repo-tag>/backend:v1

* kubectl apply -f kube.deploy.yaml
* kubectl apply -f kube.lbservice.yaml
