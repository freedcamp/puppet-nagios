class nagios::check::proc_age (
  $ensure                   = undef,
  $args                     = $::nagios_check_proc_age_args,
  $check_title              = $::nagios::client::host_name,
  $servicegroups            = undef,
  $check_period             = $::nagios::client::service_check_period,
  $contact_groups           = $::nagios::client::service_contact_groups,
  $first_notification_delay = $::nagios::client::first_notification_delay,
  $max_check_attempts       = $::nagios::client::service_max_check_attempts,
  $notification_period      = $::nagios::client::service_notification_period,
  $use                      = $::nagios::client::service_use,
) inherits ::nagios::client {



  nagios::client::nrpe_plugin { 'check_proc_age':
    ensure  => $ensure,
    package => $package,
  }

  # Include defaults if no overrides in $args
  #if $args !~ /-H/ { $arg_h = '-H 127.0.0.1 ' } else { $arg_h = '' }
  #if $args !~ /-p/ { $arg_p = '-p 11211 ' }     else { $arg_p = '' }
  #if $args !~ /-U/ { $arg_u = '-U 75,90 ' }     else { $arg_u = '' }
  #$fullargs = strip("${arg_h}${arg_p}${arg_u}-f ${args}")


  # https://exchange.nagios.org/directory/Plugins/Email-and-Groupware/Postfix/Check-Postfix-Mailqueue-2/details  --> check_phpfpm_status.pl -H 127.0.0.1 -s nagios.example.com -w 1,1,1 -c 0,2,2
  # Include defaults if no overrides in $args
  if !$args { $fullargs = '-w 20 -c 50'}

  nagios::client::nrpe_file { 'check_proc_age':
    ensure => $ensure,
    args   => $fullargs,
  }

  nagios::service { "check_proc_age_${check_title}":
    ensure                   => $ensure,
    check_command            => "check_proc_age!${fullargs}",
    service_description      => 'process age',
    servicegroups            => $servicegroups,
    check_period             => $check_period,
    contact_groups           => $contact_groups,
    first_notification_delay => $first_notification_delay,
    notification_period      => $notification_period,
    max_check_attempts       => $max_check_attempts,
    use                      => $use,
  }

}
