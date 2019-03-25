# # encoding: utf-8

# Inspec test for recipe devSetup::fileHandle

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Checking for package deletion
%w(code_1.32.3-1552606978_amd64.deb containerd.io_1.2.4-1_amd64.deb docker-ce-cli_18.09.3~3-0~ubuntu-cosmic_amd64.deb docker-ce_18.09.3~3-0~ubuntu-cosmic_amd64.deb vagrant.deb gradle-5.3-bin.zip terraform_0.11.13_linux_amd64.zip datagrip.tar.gz).each do |f|
  describe file(f) do
    it { should_not exist }
  end
end

# Checking symlinks
%w(gradle datagrip).each do |s|
  describe file("/usr/local/bin/#{s}") do
    it { should be_symlink }
  end
end
