#!/usr/bin/env bash
#
# Install the yaml pecl module from source
#

set -e

# Find the local ini file
PHP_INI=$(php --ini | grep Loaded | awk '{print $NF}')

# Download and unpack latest tarball
curl -o yaml.tgz http://pecl.php.net/get/yaml
tar xzf yaml.tgz
cd yaml-*

# standard pecl module build dance
phpize
./configure --with-yaml
make
NO_INTERACTION=1 REPORT_EXIT_STATUS=1 make test

# install our new module
make install
echo "extension=yaml.so" >> $PHP_INI
