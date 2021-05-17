docker build -t asia.gcr.io/multi-k8s-312904/multi-client:latest -t asia.gcr.io/multi-k8s-312904/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t asia.gcr.io/multi-k8s-312904/multi-server:latest -t asia.gcr.io/multi-k8s-312904/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t asia.gcr.io/multi-k8s-312904/multi-worker:latest -t asia.gcr.io/multi-k8s-312904/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push asia.gcr.io/multi-k8s-312904/multi-client:latest
docker push asia.gcr.io/multi-k8s-312904/multi-server:latest
docker push asia.gcr.io/multi-k8s-312904/multi-worker:latest

docker push asia.gcr.io/multi-k8s-312904/multi-client:$GIT_SHA
docker push asia.gcr.io/multi-k8s-312904/multi-server:$GIT_SHA
docker push asia.gcr.io/multi-k8s-312904/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=asia.gcr.io/multi-k8s-312904/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=asia.gcr.io/multi-k8s-312904/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=asia.gcr.io/multi-k8s-312904/multi-worker:$GIT_SHA

 