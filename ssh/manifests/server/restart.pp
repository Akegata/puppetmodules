class ssh::server::restart {
  exec { "/usr/bin/systemctl restart sshd.service":
  }
}
