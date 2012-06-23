class common::client::config {
  File {
    group => $common::params::group,
    mode  => $common::params::mode,
    owner => $common::params::owner,
  }

  file { $common::params::localbindir:
    ensure => directory,
  }

  file { $common::params::varlocaldir:
    ensure => directory,
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
