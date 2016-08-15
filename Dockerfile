FROM golang:1.7

RUN go get github.com/tools/godep && \
	go get golang.org/x/tools/go/vcs && \
	go get github.com/alexflint/go-arg && \
	go get -u github.com/alecthomas/gometalinter && gometalinter --install

COPY . $GOPATH/src/github.com/gojp/goreportcard

WORKDIR $GOPATH/src/github.com/gojp/goreportcard

CMD ["make", "start"]