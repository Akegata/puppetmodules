# Class puppet::master
class puppet::master (
) {

  package { 'puppet-server':
    ensure => present,
  }

  package { 'git':
    ensure => present,
  }

  package { 'httpd':
    ensure => present,
  }

  file { '/etc/puppet/autosign.conf':
    ensure  => file,
    content => template("${module_name}/autosign.conf.erb"),
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0664',
    require => Package['puppet-server'],
  }

  file { '/etc/httpd/conf.d/puppetmaster.conf':
    ensure  => file,
    content => template("${module_name}/puppet_httpd.conf.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['httpd'],
  }
}
