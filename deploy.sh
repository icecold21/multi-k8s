# build images
docker build -t jonathanwylliem/multi-client:latest -t jonathanwylliem/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jonathanwylliem/multi-server:latest -t jonathanwylliem/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jonathanwylliem/multi-worker:latest -t jonathanwylliem/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push images
docker push jonathanwylliem/multi-client:latest
docker push jonathanwylliem/multi-server:latest
docker push jonathanwylliem/multi-worker:latest

docker push jonathanwylliem/multi-client:$SHA
docker push jonathanwylliem/multi-server:$SHA
docker push jonathanwylliem/multi-worker:$SHA

# apply deployment
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jonathanwylliem/multi-server:$SHA
kubectl set image deployments/client-deployment client=jonathanwylliem/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jonathanwylliem/multi-worker:$SHA
