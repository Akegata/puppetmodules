class common::vim {

  $vimrc = $::osfamily? {
    'RedHat' => '/etc/vimrc',
    'Debian' => '/etc/vim/vimrc.local',
  }

  file { $vimrc:
    ensure  => present,
    source  => 'puppet:///modules/common/vimrc',
  }

  if ($::osfamily == 'RedHat') {
    package { 'vim-enhanced':
      ensure => present
    }
  }
}
