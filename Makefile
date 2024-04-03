format:
	gofmt -s -w ./
build:
	go build -v -o kbot -ldflags "-X="github.dev/tosya1984/kbot/cmd.appVersion=v1.0.5
