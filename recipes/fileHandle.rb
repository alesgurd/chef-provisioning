#
# Cookbook:: devSetup
# Recipe:: fileHandle
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Deleting all tmp files.
%w(code_1.32.3-1552606978_amd64.deb containerd.io_1.2.4-1_amd64.deb docker-ce-cli_18.09.3~3-0~ubuntu-cosmic_amd64.deb docker-ce_18.09.3~3-0~ubuntu-cosmic_amd64.deb vagrant.deb gradle-5.3-bin.zip terraform_0.11.13_linux_amd64.zip /tmp/datagrip.tar.gz).each do |f|
  file "/tmp/#{f}" do
    action :delete
  end
end

# Creating Gradle symlink
link '/usr/local/bin/gradle' do
  to '/opt/gradle-5.3/bin/gradle'
  link_type :symbolic
  action :create
end

# Creating Datagrip symlink
link '/usr/local/bin/datagrip' do
  to '/opt/DataGrip-2018.3.4/bin/datagrip.sh'
  link_type :symbolic
  action :create
end
