class common::concat::client::config {
    file { "${common::params::localbindir}/concatfragments.sh":
        content => template('common/usr/local/bin/concatfragments.sh.erb'),
        mode    => '0755',
        require => File[$common::params::localbindir],
    }
}

# vim:sw=4:ts=4:expandtab:textwidth=79
