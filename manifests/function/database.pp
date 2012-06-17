#
# puppet-modules: The Kickstand Project
#
# Copyright (C) 2011, Polybeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
# See http://kickstand-project.org for more information about
# the Kickstand project. Please do not directly contact any
# of the maintainers of this project for assistance; the
# project provides a web site, forums and IRC channels for
# your use.
#
# This program is free software, distributed under the terms
# of the GNU General Public License Version 2. See the LICENSE
# file at the top of the source tree.
#
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

# vim:sw=4:ts=4:expandtab:textwidth=79
