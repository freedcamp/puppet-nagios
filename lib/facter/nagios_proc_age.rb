# Create custom nagios_proc_age fact

binaries = [
  '/usr/local/scripts/fc_cron_job.sh',
   '/usr/local/scripts/fc_reset_opcache.sh',
]

binaries.each do |filename|
  if FileTest.exists?(filename)
    Facter.add('nagios_proc_age') { setcode { true } }
  end
end

