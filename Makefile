APP=${shell basename $(shell git remote get-url origin)}
REGISTRY=doctortosya
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64

format:
	gofmt -s -w ./
get:
	go get

lint:
	golint
test:
	go test -v

Linux:  format get 
	CGD_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.dev/tosya1984/kbot/cmd.appVersion=${VERSION}

Winsows: format get 
	CGD_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.dev/tosya1984/kbot/cmd.appVersion=${VERSION}

arm: format get 
	CGD_ENABLED=0 GOOS=${TARGETOS} GOARCH=arm go build -v -o kbot -ldflags "-X="github.dev/tosya1984/kbot/cmd.appVersion=${VERSION}

macOS: format get 
	CGD_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o kbot -ldflags "-X="github.dev/tosya1984/kbot/cmd.appVersion=${VERSION}


build: format get 
	CGD_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.dev/tosya1984/kbot/cmd.appVersion=${VERSION}

image:
	docker build . --platform ${TARGETOS}/${TARGETARCH} -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot