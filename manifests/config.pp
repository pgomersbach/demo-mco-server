# == Class demo_mco_server::config
#
# This class is called from demo_mco_server for service config.
#
class demo_mco_server::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

}
