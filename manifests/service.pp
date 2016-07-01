# == Class demo_mco_server::service
#
# This class is meant to be called from demo_mco_server.
# It ensure the service is running.
#
class demo_mco_server::service {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { $::demo_mco_server::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
