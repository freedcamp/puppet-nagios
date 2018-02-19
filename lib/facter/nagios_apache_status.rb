# Create custom nagios_apache_status fact

binaries = [
  '/usr/sbin/httpd',
]

binaries.each do |filename|
  if FileTest.exists?(filename)
    Facter.add('nagios_apache_status') { setcode { true } }
  end
end

