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

  # Needs "plugin_nginx => true" on nagios::server to get the check script

  nagios::service { "check_php_fpm_${check_title}":
    ensure                   => $ensure,
    check_command            => "check_php_fpm!${args}",
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
