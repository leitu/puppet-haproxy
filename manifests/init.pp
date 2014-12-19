# == Class: haproxy
#
# Full description of class haproxy here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'haproxy':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class haproxy (
  $package_ensure = 'present',
  $service_ensure = 'running',
) inherits haproxy::params {

  if $service_ensure != true and $service_ensure != false {
    if ! ($service_ensure in [ 'running', 'stopped'])
    { fail('service_ensure parameter must be running, stopped, true, or false')
    }
  }
  validate_string($package_ensure)

  anchor { 'haproxy::begin': }
  ~> class { 'haproxy::install':  }
  -> class { 'haproxy::config' :  }
  ~> class { 'haproxy::service' : }
  ~> anchor { 'haproxy::end' : }

}
