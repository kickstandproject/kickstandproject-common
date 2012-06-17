#
# puppet-modules: The Kickstand Project
#
# Copyright (C) 2012, R. I. Pienaar
# Copyright (C) 2012, Polybeacon, Inc.
#
# R. I. Pienaar <rip@devco.net>
# Paul Belanger <paul.belanger@polybeacon.com>
#
# See http://kickstand-project.org for more information about
# the Kickstand project. Please do not directly contact any
# of the maintainers of this project for assistance; the
# project provides a web site, forums and IRC channels for
# your use.
#
# This program is free software, distributed under the terms
# of the Apache License, Version 2.0.
#
define common::function::concat::fragment(
    $target,
    $content = '',
    $order = 10,
    $ensure = 'present',
) {
    require common::concat::client

    $safe_name = regsubst($name, '/', '_', 'G')
    $safe_target_name = regsubst($target, '/', '_', 'G')
    $concatdir = "${common::params::varlocaldir}/concat"
    $fragdir = "${concatdir}/${safe_target_name}"

    file { "${fragdir}/fragments/${order}_${safe_name}":
        ensure  => $ensure,
        alias   => "concat_fragment_${name}",
        content => $content,
        notify  => Exec["concat_${target}"],
        require => File["${fragdir}/fragments"],
    }
}

# vim:sw=4:ts=4:expandtab:textwidth=79
