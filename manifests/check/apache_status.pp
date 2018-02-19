class nagios::check::apache_status (
  $ensure                   = undef,
  $args                     = $::nagios_check_apache_status_args,
  $check_title              = $::nagios::client::host_name,
  $servicegroups            = undef,
  $check_period             = $::nagios::client::service_check_period,
  $contact_groups           = $::nagios::client::service_contact_groups,
  $first_notification_delay = $::nagios::client::first_notification_delay,
  $max_check_attempts       = $::nagios::client::service_max_check_attempts,
  $notification_period      = $::nagios::client::service_notification_period,
  $use                      = $::nagios::client::service_use,
) inherits ::nagios::client {

  if $ensure != 'absent' {
    Package <| tag == 'nagios-plugins-perl' |>
  }
  # Include defaults if no overrides in $args
  if !$args { $fullargs = '-p 80 -t 15 -w 15 -c 3'}  else { $fullargs = $args }

  nagios::service { "check_apache_status_${check_title}":
    ensure                   => $ensure,
    check_command            => "check_apache_status!${fullargs}",
    service_description      => 'apache_status',
    servicegroups            => $servicegroups,
    check_period             => $check_period,
    contact_groups           => $contact_groups,
    first_notification_delay => $first_notification_delay,
    notification_period      => $notification_period,
    max_check_attempts       => $max_check_attempts,
    use                      => $use,
  }

}
