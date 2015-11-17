# Install and manage puppet agents and masters, with puppet!
#
# To set up a puppet master in a vagrant environment, include the class
# with the vagrant parameter set to true.
# If you wish to run the vagrant puppet master in a rails environment,
# set the vagrant_http parameter to true as well.
#

class puppet (
  $master          = false,
){
  include puppet::install, puppet::cron

  if $master {
    include puppet::master
  }

  file { 'puppet.conf':
    ensure  => file,
    path    => '/etc/puppet/puppet.conf',
    content => template("${module_name}/puppet.conf.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { 'auth.conf':
    ensure  => file,
    path    => '/etc/puppet/auth.conf',
    source  => "puppet:///modules/${module_name}/auth.conf",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
