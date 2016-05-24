#!/bin/bash

DIR=CA

if [ -f "$DIR/ca.pem" ]; then
    echo "*** Error: the file $DIR/ca.pem already exists, please remove it first."
    exit 1
fi

mkdir -p $DIR

openssl genrsa -aes256 -out $DIR/key.pem 4096
openssl req -new -x509 -sha256 -days 3650 -config openssl.cnf -key $DIR/key.pem -out $DIR/ca.pem

chmod 0400 $DIR/key.pem
chmod 0444 $DIR/ca.pem
