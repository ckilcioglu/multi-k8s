docker build -t ckilcioglu/multi-client:latest -t ckilcioglu/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t ckilcioglu/multi-server:latest -t ckilcioglu/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t ckilcioglu/multi-worker:latest -t ckilcioglu/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push ckilcioglu/multi-client:latest
docker push ckilcioglu/multi-server:latest
docker push ckilcioglu/multi-worker:latest
docker push ckilcioglu/multi-client:$SHA
docker push ckilcioglu/multi-server:$SHA
docker push ckilcioglu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ckilcioglu/multi-client:$SHA
kubectl set image deployments/server-deployment server=ckilcioglu/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ckilcioglu/multi-worker:$SHA
