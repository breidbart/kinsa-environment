#
# Author:: Joe Bergantine <jbergantine@gmail.com>
# Cookbook Name:: chef-cookbook-djangonewproj
# Recipe:: default
#
# Copyright 2013, Joe Bergantine.
#

include_recipe "bootstrap::virtualenv"
include_recipe "bootstrap::bash"
include_recipe "bootstrap::symlink-pil"
include_recipe "bootstrap::postgresql"
include_recipe "bootstrap::rubygems"
include_recipe "bootstrap::start-project"
include_recipe "bootstrap::init-git"
include_recipe "bootstrap::static-media"
include_recipe "bootstrap::graphviz"
include_recipe "bootstrap::shellplus"
include_recipe "bootstrap::runserverplus"