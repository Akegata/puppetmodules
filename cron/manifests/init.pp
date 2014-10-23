# == Class: cron
#
# Manage the /etc/crontab file with the hiera data store.  Allows for a list of 
#  site-wide hosts as well as node-specific list of job entries.
#
# === Usage
#
#  @see README
#
# === Authors
#
# Jose Guevarra <jguevarra@lsit.ucsb.edu>
#
# === Copyright
#
# Copyright 2012 UC Regents, Distributed under the New BSD License
#

/**
 * Manage config files
 */
class cron::crontab::config {

  # Set default values
  $puppetheader = hiera('puppetheader', 'Managed by Puppet')

  $crontab_tmpl = hiera('cron::crontab_tmpl', 'cron/crontab.erb')
  $crontab_path = hiera('cron::crontab_path', '/etc/crontab')
  $crontab_vars_hsh = hiera('cron::crontab_vars_hsh', {})
  $crontab_site_job_hsh = hiera('cron::crontab_site_job_hsh', {})
  $crontab_node_job_hsh = hiera('cron::crontab_node_job_hsh', {})
  
  ## file
  file { "crontab":
    ensure  => 'present',
    path    => $crontab_path,
    content => template($crontab_tmpl),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}

/**
 * Manage services
 */
class cron::service(
  $enable = hiera('cron::enable', 'true'),
  $ensure = hiera('cron::ensure', 'true')
  ) {

  $crondaemon = $::osfamily? {
    'RedHat' => 'crond',
    'Debian' => 'cron',
  }
    
  service {"$crondaemon":
    enable      => $enable,                     # true (start on boot) 
    ensure      => $ensure,                     # true (running), false (stopped)
    name        => $service_name,
    hasstatus   => $hasstatus ? {'false' => 'false', default => true},
    status      => $hasstatus ? {'false' => $status, default => undef},
    require     => Class['cron::crontab::config'],
    subscribe   => File['crontab'],
  }
  
}

## cron class
class cron {
  
  # Note that these matches are case-insensitive
  case $operatingsystem {
    ubuntu: {$package_name = 'cron' $service_name = 'cron'}
    gentoo: {$package_name = 'vixie-cron' $service_name = 'vixie-cron' $hasstatus = 'false' $status = 'pgrep cron'}
    redhat, scientific, centos: {$package_name = 'crontabs' $service_name = 'crond'}
    default: {fail('Unable to find appropriate cron package for this OS.')}
  }
  
  include cron::crontab::config, cron::service
}
