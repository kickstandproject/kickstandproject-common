class common::concat::params {
  $group = $::operatingsystem ? {
    default => 'root',
  }

  $mode = $::operatingsystem ? {
    default => '0644',
  }

  $owner = $::operatingsystem ? {
    default => 'root',
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
