#!/bin/sh

set -ex

mkdir -p /opt/
cd /opt/
wget -O dbgpproxy.tar.gz http://downloads.activestate.com/Komodo/releases/10.2.1/remotedebugging/Komodo-PythonRemoteDebugging-10.2.1-89853-linux-x86_64.tar.gz?_ga=1.244941959.346575217.1493103402
tar xzvf dbgpproxy.tar.gz
mv Komodo* dbgpproxy

export PYTHONPATH=$PYTHONPATH:/opt/dbgpproxy/pythonlib

