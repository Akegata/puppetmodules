# Class puppet::cron

class puppet::cron {
  file {
    'runpuppet.sh':
    ensure => file,
    path   => '/usr/local/sbin/runpuppet.sh',
    source => "puppet:///modules/${module_name}/runpuppet.sh",
    group  => root,
    owner  => root,
    mode   => '0744',
  }
}
