docker build -t aenglisc/multi-client:latest -t aenglisc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aenglisc/multi-server:latest -t aenglisc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aenglisc/multi-worker:latest -t aenglisc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aenglisc/multi-client:latest
docker push aenglisc/multi-server:latest
docker push aenglisc/multi-worker:latest

docker push aenglisc/multi-client:$SHA
docker push aenglisc/multi-server:$SHA
docker push aenglisc/multi-worker:$SHA

kubect apply -f k8s

kubect set image deployments/client-deployment client=aenglisc/multi-client:$SHA
kubect set image deployments/server-deployment server=aenglisc/multi-server:$SHA
kubect set image deployments/worker-deployment worker=aenglisc/multi-worker:$SHA

