all: lint build test

NAME    = goreportcard
VERSION = latest

build:
	go build ./...

image: build
	docker build -t=ricardolonga/$(NAME):$(VERSION) .

run:
	docker run -d --name report -p 80:8000 ricardolonga/$(NAME):$(VERSION)

logs:
	docker logs -f report

rm:
	docker rm -vf report

push:
	docker push ricardolonga/$(NAME):$(VERSION)

install: 
	./scripts/make-install.sh

lint:
	gometalinter --exclude=vendor --exclude=repos --disable-all --enable=golint --enable=vet --enable=gofmt ./...
	find . -name '*.go' | xargs gofmt -w -s

test: 
	 go test -cover ./check ./handlers

start:
	 go run main.go

misspell:
	find . -name '*.go' | xargs misspell -error
