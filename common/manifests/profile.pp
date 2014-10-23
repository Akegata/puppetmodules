class common::profile
{
  file { '/etc/profile.d/ps1.sh':
    ensure  => present,
    content => 'export PS1="\[\e[00;33m\]\u\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;33m\]@\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;36m\]\w\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;36m\]\\$\[\e[0m\]\[\e[00;37m\] \[\e[0m\]"',
    mode    => 0655,
  }

  file { '/etc/profile.d/ls_colors.sh':
    ensure  => present,
    content => "LS_COLORS='di=38;5;43' ; export LS_COLORS",
    mode    => 0655,
  }

  if ($::operatingsystem == 'Ubuntu') {
    file { '/root/.bashrc':
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/common/root_bashrc'
    }
  }
}
