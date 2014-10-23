class ssh::server::service {
  include ssh::params
  include ssh::server

  if $::osfamily == 'Debian' {
    file { '/etc/init.d/ssh':
      ensure => link,
      target => '/lib/init/upstart-job',
    }
  }

  service { $ssh::params::service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['ssh::server::config'],
  }
}
