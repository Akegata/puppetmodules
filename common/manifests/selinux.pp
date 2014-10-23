class common::selinux {

  file { '/etc/selinux/config':
    ensure  => present,
    source  => 'puppet:///modules/common/selinux_config',
  }
}
