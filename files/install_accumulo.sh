#!/bin/bash

export MY_ACCUMULO_VERSION=1.6.0

mkdir -p $BASE_DIR/software/accumulo-$MY_ACCUMULO_VERSION $BASE_DIR/bin/accumulo-$MY_ACCUMULO_VERSION

# Accumulo is extracted into a software directory and then installed
# into a bin directory.

cd $BASE_DIR/software
git clone https://github.com/apache/accumulo.git accumulo-$MY_ACCUMULO_VERSION
cd accumulo-$MY_ACCUMULO_VERSION
ln -s $BASE_DIR/software/accumulo-$MY_ACCUMULO_VERSION $BASE_DIR/software/accumulo

pushd $BASE_DIR/software/accumulo-$MY_ACCUMULO_VERSION
mvn package -DskipTests -DDEV_ACCUMULO_HOME=$BASE_DIR/bin
popd
echo "Compiled accumulo"

ln -s $BASE_DIR/bin/accumulo-$MY_ACCUMULO_VERSION-SNAPSHOT-dev/accumulo-${MY_ACCUMULO_VERSION}-SNAPSHOT $BASE_DIR/bin/accumulo

cp $BASE_DIR/bin/accumulo/conf/examples/512MB/standalone/* $BASE_DIR/bin/accumulo/conf

cp /vagrant/files/config/accumulo/* $BASE_DIR/bin/accumulo/conf
