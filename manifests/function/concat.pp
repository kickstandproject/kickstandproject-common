define common::function::concat(
) {
  require common::concat::client

  $safe_name   = regsubst($name, '/', '_', 'G')
  $concatdir   = "${common::params::varlocaldir}/concat"
  $fragdir     = "${concatdir}/${safe_name}"
  $concat_name = 'fragments.concat.out'

  if (!defined(File[$concatdir])) {
    file { $concatdir:
      ensure  => directory,
      require => File[$common::params::varlocaldir],
    }
  }

  file { $fragdir:
    ensure  => directory,
    force   => true,
    purge   => true,
    recurse => true,
    require => File[$concatdir],
  }

  file { "${fragdir}/fragments":
    ensure  => directory,
    force   => true,
    notify  => Exec["concat_${name}"],
    recurse => true,
    purge   => true,
    require => File[$fragdir],
  }

  file { "${fragdir}/fragments.concat":
    ensure  => present,
    require => File[$fragdir],
  }

  file { "${fragdir}/${concat_name}":
    ensure  => present,
    require => File[$fragdir],
  }

  file { $name:
    alias    => "concat_${name}",
    ensure   => present,
    source   => "${fragdir}/${concat_name}",
  }

  exec { "concat_${name}":
    alias       => "concat_${fragdir}",
    command     => "${common::params::localbindir}/concatfragments.sh -o ${fragdir}/${concat_name} -d ${fragdir}",
    notify      => File[$name],
    refreshonly => true,
    require     => [
      File["${fragdir}/fragments"],
      File["${fragdir}/fragments.concat"],
    ],
    unless      => "${common::params::localbindir}/concatfragments.sh -o ${fragdir}/${concat_name} -d ${fragdir} -t",
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
