class ssh::server::authorized_keys {
  $authorized_keys_defaults = { type => 'ssh-rsa' }
  create_resources('ssh_authorized_key', hiera_hash(authorized_keys), $authorized_keys_defaults)
}
