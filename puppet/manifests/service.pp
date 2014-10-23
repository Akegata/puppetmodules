# Class puppet::service
class puppet::service {
  service { 'puppet':
    ensure      => stopped,
    hasrestart  => true,
    hasstatus   => true,
  }
}
