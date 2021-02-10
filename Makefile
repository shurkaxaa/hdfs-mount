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

