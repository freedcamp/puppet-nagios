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



  nagios::client::nrpe_plugin { 'check_postfix':
    ensure  => $ensure,
    package => $package,
  }

  # Include defaults if no overrides in $args
  #if $args !~ /-H/ { $arg_h = '-H 127.0.0.1 ' } else { $arg_h = '' }
  #if $args !~ /-p/ { $arg_p = '-p 11211 ' }     else { $arg_p = '' }
  #if $args !~ /-U/ { $arg_u = '-U 75,90 ' }     else { $arg_u = '' }
  #$fullargs = strip("${arg_h}${arg_p}${arg_u}-f ${args}")

  # Include defaults if no overrides in $args
  if !$args { $args = '-w 20 -c 50'}

  nagios::client::nrpe_file { 'check_postfix':
    ensure => $ensure,
    args   => $args,
  }
  file { '/var/spool/postfix':
    mode        => '0744',
  }
  file { '/var/spool/postfix/deferred':
    mode        => '0744',
  }
  file { '/var/spool/postfix/active':
    mode        => '0744',
  }
  file { '/var/spool/postfix/bounce':
    mode        => '0744',
  }
  file { '/var/spool/postfix/corrupt':
    mode        => '0744',
  }
  file { '/var/spool/postfix/hold':
    mode        => '0744',
  }
  nagios::service { "check_postfix_${check_title}":
    ensure                   => $ensure,
    check_command            => "check_nrpe_postfix!${args}",
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
