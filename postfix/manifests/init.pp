class postfix {
  $cyruspackage = $::osfamily ? {
    RedHat  => 'cyrus-sasl-plain',
    Debian  => 'libsasl2-2',
  }

  file { '/etc/postfix/main.cf':
    ensure  => present,
    source  => 'puppet:///modules/postfix/main.cf',
  }

  package { "${cyruspackage}":
    ensure => present
  }
}
