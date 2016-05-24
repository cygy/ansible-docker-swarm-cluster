#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "*** Error: illegal number of parameters"
    echo "Usage: $0 user host"
    exit 1
fi

CADIR=CA
REMOTEDIR=/etc/docker/certs
USER=$1
HOST=$2
DIR=hosts/$HOST

if ! [ -f "$CADIR/ca.pem" ]; then
    echo "*** Error: the file $CADIR/ca.pem does not exist, please run 'create_CA.sh' first."
    exit 1
fi

if ! [ -f "$DIR/key.pem" ]; then
    echo "*** Error: the file $DIR/key.pem does not exist, please run 'create_keypair.sh' first."
    exit 1
fi

if ! [ -f "$DIR/cert.pem" ]; then
    echo "*** Error: the file $DIR/cert.pem does not exist, please run 'create_keypair.sh' first."
    exit 1
fi

scp -r $CADIR/ca.pem $USER@$HOST:$REMOTEDIR/ca.pem
scp -r $DIR/key.pem $USER@$HOST:$REMOTEDIR/key.pem
scp -r $DIR/cert.pem $USER@$HOST:$REMOTEDIR/cert.pem
