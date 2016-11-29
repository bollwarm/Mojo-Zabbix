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

####  print the zabbix api version

print $z->get("apiinfo.version",)->{result},"\n";

#### A example for get the new warn message of triggerid.

print getTriggers($z);
sub getTriggers {
        my $z=shift;
        my $ysterday=localtime(time()-24*3600);
        my $r = $z->get("trigger", {
                filter => {value => 1,
                           lastChangeSince => "$ysterday",
                  'withUnacknowledgedEvents'=>1,
                },
                output => ["","triggerid","description","priority"],
               sortfield =>"priority",
                sortorder => "DESC",
                expandData=>"host",

        },
        );
        my $result;
        my $host=$r->{'result'};
        for (@$host){
           $result.="$_->{'host'}:".$_->{'description'}."\n" ;
         }

       return $result;
}

=encoding utf8
=pod

The result all:

xxx.xxx.xx.55: {HOST.CONN}服务器的84端口down
xxx.xxx.xx.55: {HOST.CONN}服务器的81端口down
xxx.xxx.xx.55: {HOST.CONN}服务器的82端口down
xxx.xxx.xx.55.9: {HOST.CONN}服务器的80端口down
xxx.xxx.xx.12: {HOST.NAME} 服务器负载较高，请及时查看
xxx.xxx.xx.124: 磁盘sdb利用率超过95%，当前值为{ITEM.LASTVALUE}
xxx.xxx.xx.44: 磁盘sdb利用率超过95%，当前值为{ITEM.LASTVALUE}
xxx.xxx.xx.45: 磁盘sdb利用率超过95%，当前值为{ITEM.LASTVALUE}
xxx.xxx.xx.33: 磁盘sdb利用率超过95%，当前值为{ITEM.LASTVALUE}
xxx.xxx.xx.56: 磁盘sda利用率超过95%，当前值为{ITEM.LASTVALUE}
xxx.xxx.xx.57: 磁盘sda利用率超过95%，当前值为{ITEM.LASTVALUE}

wo can add the program to crontab  and gain the result for mail

or some Im tool.
=cut
