define common::function::concat(
    $force = false,
    $gnu = undef,
    $order='alpha'
) {
    require common::concat::client

    $safe_name   = regsubst($name, '/', '_', 'G')
    $concatdir   = "${common::params::varlocaldir}/concat"
    $fragdir     = "${concatdir}/${safe_name}"
    $concat_name = 'fragments.concat.out'

    case $force {
        'true',true,yes,on: { $forceflag = '-f' }
        'false',false,no,off: { $forceflag = '' }
        default: { fail("Improper 'force' value given to concat: ${force}") }
    }

    case $order {
        numeric: { $orderflag = '-n' }
        alpha: { $orderflag = '' }
        default: { fail("Improper 'order' value given to concat: ${order}") }
    }

    if (!defined(File[$concatdir])) {
        file { $concatdir:
            ensure  => directory,
            require => File[$common::params::varlocaldir],
        }
    }

    file { $fragdir:
        ensure  => directory,
        require => File[$concatdir],
    }

    file { "${fragdir}/fragments":
        ensure  => directory,
        recurse => true,
        purge   => true,
        force   => true,
        notify  => Exec["concat_${name}"],
        require => File[$fragdir],
    }

    file { "${fragdir}/fragments.concat":
        ensure   => present,
        require => File[$fragdir],
    }

    file { "${fragdir}/${concat_name}":
        ensure   => present,
        require => File[$fragdir],
    }

    file { $name:
        ensure   => present,
        source   => "${fragdir}/${concat_name}",
        checksum => md5,
        alias    => "concat_${name}";
    }

    exec { "concat_${name}":
        notify    => File[$name],
        subscribe => File[$fragdir],
        alias     => "concat_${fragdir}",
        require   => [
            File["${fragdir}/fragments"],
            File["${fragdir}/fragments.concat"],
        ],
        unless    => "${common::params::localbindir}/concatfragments.sh -o ${fragdir}/${concat_name} -d ${fragdir} -t ${forceflag} ${orderflag}",
        command   => "${common::params::localbindir}/concatfragments.sh -o ${fragdir}/${concat_name} -d ${fragdir} ${forceflag} ${orderflag}",
    }
}

# vim:sw=4:ts=4:expandtab:textwidth=79
