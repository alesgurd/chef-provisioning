# # encoding: utf-8

# Inspec test for recipe devSetup::desktopEntries

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/usr/share/applications/datagrip.desktop') do
  it { should exist }
end
