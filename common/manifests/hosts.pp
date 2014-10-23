class common::hosts
{
  augeas { "localhostv4":
    context => "/files/etc/hosts",
    changes => [
      "set *[ipaddr = '127.0.0.1']/canonical $hostname.$domain",
      "set *[ipaddr = '127.0.0.1']/alias[1] $hostname",
      "set *[ipaddr = '127.0.0.1']/alias[2] localhost",
      "set *[ipaddr = '127.0.0.1']/alias[3] localhost.localdomain",
      "set *[ipaddr = '127.0.0.1']/alias[4] localhost4",
      "set *[ipaddr = '127.0.0.1']/alias[5] localhost4.localdomain4",
    ],
  }

  augeas { "localhostv6":
    context => "/files/etc/hosts",
    changes => [
      "set *[ipaddr = '::1']/canonical $hostname.$domain",
      "set *[ipaddr = '::1']/alias[1] $hostname",
      "set *[ipaddr = '::1']/alias[2] localhost",
      "set *[ipaddr = '::1']/alias[3] localhost.localdomain",
      "set *[ipaddr = '::1']/alias[4] localhost6",
      "set *[ipaddr = '::1']/alias[5] localhost6.localdomain6",
    ],
  }
}
