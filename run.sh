#!/bin/bash
set -ex

SERVICE_NAME=$1
if [ -z "$SERVICE_NAME" ]; then
  echo "Error: SERVICE_NAME is not set."
  exit 1
fi

sudo apt-get install -y protobuf-compiler golang-goprotobuf-dev
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
make compile
cd golang/"${SERVICE_NAME}" || exit
go mod init github.com/reversearrow/microservices-proto/golang/"${SERVICE_NAME}" ||true
git config --global user.email "reversearrow@gmail.com"
git config --global user.name "Jay Shah"
git add . && git commit -am "proto update" || true
git tag -fa $TAG -m "$TAG"
git push origin --tags