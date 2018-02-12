class nagios::check::postfix (
  $ensure                   = undef,
  $args                     = $::nagios_check_postfix_args,
  $check_title              = $::nagios::client::host_name,
  $servicegroups            = undef,
  $check_period             = $::nagios::client::service_check_period,
  $contact_groups           = $::nagios::client::service_contact_groups,
  $first_notification_delay = $::nagios::client::first_notification_delay,
  $max_check_attempts       = $::nagios::client::service_max_check_attempts,
  $notification_period      = $::nagios::client::service_notification_period,
  $use                      = $::nagios::client::service_use,
) inherits ::nagios::client {


  # https://exchange.nagios.org/directory/Plugins/Email-and-Groupware/Postfix/Check-Postfix-Mailqueue-2/details  --> check_phpfpm_status.pl -H 127.0.0.1 -s nagios.example.com -w 1,1,1 -c 0,2,2
  # Include defaults if no overrides in $args
  if !$args { $args = '-w 20 -c 50'}


  nagios::service { "check_postfix_${check_title}":
    ensure                   => $ensure,
    check_command            => "check_postfix!${args}",
    service_description      => 'postfix',
    servicegroups            => $servicegroups,
    check_period             => $check_period,
    contact_groups           => $contact_groups,
    first_notification_delay => $first_notification_delay,
    notification_period      => $notification_period,
    max_check_attempts       => $max_check_attempts,
    use                      => $use,
  }

}
