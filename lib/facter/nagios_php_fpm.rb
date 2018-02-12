# Create custom nagios_php_fpm fact

binaries = [
  '/usr/sbin/php-fpm',
]

binaries.each do |filename|
  if FileTest.exists?(filename)
    Facter.add('nagios_php_fpm') { setcode { true } }
  end
end

