class haproxy::install inherits haproxy {
  package { $package_name :
    ensure => $package_ensure,
    alias  => 'haproxy',
  }
}
