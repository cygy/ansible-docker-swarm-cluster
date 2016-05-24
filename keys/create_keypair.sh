#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "*** Error: illegal number of parameters"
    echo "Usage: $0 hostname"
    exit 1
fi

CADIR=CA
HOSTNAME=$1
DIR=hosts/$HOSTNAME

if ! [ -f "$CADIR/ca.pem" ]; then
    echo "*** Error: the file $CADIR/ca.pem does not exist, please run 'create_CA.sh' first."
    exit 1
fi

mkdir -p $DIR

openssl genrsa -out $DIR/key.pem 4096
openssl req -subj "/CN=$HOSTNAME" -sha256 -new -key $DIR/key.pem -out $DIR/req.csr
openssl x509 -req -days 3650 -sha256 -in $DIR/req.csr -CA $CADIR/ca.pem -CAkey $CADIR/key.pem -CAcreateserial -out $DIR/cert.pem -extensions v3_req -extfile openssl.cnf
openssl rsa -in $DIR/key.pem -out $DIR/key.pem

rm -f $DIR/req.csr
rm -f $CADIR/ca.srl
chmod 0400 $DIR/key.pem
chmod 0444 $DIR/cert.pem
