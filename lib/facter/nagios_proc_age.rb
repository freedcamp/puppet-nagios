# Create custom nagios_postfix fact

binaries = [
  '/usr/sbin/postfix',
]

binaries.each do |filename|
  if FileTest.exists?(filename)
    Facter.add('nagios_postfix') { setcode { true } }
  end
end

