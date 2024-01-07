#!/bin/bash
SERVICE_NAME=$1
RELEASE_NAME=$2

sudo apt-get install -y protobuf-compiler golang-goprotobuf-dev
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
make compile
make
cd golang/"${SERVICE_NAME}" || exit
go mod init github.com/reversearrow/microservices-proto/golang/"${SERVICE_NAME}" ||true
git config --global user.email "reversearrow@gmail.com"
git config --global user.name "Jay Shah"
git add . && git commit -am "proto update" || true
git tag -fa golang/${SERVICE_NAME}/${RELEASE_VERSION} \
-m "golang/${SERVICE_NAME}/${RELEASE_VERSION}"
git push origin refs/tags/golang/${SERVICE_NAME}/${RELEASE_VERSION}