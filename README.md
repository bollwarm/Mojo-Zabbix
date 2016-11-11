## Mojo::Zabbix is a  simple perl wrapper of Zabbix API. 
we build  only authentication and request methods and few 
helper methods to simplify calling methods such as
create/get/update/delete/exists. 

## Mojo::Zabix - 是对zabbix api函数的简单打包，以便更易于用perl脚本进行
访问操作zabbix。目前仅支持认证和请求方法，可以用其进行create/get
/update/delete/exists方法调用，见例子。本模块基于Mojo::useragent，结果
可以用Mojo:DOM进行处理和内容提取。

The more details ,please visting the Zabbix API documentation pages .

- [Zabbix API Wiki](http://www.zabbix.org/)
- [Zabbix 1.8 API](http://www.zabbix.com/documentation/1.8/api)
- [Zabbix 2.0 API](http://www.zabbix.com/documentation/2.0/)
- [Zabbix 2.2 API](https://www.zabbix.com/documentation/2.2/)
- [Zabbix 3.0 API](https://www.zabbix.com/documentation/3.0/)
- [Zabbix 3.2 API](https://www.zabbix.com/documentation/3.2/)
- [Zabbix 3.4 API](https://www.zabbix.com/documentation/3.4/)

### Test

The module is compatible and tested with Zabbix less version 3.0

本模块目前仅在3.0以前的模块下测试，3.0以上版本理论上应该可以使用，但是未严格测试

### Example

     use Mojo::Zabbix;

     my $z = Net::Zabbix->new(
	url => "https://server/zabbix/", 
	username => 'user', 
	password => 'pass',
	verify_ssl => 0,
	debug => 1,
	trace => 0,
     );

     my $r = $z->get("host", {
            filter => undef,
            search => {
            host => "test",
        },
     }
     );

#### A example for print the zabbix api version 打印zabbix服务器版本.

    print $z->get("apiinfo.version",)->{result},"\n";

#### A example for get the new warn message of triggerid 打印新警告触发器.

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


### The result all 结果示意: 

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

### More 更多说明

wo can add the program to crontab  and gain the result for mail
or some Im tool.

我们可以通过cron定时调用程序获得结果，也可以通过IM工具（qq，微信，
目前有个webqq（https://github.com/sjdy521/Mojo-Webqq）的插件,交互
性获取监控数据。

本模块有个高级函数打包模块Mojo::Zabbix:APP 可以更方便使用，建议可
参考使用。

### Git repo
 
[github] (https://github.com/bollwarm/Mojo-Zabbix)
 
### AUTHOR
 
orange  (linzhe@ijz.me) ,[blog](http://ijz.me)

### License

This software is copyright (c) 2016 by oragnge.

This is free software; you can redistribute it and/or modify
 it under the same terms as the Perl 5 programming language system itself..

