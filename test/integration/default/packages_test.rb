# # encoding: utf-8

# Inspec test for recipe devSetup::packages

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Describe installed packages
%w(git vim google-chrome-stable virtualbox code docker-ce vagrant maven zsh).each do |p|
  describe package(p) do
    it { should be_installed }
  end
end

describe command('java --version') do
  its(:stdout) { should match('OpenJDK') }
end

describe file('/home/mroldan/go') do
  its('type') { should eq :directory }
  it { should be_directory }
end

describe command('docker -v') do
  its(:stdout) { should match('Docker') }
end

describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/usr/local/bin/kubectl') do
  it { should exist }
end

describe file('/opt/gradle-5.3') do
  its('type') { should eq :directory }
  it { should be_directory }
end

describe file('/usr/local/bin/terraform') do
  it { should exist }
end

describe file('/opt/DataGrip-2018.3.4') do
  it { should be_directory }
end

describe file('/home/vagrant/.oh-my-zsh') do
  it { should be_directory }
end
