# Create custom nagios_php_opcache fact

binaries = [
  '/usr/sbin/php-fpm',
]

binaries.each do |filename|
  if FileTest.exists?(filename)
    #Facter.add('nagios_php_opcache') { setcode { true } }
  end
end

