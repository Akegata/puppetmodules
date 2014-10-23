pkill -9 puppet > /dev/null 2>&1

/usr/bin/puppet agent --onetime --no-daemonize --logdest syslog > /dev/null 2>&1
