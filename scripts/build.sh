#!/usr/bin/env bash

BUILD_DIR=build
OUTPUT=$BUILD_DIR/cheat

rm -rf $BUILD_DIR

mkdir -p $OUTPUT

(cd ui && yarn build)

go run hack/packr/packr.go

echo "building cheat server..."
#CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags '-s -w -X main.version=`1.0.0` -X main.mode=Prod' -buildmode=pie -trimpath -tags 'netgo osusergo' -o $OUTPUT/cheat
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags '-s -w -X main.version=`1.0.0` -X main.mode=Prod' -trimpath -tags 'netgo osusergo' -o $OUTPUT/cheat

# if not embeds build assets in go binaries
# go build -o $OUTPUT/cheat
# then exec under commands
# mkdir -p $OUTPUT/ui/build
# cp -r ui/build $OUTPUT/ui/build

chmod +x $OUTPUT/cheat

cp cheat.config.development $OUTPUT/cheat.config

cp users $OUTPUT

echo "building cheat docs server..."
(cd docs && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags '-s -w -X main.docsAddr=:8080' -o cheat-docs)

mv docs/cheat-docs $OUTPUT

chmod +x $OUTPUT/cheat-docs

cp -r docs/docs $OUTPUT/docs

cp cheat-start.sh $OUTPUT

# in [ req ], append `req_extentions = v3_req`
# in [ v3_req ], append subjectAltName = @alt_names, comment `basicConstraints` and `keyUsage`
# append '[ alt_names ]\nDNS.1 = 47.100.243.137' (echo '[ alt_names ]\nDNS.1 = 47.100.243.137' >> ./ssl/openssl.cnf)
# cp /usr/local/etc/openssl/openssl.cnf ./ssl/
# (cd ssl && openssl req -sha256 -new -nodes -x509 -out server.crt -keyout server.key -days 3650 -subj "/C=CN/ST=SH/L=SH/O=newtorn/OU=newtorn Software/CN=127.0.0.1/emailAddress=codertorn@gmail.com" -config ./ssl/openssl.cnf -extensions v3_req)
(mkdir -p && cd ssl && openssl req -sha256 -new -nodes -x509 -out server.crt -keyout server.key -days 3650 -subj "/C=CN/ST=SH/L=SH/O=newtorn/OU=newtorn Software/CN=127.0.0.1/emailAddress=codertorn@gmail.com")
cp -r ssl $OUTPUT/ssl

