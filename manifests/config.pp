class haproxy::config inherits haproxy {
  file { '/etc/haproxy/haproxy.cfg' :
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template('haproxy/haproxy.cfg.erb'),
  }

  if $global_options['chroot'] {
    file { $global_options['chroot']:
      ensure => directory,
      owner  => $global_options['user'],
      group  => $global_options['group'],
    }
  }
}

