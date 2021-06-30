HOSTNAME=registry.terraform.io
NAMESPACE=rgl
NAME=vbmc
BINARY=terraform-provider-${NAME}
VERSION?=0.1.0
OS_ARCH=$(shell go env GOOS)_$(shell go env GOARCH)

default: install

build:
	go build -o ${BINARY}

install: build
	mkdir -p ~/.terraform.d/plugins/${HOSTNAME}/${NAMESPACE}/${NAME}/${VERSION}/${OS_ARCH}
	mv ${BINARY} ~/.terraform.d/plugins/${HOSTNAME}/${NAMESPACE}/${NAME}/${VERSION}/${OS_ARCH}
