class common::backup (
  $mail = hiera('common::backup::mail')
){
  file { '/usr/local/sbin/backup.sh':
    ensure  => present,
    content => template('common/backup.sh.erb'),
  }
}
