#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use autodie;

my $dir = '/home/www/mon/session_data';

opendir( my $dh, $dir );

while ( my $file = readdir $dh ) {
    next if $file =~ /^\.\.?$/;

    my ( $host, $ip ) = $file =~ /(.*)_(.*)/;

    next unless $host;
    next unless $ip;

    my $config = <<"CONFIG";
Host $host
    HostName $ip

CONFIG
    print $config;
}

closedir $dh;
