common::fsfiles {
  file { '/usr/local/sbin/backup.sh':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/backup.sh.pp"),
  }
}
