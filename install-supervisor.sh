#!/bin/sh


set -ex


apk --no-cache add openssl python

wget https://bootstrap.pypa.io/ez_setup.py -O - | python
easy_install pip

pip install supervisor
