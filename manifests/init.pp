# == Class: demo_mco_server
#
# Full description of class demo_mco_server here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class demo_mco_server
(
  $package_name = $::demo_mco_server::params::package_name,
  $service_name = $::demo_mco_server::params::service_name,
  $middleware_address = $::demo_mco_servert::params::middleware_address,
) inherits ::demo_mco_server::params {

  # validate parameters here
  validate_string($package_name)
  validate_string($service_name)

  class { '::demo_mco_server::install': } ->
  class { '::demo_mco_server::config': } ~>
  class { '::demo_mco_server::service': } ->
  Class['::demo_mco_server']
}
