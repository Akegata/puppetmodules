# Class puppet::install

class puppet::install {
  package { 'puppet':
    ensure => present,
  }

#  unless $::operatingsystemrelese == '10.04' {
#    package { 'ruby-augeas':
#      ensure => present,
#    }
#  }

  case $::osfamily {
    'RedHat': {
      package { 'augeas-libs':
        ensure => present,
      }
    }
    'Debian': {
      package { 'libaugeas-ruby':
        ensure => present,
      }

      package { 'augeas-lenses':
        ensure => present,
      }
      
      package { 'libaugeas0':
        ensure => present,
      }
    }
    default: {}
  }
}
