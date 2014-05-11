#!/bin/bash
 
# apt
mkdir -p ./my-recipes/cookbooks/apt && curl -L https://github.com/opscode-cookbooks/apt/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/apt

# build essential
mkdir -p ./my-recipes/cookbooks/build-essential && curl -L https://github.com/opscode-cookbooks/build-essential/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/build-essential
 
# sudo
mkdir -p ./my-recipes/cookbooks/sudo && curl -L https://github.com/opscode-cookbooks/sudo/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/sudo
 
# Open SSL
mkdir -p ./my-recipes/cookbooks/openssl && curl -L https://github.com/opscode-cookbooks/openssl/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/openssl

# PostgreSQL
mkdir -p ./my-recipes/cookbooks/postgresql && curl -L https://github.com/opscode-cookbooks/postgresql/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/postgresql

# Git
mkdir -p ./my-recipes/cookbooks/git && curl -L https://github.com/opscode-cookbooks/git/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/git

# Git Flow
mkdir -p ./my-recipes/cookbooks/gitflow && curl -L https://github.com/jbergantine/gitflow/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/gitflow

# Python
mkdir -p ./my-recipes/cookbooks/python && curl -L https://github.com/opscode-cookbooks/python/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/python

# zlib
mkdir -p ./my-recipes/cookbooks/zlib && curl -L https://github.com/opscode-cookbooks/zlib/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/zlib

# LibJpeg
mkdir -p ./my-recipes/cookbooks/libjpeg && curl -L https://github.com/jbergantine/chef-cookbook-libjpeg/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/libjpeg

# LibFreeType
mkdir -p ./my-recipes/cookbooks/libfreetype && curl -L https://github.com/jbergantine/libfreetype/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/libfreetype

# ruby_build
mkdir -p ./my-recipes/cookbooks/ruby_build && curl -L https://github.com/fnichol/chef-ruby_build/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/ruby_build

# rbenv
mkdir -p ./my-recipes/cookbooks/rbenv && curl -L https://github.com/fnichol/chef-rbenv/tarball/master | tar -xz --strip-components=1 --directory=./my-recipes/cookbooks/rbenv