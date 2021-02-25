docker build -t legoweggo/multi-client:latest -t legoweggo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t legoweggo/multi-server:latest -t legoweggo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t legoweggo/multi-worker:latest -t legoweggo/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push legoweggo/multi-client:latest
docker push legoweggo/multi-server:latest
docker push legoweggo/multi-worker:latest

docker push legoweggo/multi-client:$SHA
docker push legoweggo/multi-server:$SHA
docker push legoweggo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=legoweggo/multi-client:$SHA
kubectl set image deployments/server-deployment server=legoweggo/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=legoweggo/multi-worker:$SHA