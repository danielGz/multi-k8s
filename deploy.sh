docker build -t dannx/multi-client:latest -t dannx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dannx/multi-server:latest -t dannx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dannx/multi-worker:latest -t dannx/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dannx/multi-client:latest
docker push dannx/multi-server:latest
docker push dannx/multi-worker:latest

docker push dannx/multi-client:$SHA
docker push dannx/multi-server:$SHA
docker push dannx/multi-worker:$SHA

kubectl apply -f k8s
#<objecttype/deploymentname> <containername>=<container-image>
kubectl set image deployments/client-deployment client=dannx/multi-client:$SHA
kubectl set image deployments/server-deployment server=dannx/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dannx/multi-worker:$SHA