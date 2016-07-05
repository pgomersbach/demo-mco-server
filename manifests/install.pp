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

  $mco_packeges = [ 'mcollective-plugins-puppetral', 'mcollective-plugins-process', 'mcollective-plugins-package', 'mcollective-plugins-service', 'mcollective-plugins-nrpe', 'mcollective-plugins-filemgr', 'mcollective-plugins-facts-facter' ]
  package { $mco_packeges:
    ensure  => installed,
    require => Class[ '::mcollective' ],
  }

  file { '/opt/puppetlabs/mcollective/mcollective/application':
    ensure  => link,
    target  => '/usr/share/mcollective/plugins/mcollective/application',
    require => Package[ $mco_packeges ],
  }

  file { '/opt/puppetlabs/mcollective/mcollective/agent':
    ensure  => link,
    target  => '/usr/share/mcollective/plugins/mcollective/agent',
    require => Package[ $mco_packeges ],
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
