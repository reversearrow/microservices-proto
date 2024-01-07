.Phony: compile
compile:
	protoc --go_out=./golang --go-grpc_out=./golang --go_opt paths=source_relative --go-grpc_opt paths=source_relative ./${SERVICE_NAME}/*.proto