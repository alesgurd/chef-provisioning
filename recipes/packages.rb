#
# Cookbook:: devSetup
# Recipe:: packages
#
# Copyright:: 2019, The Authors, All Rights Reserved.

include_recipe 'apt'

apt_update 'Update repo list first' do
  ignore_failure true
  action :update
end

#
# Handling dependencies
%w(curl apt-transport-https ca-certificates software-properties-common libnotify4 libxkbfile1 libsecret-common libsecret-1-0 unzip).each do |p|
  package p do
    action :install
  end
end

include_recipe 'chrome::apt'
include_recipe 'tar'

# Install GIT
# Because this can be installed through APT
# There isn't any other specification
package 'git'

# Install VIM
package 'vim'

# Install OpenJDK 11
package 'openjdk-11-jdk'

# Fetching golang binary
tar_extract 'https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz' do
  target_dir '$HOME'
  creates '$HOME/go'
  not_if { ::Dir.exist?('$HOME/go') }
end

# Install google-chrome-stable
package 'google-chrome-stable'

# Install virtualbox
package 'virtualbox'

# Getting Visual Studio Code .deb
remote_file '/tmp/code_1.32.3-1552606978_amd64.deb' do
  source 'https://go.microsoft.com/fwlink/?LinkID=760868'
  mode 0644
end

# Install VSCode
dpkg_package 'VSCode' do
  source '/tmp/code_1.32.3-1552606978_amd64.deb'
  action :install
end

# Dowloading docker required packages
%w(containerd.io_1.2.4-1_amd64.deb docker-ce-cli_18.09.3~3-0~ubuntu-cosmic_amd64.deb docker-ce_18.09.3~3-0~ubuntu-cosmic_amd64.deb).each do |rp|
  remote_file "/tmp/#{rp}" do
    source "https://download.docker.com/linux/ubuntu/dists/cosmic/pool/stable/amd64/#{rp}"
    mode 0644
  end
end

# Installing docker packages
%w(containerd.io_1.2.4-1_amd64.deb docker-ce-cli_18.09.3~3-0~ubuntu-cosmic_amd64.deb docker-ce_18.09.3~3-0~ubuntu-cosmic_amd64.deb).each do |dpkg|
  dpkg_package dpkg do
    source "/tmp/#{dpkg}"
    action :install
  end
end

# Start docker service and enable it
service 'docker' do
  action [:start, :enable]
end

# Fetching Vagrant binary
remote_file '/tmp/vagrant.deb' do
  source 'https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.deb'
  mode '0644'
  action :create
  not_if { ::Dir.exist?('/opt/vagrant') }
end

# Installing Vagrant
dpkg_package 'vagrant' do
  source '/tmp/vagrant.deb'
  action :install
end

# Fetching kubectl binary and installing it
remote_file '/usr/local/bin/kubectl' do
  source 'https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kubectl'
  mode '0755'
  action :create
  not_if { ::File.exist?('/usr/local/bin/kubectl') }
end

# Fetching Gradle binary
remote_file '/tmp/gradle-5.3-bin.zip' do
  source 'https://services.gradle.org/distributions/gradle-5.3-bin.zip'
  mode '0644'
  action :create
  not_if { ::Dir.exist?('/opt/gradle-5.3') }
end

# Unzip gradle directory
execute 'Unzip gradle directory' do
  command 'unzip /tmp/gradle-5.3-bin.zip -d /opt/'
  action :run
  not_if { ::Dir.exist?('/opt/gradle-5.3') }
end

# Install maven
package 'maven'

# Fetching Terraform binary
remote_file '/tmp/terraform_0.11.13_linux_amd64.zip' do
  source 'https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip'
  mode '0644'
  not_if { ::File.exist?('/usr/local/bin/terraform') }
end

# Unzipping terraform binary to bin dir
execute 'Unzip terraform binary' do
  command 'unzip /tmp/terraform_0.11.13_linux_amd64.zip -d /usr/local/bin/'
  action :run
  not_if { ::File.exist?('/usr/local/bin/terraform') }
end

# Fetching Datagrip tarfile
tar_extract '/tmp/datagrip.tar.gz' do
  source 'https://download.jetbrains.com/datagrip/datagrip-2018.3.4.tar.gz'
  target_dir '/opt/'
  creates '/opt/Datagrip'
end

# Install zsh
package 'zsh'

# Install oh-my-zsh
execute 'Install oh-my-zsh' do
  command 'wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh; cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc'
  not_if { ::Dir.exist?('$HOME/.oh-my-zsh') }
end
