docker build -t strelok2911/multi-client:latest -t strelok2911/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t strelok2911/multi-server:latest -t strelok2911/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t strelok2911/multi-worker:latest -t strelok2911/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push strelok2911/multi-client:latest
docker push strelok2911/multi-server:latest
docker push strelok2911/multi-worker:latest

docker push strelok2911/multi-client:$GIT_SHA
docker push strelok2911/multi-server:$GIT_SHA
docker push strelok2911/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=strelok2911/multi-server:$GIT_SHA
kubectl set image deployments/client-deployments client=strelok2911/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployments worker=strelok2911/multi-worker:$GIT_SHA

 