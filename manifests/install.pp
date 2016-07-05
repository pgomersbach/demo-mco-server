# == Class demo_mco_server::install
#
# This class is called from demo_mco_server for install.
#
class demo_mco_server::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  class { '::mcollective':
    client              => false,
    manage_packages     => false,
    middleware_hosts    => [ $::middleware_address ],
    connector           => 'rabbitmq',
    rabbitmq_vhost      => 'mcollective',
    middleware_user     => 'mcollective',
    middleware_password => 'changeme',
  }

}
