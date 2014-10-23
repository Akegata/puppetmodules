class common::firewalld {
  service { 'firewalld':
    ensure     => stopped,
    enable     => false,
    hasstatus  => true,
    hasrestart => true,
  }
}
