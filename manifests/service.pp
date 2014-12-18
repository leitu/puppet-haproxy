class haproxy::service inherits haproxy {
  service { 'haproxy' :
    ensure     => $service_ensure,
    enable     => true,
    name       => 'haproxy',
    hasrestart => true,
    hasstatus  => true,
  }
}
