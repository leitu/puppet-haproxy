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
class haproxy::params {
  case $::osfamily {
    'Redhat': {
      $package_name     = 'haproxy'
      $global_options   = {
        'log'     => "${::ipaddress} local0",
        'chroot'  => '/var/lib/haproxy',
        'pidfile' => '/var/run/haproxy.pid',
        'maxconn' => '4000',
        'user'    => 'haproxy',
        'group'   => 'haproxy',
        'daemon'  => '',
        'stats'   => 'socket /var/lib/haproxy/stats'
      }
      $defaults_options = {
         'log'     => 'global',
         'stats'   => 'enable',
         'option'  => 'redispatch',
         'retries' => '3',
         'timeout' => [
          'http-request 10s',
          'queue 1m',
          'connect 10s',
          'client 1m',
          'server 1m',
          'check 1m',
          ],
          'maxconn' => '8000'
      }
      $backend_services = {
        'nginx'  => '3000',
        'beeper' => '6080',
        'vnc'    => '5678',
      }
      $port           = '80'
      $mode           = 'http'
      $balance_mode   = 'leastconn'
      $timeout_server = '30000'
      $timeout_conn    = '4000'
      $hostname        = 'server1'

    }
    default: { fail("Your ${::osfamily} is not support at this moment") }
  }
}
