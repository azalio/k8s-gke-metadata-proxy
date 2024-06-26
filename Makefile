# Copyright 2017 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

all: build

ENVVAR = GOOS=linux GOARCH=amd64 CGO_ENABLED=0
REGISTRY = azalio
TAG = v0.1.12

deps:
	go install github.com/tools/godep@latest

#build: clean deps
build: clean deps
#	$(ENVVAR) godep go test ./...
#	$(ENVVAR) godep go build -o proxy
	$(ENVVAR) go build -o proxy

container: build
	docker build --pull --no-cache -t ${REGISTRY}/metadata-proxy:$(TAG) .

push: container
	docker push ${REGISTRY}/metadata-proxy:$(TAG)

clean:
	rm -f proxy
