wget -qO - https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz | tar xz -C /usr/local
cp -R files/* /

export PATH=$PATH:/usr/local/go/bin
export GOPATH=/usr/local/gopath
mkdir -p $GOPATH
go get github.com/nsf/gocode
go get github.com/alecthomas/gometalinter
go get golang.org/x/tools/cmd/goimports
go get golang.org/x/tools/cmd/guru
go get golang.org/x/tools/cmd/gorename
go get github.com/golang/lint/golint
go get github.com/rogpeppe/godef
go get github.com/kisielk/errcheck
go get github.com/jstemmer/gotags
go get github.com/klauspost/asmfmt/cmd/asmfmt
go get github.com/fatih/motion
go get github.com/zmb3/gogetdoc
go get github.com/josharian/impl
go get github.com/mailgun/godebug
go get github.com/kardianos/govendor

. /etc/profile.d/go.sh
