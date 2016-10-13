Mojo::Zabbix is a  simple perl wrapper of Zabbix API. 
we build  only authentication and request methods and few 
helper methods to simplify calling methods such as
create/get/update/delete/exists. 

Mojo::Zabix - 是对zabbix api函数的简单打包，以便更易于用perl脚本进行
访问操作zabbix。目前仅支持认证和请求方法，可以用其进行create/get
/update/delete/exists方法调用，见例子。本模块基于Mojo::useragent，结果
可以用Mojo:DOM进行处理和内容提取。

The more details ,please visting the Zabbix API documentation pages .

- [Zabbix API Wiki](http://www.zabbix.com/wiki/doc/api)
- [Zabbix 1.8 API](http://www.zabbix.com/documentation/1.8/api)
- [Zabbix 2.0 API](http://www.zabbix.com/documentation/2.0/manual/appendix/api/api)
- [Zabbix 2.2 API](https://www.zabbix.com/documentation/2.2/manual/api/reference)

### Test

The module is compatible and tested with Zabbix less version 3.0

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


### License

This software is copyright (c) 2016 by oragnge.

This is free software; you can redistribute it and/or modify
 it under the same terms as the Perl 5 programming language system itself..

