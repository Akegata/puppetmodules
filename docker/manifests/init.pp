# == Class: docker
#
class docker (
  $binary = '/usr/bin/docker',
){
  define docker::container (
    $envs = '',
    $options = '',
    $repository,
    $ports,
    $volumes = '',
  ){
    case $::osfamily {
      'RedHat': {
        case $::operatingsystemmajrelease {
          '6': {
            file { "$name":
              path    =>  "/etc/init.d/$name",
              mode    => '0755',
              owner   => 'root',
              group   => 'root',
              content => template('docker/initd_container.erb'),
              require => Service['docker']
            }
          }
          '7': {
            file { "$name":
              path    =>  "/usr/lib/systemd/system/$name.service",
              mode    => '0644',
              owner   => 'root',
              group   => 'root',
              content => template('docker/systemd_container.erb'),
              require => Service['docker']
            }
          }
        }
      }
    }
    service { "$name":
      ensure => 'running',
      enable => 'true',
      require => File["$name"]
    }
  }

  $container = hiera('docker::container', {})
  create_resources(docker::container, $container)

  case $::osfamily {
    'RedHat': {
      case $::operatingsystemmajrelease {
        '6': {
          package { 'docker-io':
            ensure => 'present',
          }

          service { 'docker':
            ensure => 'running',
            enable => 'true',
            require => Package['docker-io'],
          }
        }
        '7': {
          package { 'docker':
            ensure => 'absent',
          }
    
          file { '/usr/bin/docker':
            ensure  => 'present',
            source  => 'puppet:///modules/docker/docker',
            owner   => 'root',
            group   => 'root',
            mode    => '0555',
          }
    
          file { '/usr/lib/systemd/system/docker.service':
            ensure  => 'present',
            source  => 'puppet:///modules/docker/docker.service',
            owner   => 'root',
            group   => 'root',
            mode    => '0755',
          }
    
          file { '/usr/lib/systemd/system/docker.socket':
            ensure  => 'present',
            source  => 'puppet:///modules/docker/docker.socket',
            owner   => 'root',
            group   => 'root',
            mode    => '0755',
          }
    
          file { '/etc/bash_completion.d/docker.bash':
            ensure  => 'present',
            source  => 'puppet:///modules/docker/docker.bash',
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
          }
    
          file { '/usr/share/vim/vimfiles/syntax/dockerfile.vim':
            ensure  => 'present',
            source  => 'puppet:///modules/docker/dockerfile.vim',
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
          }
    
          file { '/usr/share/vim/vimfiles/ftdetect/dockerfile.vim':
            ensure  => 'present',
            source  => 'puppet:///modules/docker/dockerfile_ftdetect.vim',
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
          }
    
          file { '/usr/share/vim/vimfiles/doc/dockerfile.txt':
            ensure  => 'present',
            source  => 'puppet:///modules/docker/dockerfile.txt',
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
          }
    
          service { 'docker':
            ensure => 'running',
            enable => 'true',
            require => [ File['/usr/lib/systemd/system/docker.socket'],File['/usr/lib/systemd/system/docker.service'] ],
          }
        }
      }
    }
  }
}
