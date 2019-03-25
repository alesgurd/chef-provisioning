#
# Cookbook:: devSetup
# Recipe:: desktopEntries
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Datagrip desktop entry
template '/usr/share/applications/datagrip.desktop' do
  source 'datagripEntry'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
