class common
{
  package { 'bash-completion':
    ensure => present
  }

  package { 'lsof':
    ensure => present
  }

  package { 'mlocate':
    ensure => present
  }

  package { 'rsync':
    ensure => present
  }

  package { 'smartmontools':
    ensure => present
  }

  package { 'unzip':
    ensure => present
  }
  
  package { 'yum-cron':
    ensure => present
  }

  package { 'wget':
    ensure => present
  }

  class { 'common::hosts':
  }

  class { 'common::profile':
  }

  class { 'common::vim':
  }
}
