#!/bin/bash

echo "Installing the chefdk"
wget https://packages.chef.io/files/stable/chefdk/3.8.14/debian/9/chefdk_3.8.14-1_amd64.deb
dpkg -i chefdk_3.8.14.-1_amd64.deb

echo "Creating cookbooks directory"
mkdir /var/chef/cookbooks

echo "Cloning project from git"
git clone https://github.com/alesgurd/chef-provisioning.git /var/chef/cookbooks/devSetup 

echo "Establishing the local berks repository and resolving cookbook dependencies."
berks vendor /var/cache/cookbooks

echo "Initiliazing chef-client locally."
chef-client -z -o devSetup::packages
chef-client -z -o devSetup::fileHandle