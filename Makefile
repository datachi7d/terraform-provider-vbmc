HOSTNAME=registry.terraform.io
NAMESPACE=rgl
NAME=vbmc
BINARY=terraform-provider-${NAME}
VERSION?=0.3.0
OS_ARCH=$(shell go env GOOS)_$(shell go env GOARCH)

default: install

build: vbmc-emulator
	go build -o ${BINARY}

vbmc-emulator:
	docker build -t ruilopes/vbmc-emulator vbmc-emulator

install: build
	mkdir -p ~/.terraform.d/plugins/${HOSTNAME}/${NAMESPACE}/${NAME}/${VERSION}/${OS_ARCH}
	mv ${BINARY} ~/.terraform.d/plugins/${HOSTNAME}/${NAMESPACE}/${NAME}/${VERSION}/${OS_ARCH}

uninstall:
	rm -f .terraform.lock.hcl
	rm -rf .terraform/providers/${HOSTNAME}/${NAMESPACE}/${NAME}
	rm -rf ~/.terraform.d/plugins/${HOSTNAME}/${NAMESPACE}/${NAME}

.PHONY: default build vbmc-emulator install uninstall
