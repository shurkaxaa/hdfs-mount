# Copyright (c) Microsoft. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.

export GOPATH=$(PWD)/_gopath

GITCOMMIT=`git rev-parse --short HEAD`
BUILDTIME=`date +%FT%T%z`
HOSTNAME=`hostname`

bin:
	go build -mod=vendor -ldflags "-s -w -X main.GITCOMMIT=${GITCOMMIT} -X main.BUILDTIME=${BUILDTIME} -X main.HOSTNAME=${HOSTNAME}" -o build/hdfs-mount

all: hdfs-mount 
	rm -rf build

hdfs-mount: bin

clean:
	rm -f hdfs-mount _mock_*.go

make_in_docker:
	svc=
	mkdir -p build
	docker run --rm \
		-v `pwd`:/app \
		-e CGO_ENABLED=$(CGO_ENABLED) \
		-e GOOS=$(GOOS) \
		-e GOARCH=$(GOARCH) \
		-e GOARM=$(GOARM) \
		golang:1.14.4-alpine \
		/bin/sh -c "cd /app && go build -mod=vendor -ldflags '-s -w' -o build/hdfs-mount"
