#!/bin/bash
 
# Create a directory for Chef Recipes and Cookbooks
mkdir -p ./my-recipes/cookbooks
 
# Download cookbooks

# apt
mkdir -p ./my-recipes/cookbooks/apt && curl -L https://github.com/opscode-cookbooks/apt/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/apt

# Build Essentials < 2.0 since Vagrant doesn't seem to be using Chef 11
# https://tickets.opscode.com/browse/COOK-4441?page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel
# It looks like you could also change the version of Chef that Vagrant uses
# http://stackoverflow.com/questions/11325479/how-to-control-the-version-of-chef-that-vagrant-uses-to-provision-vms
mkdir -p ./my-recipes/cookbooks/build-essential && curl -L https://github.com/opscode-cookbooks/build-essential/archive/v1.4.4.tar.gz | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/build-essential
 
# sudo
mkdir -p ./my-recipes/cookbooks/sudo && curl -L https://github.com/opscode-cookbooks/sudo/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/sudo
 
# Open SSL
mkdir -p ./my-recipes/cookbooks/openssl && curl -L https://github.com/opscode-cookbooks/openssl/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/openssl

# PostgreSQL
mkdir -p ./my-recipes/cookbooks/postgresql && curl -L https://github.com/opscode-cookbooks/postgresql/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/postgresql

# Git
mkdir -p ./my-recipes/cookbooks/git && curl -L https://github.com/opscode-cookbooks/git/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/git

# Python
mkdir -p ./my-recipes/cookbooks/python && curl -L https://github.com/comandrei/python/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/python

# zlib
mkdir -p ./my-recipes/cookbooks/zlib && curl -L https://github.com/opscode-cookbooks/zlib/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/zlib

# Python-Psycopg2
mkdir -p ./my-recipes/cookbooks/python-psycopg2 && curl -L https://github.com/jbergantine/chef-cookbook-python-psycopg2/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/python-psycopg2

# LibJpeg
mkdir -p ./my-recipes/cookbooks/libjpeg && curl -L https://github.com/jbergantine/chef-cookbook-libjpeg/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/libjpeg

# LibFreeType
mkdir -p ./my-recipes/cookbooks/libfreetype && curl -L https://github.com/jbergantine/chef-cookbook-libfreetype/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/libfreetype
