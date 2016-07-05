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
    client              => true,
    manage_packages     => false,
    middleware_hosts    => [ $::middleware_address ],
    connector           => 'rabbitmq',
    rabbitmq_vhost      => 'mcollective',
    middleware_user     => 'mcollective',
    middleware_password => 'changeme',
  }

  $mc_plugindir = $::osfamily ? {
    'Debian' => '/opt/puppetlabs/mcollective/mcollective',
    default  => '/usr/libexec/mcollective/mcollective',
  }

  file{ 'mco_plugins':
    path    => $mc_plugindir,
    source  => 'puppet:///modules/demo_mco_server/mcollective/plugins',
    recurse => true,
    purge   => false,
    require => Class[ '::mcollective' ],
  }

  mcollective::server::setting { 'override identity':
    setting => 'identity',
    value   => $::fqdn,
  }

  mcollective::server::setting { 'set heartbeat_interval':
    setting => 'plugin.rabbitmq.heartbeat_interval',
    value   => '30',
    order   => '50',
  }
}
