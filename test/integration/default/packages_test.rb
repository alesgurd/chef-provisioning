# # encoding: utf-8

# Inspec test for recipe devSetup::packages

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('git') do
  it { should be_installed }
end

describe package('vim') do
  it { should be_installed }
end

describe command('java --version') do
  its(:stdout) { should match('OpenJDK') }
end

describe file('/home/mroldan/go') do
  its('type') { should eq :directory }
  it { should be_directory }
end

describe package('google-chrome-stable') do
  it { should be_installed }
end

describe package('virtualbox') do
  it { should be_installed }
end

describe package('code') do
  it { should be_installed }
end

describe package('docker-ce') do
  it { should be_installed }
end

describe command('docker -v') do
  its(:stdout) { should match('Docker') }
end

describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe package('vagrant') do
  it { should be_installed }
end

describe file('/usr/local/bin/kubectl') do
  it { should exist }
end

describe file('/opt/gradle-5.3') do
  its('type') { should eq :directory }
  it { should be_directory }
end
