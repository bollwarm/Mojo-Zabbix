    use lib "../lib";
    use Mojo::Zabbix::APP;

    my @myzinfo = <DATA>;    ##(get zabbix info from __DATA__ )
# Define for debug and traceing processe infomaition。（打开调试和跟踪）
    my $DEBUG = 1;
    my $TRACE = 1;

#my @myzinfo = ('test1  http://test1/zabbix    testuser pass');
# @可以定义为多行数据，格式按照这种，一个zabbix 服务地址一个

    for (@myzinfo) {
        chomp;
        next if /^#/;
        next if /^\s*$/;
        my ( $name, $url, $user, $pass ) = split;
        print "\n$name $url $user $pass\n";
        my $z; 
        $url=shift;
        #print "$url\n";
        eval { $z = initZ( $url, $user, $pass )};

        if ($@) {

            print "Error $@!\n";

        }
        else {
            ## Print the version of zabbix api. 打印zabbix 版本

            #print pVersion($z);

            ## Print all host lists。 获取所有的主机列表

          # print getAllhost($z);
            #print getAlert($z); 
            ## Print warning info of Triggers。打印取得的所有触发器告警信息
           print pTriggers($z);
            #print getEvents($z);
            ## Print the history data of given items, default for past 24 hours.
            ## 打印给定时间段的item历史数据，如果默认不给时间默认为过去24小时内的
          #pHitems($z);

        }

    }

__DATA__
test https://zabbix.test.com/zabbix test test123
