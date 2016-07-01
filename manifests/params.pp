# == Class demo_mco_server::params
#
# This class is meant to be called from demo_mco_server.
# It sets variables according to platform.
#
class demo_mco_server::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'demo_mco_server'
      $service_name = 'demo_mco_server'
    }
    'RedHat', 'Amazon': {
      $package_name = 'demo_mco_server'
      $service_name = 'demo_mco_server'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
