class common::concat::client::config {
  file { "${common::params::localbindir}/concatfragments.sh":
    content => template('common/usr/local/bin/concatfragments.sh.erb'),
    mode    => '0755',
    require => File[$common::params::localbindir],
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
