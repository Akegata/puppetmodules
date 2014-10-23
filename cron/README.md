lsit-cron

Manage the /etc/crontab file and cron service.  Allows for a site-wide and node-specific list
 of job entries.  Data is stored in hiera.

License
-------
Distributed under the New BSD License

Contact
-------
Jose Guevarra jguevarra@lsit.ucsb.edu

Support
-------
This module was tested on puppet 2.7.0, hiera 1.0.0 on Ubuntu, Gentoo, Scientific(RH) systems.

Installation
------------
1) Install lsit-cron module
 
  Install the module by normal means.  You will also need to have puppet
  setup to work with hiera as a data store. 

  By default, the cron module will write to /etc/crontab and use its own
  template.

2) Set cron service parameters in hiera
  "cron::enable" determines whether the cron service should be started on 
  startup.  "cron::ensure" determines whether the cron service should be 
  running or not.  Example below.

    cron::enable: true
    cron::ensure: true

3) Set cron variables

    ## Cron module
    cron::crontab_vars_hsh:
      SHELL: /bin/bash
      PATH: /sbin:/bin:/usr/sbin:/usr/bin
      MAILTO: admin@example.com
      HOME: /root


4) Add site-wide job entries

  Site-wide values are stored in "cron::crontab_site_job_hsh".  Add site-wide job
  entries to your common.yaml file or which ever file you use to store
  site-wide heira values.  Entries are organized into sections; 
  "rotate logs", by example below.  You must have at least one section.
  See example below.

    cron::crontab_site_job_hsh
      'check scripts in cron.hourly, cron.daily, cron.weekly and cron.monthly': 
        - "*/15 *     *    *    *     root    test -x /usr/sbin/run-crons && /usr/sbin/run-crons"
        - "0    *     *    *    *     root    rm -f /var/spool/cron/lastrun/cron.hourly"
        - "0    0     *    *    *     root    rm -f /var/spool/cron/lastrun/cron.daily"
        - "0    0     *    *    6     root    rm -f /var/spool/cron/lastrun/cron.weekly"
        - "0    0     1    *    *     root    rm -f /var/spool/cron/lastrun/cron.monthly"
      'rotate logs': 
        - "0    0     *    *    *     root    /usr/sbin/logrotate /etc/logrotate.conf"

Result

    ## Site Wide Jobs
    
    # check scripts in cron.hourly, cron.daily, cron.weekly and cron.monthly
     */15 *     *    *    *     root    test -x /usr/sbin/run-crons && /usr/sbin/run-crons
     0    *     *    *    *     root    rm -f /var/spool/cron/lastrun/cron.hourly
     0    0     *    *    *     root    rm -f /var/spool/cron/lastrun/cron.daily
     0    0     *    *    6     root    rm -f /var/spool/cron/lastrun/cron.weekly
     0    0     1    *    *     root    rm -f /var/spool/cron/lastrun/cron.monthly
    
    # rotate logs
     0    0     *    *    *     root    /usr/sbin/logrotate /etc/logrotate.conf


5) Node specific job entries

  Node-specific values are stored in "cron::crontab_node_job_hsh".  You can
  add job entries that are specific to a particular node by configuring hiera
  to lookup node-specific values first. Adding the section "nodes/%{fqdn}" tells
  hiera took look for values in nodes yaml file(e.g. nodes/leia.example.com.yaml)
  before it searches the site-wide or os-specific values.

    example hiera.yaml
    ---
    :backends: - yaml
    
    :logger: console
    
    :hierarchy: - nodes/%{fqdn}
                - os/%{operatingsystem}
                - common
    :yaml:
       :datadir: /etc/puppet/hieradata

6) Operating System specific job entries

  The hiera.yaml file above shows that you can separate jobs based off of the
  OS of the node.  So you could add jobs to "cron::crontab_site_job_hsh" in say,
  "os/Ubuntu.yaml".  Puppet will use those values instead of the ones in common.yaml.

7)  Overriding template and crontab file path

  The template and crontab file path variables are stored in "cron::crontab_tmpl" 
  and "cron::crontab_path", respectively.  You can override these values by setting
  them in either the site-wide or the node-specific data store.
  
  Note: When overriding the "cron::crontab_path", puppet will search with
  respect to the default template directory.

8) Set "puppetheader" variable(optional)

  In general, it is a good idea to have a header on puppet-managed files.  The
  hosts module expects a variable named "puppetheader" to hold the puppet header
  string. By default, it uses "Managed By Puppet".  Override this by adding the
  "puppetheader" value in your heira data store.

# Usage Example (Gentoo)
    
    nodes/leia.example.com.yaml
    --------------------------
    
    cron::crontab_path: /tmp/crontab.test
    
    cron::crontab_node_job_hsh:
      'Backup some files':
        - "*/5   *  *  *  * root  /root/backup_script"

    
    common.yaml
    -----------
    
    puppetheader: Managed by Puppet @ Example.com
    
    ## Cron module
    cron::enable: true     # on startup
    cron::ensure: true     # running
    
    cron::crontab_vars_hsh:
      SHELL: /bin/bash
      PATH: /sbin:/bin:/usr/sbin:/usr/bin
      MAILTO: admin@example.com
      HOME: /root
    
    cron::crontab_site_job_hsh:
      'check scripts in cron.hourly, cron.daily, cron.weekly and cron.monthly': 
        - "*/15 *     *    *    *     root    test -x /usr/sbin/run-crons && /usr/sbin/run-crons"
        - "0    *     *    *    *     root    rm -f /var/spool/cron/lastrun/cron.hourly"
        - "0    0     *    *    *     root    rm -f /var/spool/cron/lastrun/cron.daily"
        - "0    0     *    *    6     root    rm -f /var/spool/cron/lastrun/cron.weekly"
        - "0    0     1    *    *     root    rm -f /var/spool/cron/lastrun/cron.monthly"
      'rotate logs': 
        - "0    0     *    *    *     root    /usr/sbin/logrotate /etc/logrotate.conf"

## Output

    
    ## Managed by Puppet
    # for vixie-cron
    
    ## Variables
    HOME=/root 
    MAILTO=admin@example.com 
    PATH=/sbin:/bin:/usr/sbin:/usr/bin 
    SHELL=/bin/bash 
    
    # Example of job definition:
    # .---------------- minute (0 - 59)
    # |  .------------- hour (0 - 23)
    # |  |  .---------- day of month (1 - 31)
    # |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
    # |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
    # |  |  |  |  |
    # *  *  *  *  * username command-to-be-executed
    
    ## Site Wide Jobs
    
    # check scripts in cron.hourly, cron.daily, cron.weekly and cron.monthly
     */15 *     *    *    *     root    test -x /usr/sbin/run-crons && /usr/sbin/run-crons
     0    *     *    *    *     root    rm -f /var/spool/cron/lastrun/cron.hourly
     0    0     *    *    *     root    rm -f /var/spool/cron/lastrun/cron.daily
     0    0     *    *    6     root    rm -f /var/spool/cron/lastrun/cron.weekly
     0    0     1    *    *     root    rm -f /var/spool/cron/lastrun/cron.monthly
    
    # rotate logs
     0    0     *    *    *     root    /usr/sbin/logrotate /etc/logrotate.conf
    
    ## Node Specific Jobs
    
    # Backup some files
     */5   *  *  *  * root  /root/backup_script


