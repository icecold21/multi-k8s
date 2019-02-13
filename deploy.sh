# build images
docker build -t jonathanwylliem/multi-client -f ./client/Dockerfile ./client
docker build -t jonathanwylliem/multi-server -f ./server/Dockerfile ./server
docker build -t jonathanwylliem/multi-worker -f ./worker/Dockerfile ./worker

# push images
docker push jonathanwylliem/multi-client
docker push jonathanwylliem/multi-server
docker push jonathanwylliem/multi-worker

# apply deployment
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jonathanwylliem/multi-server
