# nsenter
 nsenter container, build from scratch

## pull image
docker pull harbor.rsheng.org/public/nsenter:latest

## run image
docker run -it --name nsenter harbor.rsheng.org/public/nsenter:latest /nsenter --help

## build image

docker build --tag nsenter:latest .
docker buildx build --platform linux/arm64,linux/amd64 --tag nsenter:latest .
