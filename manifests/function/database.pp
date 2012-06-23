define common::function::database(
  $password,
  $server,
  $table,
  $type,
  $user,
) {
  require common::client

  if (!defined(File["${common::params::varlocaldir}/${name}"])) {
    file { "${common::params::varlocaldir}/${name}":
      ensure  => directory,
      purge   => true,
      recurse => true,
      require => File[$common::params::varlocaldir],
    }
  }

  if ($type == 'mysql') {
    if ($server == 'localhost') {
        require mysql::server
    }

    mysql::functions::grant { $name:
      db_name     => $table,
      db_password => $password,
      db_server   => $server,
      db_user     => $user,
    }
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
