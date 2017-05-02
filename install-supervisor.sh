#!/bin/sh


set -ex


apk --no-cache add openssl python curl

curl https://bootstrap.pypa.io/get-pip.py | python

pip install supervisor
