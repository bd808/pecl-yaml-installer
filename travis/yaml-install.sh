#!/usr/bin/env bash
#
# Install the yaml pecl module from source
#

set -e

if pecl &>/dev/null ; then
  # pecl is present for this version of php
  printf "\n" | pecl install yaml-devel

else
  # Travis doesn't always have pecl installed for alpha/beta php versions
  # Do what pecl should do manually

  echo "=================================================================="
  echo "MANUAL INSTALL OF PECL MODULE"
  echo " - Travis doesn't have a working pecl binary for ${TRAVIS_PHP_VERSION}"
  echo "=================================================================="

  # Download and unpack latest tarball
  curl -o yaml.tgz http://pecl.php.net/get/yaml
  tar xzf yaml.tgz
  cd yaml-*

  # standard pecl module build dance
  phpize
  ./configure --with-yaml
  make

  # install our new module
  sudo make install
  echo "extension=yaml.so" >> ~/.phpenv/versions/$(phpenv version-name)/etc/php.ini
fi
