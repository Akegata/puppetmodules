class ssh::server::config {
  file { $ssh::params::sshd_config:
    ensure  => present,
    owner   => 0,
    group   => 0,
    mode    => '0600',
    content => template("${module_name}/sshd_config.erb"),
    require => Class['ssh::server::install'],
    notify  => Class['ssh::server::service'],
  }

#  ssh_authorized_key { 'root@fs':
#    user => 'root',
#    type => 'ssh-rsa',
#    key  => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAqtbfSshBoxEFVeKqCyZ1o+h5F75FBnKJhVwsr0oEEh/xaGbiBq7gqdvZQmoG46i8PR8fmDZqgqDFyGG6aHeFUl+gm9yiOkFw/EfJaUrCBkZQ7VLAjEPkQmujoVwcJ+cl3RmuI3814wF70a35zeiIcB6xD+/KkXfegWhOWVe2yf2QP/Xe6DLkP1ejyWVQdYshJDRn0s8oEz9DZj3HBE+IbgJMd3KVUJleL5N3Kxsb0LiIrw/v+tXLVV8ZKfn0l7XhJWCbLkVdngRKDEM2Q+v4HeVMUxsyoJg6HsY7MUGa0g8NV917SzBPB838thI4F2mmKDTPgQ0k0DQbvBqlucjyyQ==',
#  }
}
