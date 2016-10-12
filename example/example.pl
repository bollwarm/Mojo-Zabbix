#!/usr/bin/perl
#

use strict;
use warnings;

#use lib "lib";

use Mojo::Zabbix;
use Data::Dumper;

my $z = Mojo::Zabbix->new(
	url =>"https://zabbix.org/zabbix/", 
	username => 'test', 
	password => 'test',
	verify_ssl => 0,
	debug => 1,
	trace => 1,
);
$z->output(Mojo::Zabbix::OUTPUT_REFER);

print Dumper($z->get("host", { 
	output => Mojo::Zabbix::OUTPUT_EXTEND,
	selectItems => Mojo::Zabbix::OUTPUT_REFER,
	selectInterfaces => Mojo::Zabbix::OUTPUT_EXTEND,
	filter => { status => 0}
}));

