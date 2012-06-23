class common::params {
  $group = $::operatingsystem ? {
    default => 'root',
  }

  $localbindir = $::operatingsystem ? {
    default => '/usr/local/bin/puppet',
  }

  $mode = $::operatingsystem ? {
    default => '0640',
  }

  $owner = $::operatingsystem ? {
    default => 'root',
  }

  $varlocaldir = $::operatingsystem ? {
    default => '/var/local/puppet',
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
