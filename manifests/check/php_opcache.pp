class nagios::check::php_opcache (
  $ensure                   = undef,
  $args                     = $::nagios_check_opcache_args,
  $check_title              = $::nagios::client::host_name,
  $servicegroups            = undef,
  $check_period             = $::nagios::client::service_check_period,
  $contact_groups           = $::nagios::client::service_contact_groups,
  $first_notification_delay = $::nagios::client::first_notification_delay,
  $max_check_attempts       = $::nagios::client::service_max_check_attempts,
  $notification_period      = $::nagios::client::service_notification_period,
  $use                      = $::nagios::client::service_use,
) inherits ::nagios::client {

  # Include defaults if no overrides in $args
  if !$args { $fullargs = '--url http://$HOSTADDRESS$:8989/opcache.php --keys 70:80 --memory 70:80 --string-memory 70:80 --ratio 5:10 --restart 1:2'}  else { $fullargs = $args }

  nagios::service { "check_php_opcache_${check_title}":
    ensure                   => $ensure,
    check_command            => "check_php_opcache!${fullargs}",
    service_description      => 'php_opcache',
    servicegroups            => $servicegroups,
    check_period             => $check_period,
    contact_groups           => $contact_groups,
    first_notification_delay => $first_notification_delay,
    notification_period      => $notification_period,
    max_check_attempts       => $max_check_attempts,
    use                      => $use,
  }

}
