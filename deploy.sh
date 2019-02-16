docker build -t davidainslie/multi-client:latest -t davidainslie/multi-client:$SHA -f ./client/Dockerfile ./client
docker push davidainslie/multi-client:latest
docker push davidainslie/multi-client:$SHA

docker build -t davidainslie/multi-server:latest -t davidainslie/multi-server:$SHA -f ./server/Dockerfile ./server
docker push davidainslie/multi-server:latest
docker push davidainslie/multi-server:$SHA

docker build -t davidainslie/multi-worker:latest -t davidainslie/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push davidainslie/multi-worker:latest
docker push davidainslie/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=davidainslie/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=davidainslie/multi-worker:$SHA
kubectl set image deployments/client-deployment client=davidainslie/multi-client:$SHA