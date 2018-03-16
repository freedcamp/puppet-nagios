class nagios::check::php_fpm (
  $ensure                   = undef,
  $args                     = $::nagios_check_php_fpm_args,
  $check_title              = $::nagios::client::host_name,
  $servicegroups            = undef,
  $check_period             = $::nagios::client::service_check_period,
  $contact_groups           = $::nagios::client::service_contact_groups,
  $first_notification_delay = $::nagios::client::first_notification_delay,
  $max_check_attempts       = $::nagios::client::service_max_check_attempts,
  $notification_period      = $::nagios::client::service_notification_period,
  $use                      = $::nagios::client::service_use,
) inherits ::nagios::client {


  # https://github.com/regilero/check_phpfpm_status/blob/master/check_phpfpm_status.pl  --> check_phpfpm_status.pl -H 127.0.0.1 -s nagios.example.com -w 1,1,1 -c 0,2,2
  # Include defaults if no overrides in $args
  if !$args { $fullargs = '-p 8989 -u /fpm  -t 8 -w 1,-1,-1 -c 0,2,5'}  else { $fullargs = $args }

  nagios::service { "check_php_fpm_${check_title}":
    ensure                   => $ensure,
    check_command            => "check_php_fpm!${fullargs}",
    service_description      => 'php_fpm',
    servicegroups            => $servicegroups,
    check_period             => $check_period,
    contact_groups           => $contact_groups,
    first_notification_delay => $first_notification_delay,
    notification_period      => $notification_period,
    max_check_attempts       => $max_check_attempts,
    use                      => $use,
  }

}
