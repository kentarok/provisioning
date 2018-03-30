#!/bin/sh
# ハンズオンChefWorkstation作成用

rpm -ivh https://packages.chef.io/files/stable/chef/13.8.5/el/7/chef-13.8.5-1.el7.x86_64.rpm

mkdir bootstrap
cd bootstrap
wget https://raw.githubusercontent.com/kentarok/provisioning/master/handson/chefws.rb
chef-apply ./chefws.rb | tee -a ./chef-apply.log
