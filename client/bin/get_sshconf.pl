#!/usr/bin/env perl

use v5.10.1;

use utf8;
use strict;
use warnings;
use autodie;

use Net::OpenSSH;
use File::Path qw( make_path );

my $host   = '-- SERVER IP --';
my $ssh    = Net::OpenSSH->new($host);
my $stdout = $ssh->capture2('bin/sshconfig_gen.pl');

my $ssh_conf = <<"CONF";
ServerAliveInterval 240
HashKnownHosts      no

$stdout
CONF

my $ssh_home = "$ENV{HOME}/.ssh";
make_path $ssh_home unless -e $ssh_home;
open my $fh, '>', "$ssh_home/config";
say {$fh} $ssh_conf;
