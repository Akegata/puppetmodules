# = Class: yum::repo::docker
#
# This class installs the docker repo
#
class yum::repo::docker {

  yum::managed_yumrepo { 'docker':
    descr          => 'Docker for Enterprise Linux 7 - $basearch',
    baseurl        => 'https://yum.dockerproject.org/repo/main/centos/$releasever/',
    enabled        => 1,
    gpgcheck       => 1,
    failovermethod => 'priority',
    gpgkey         => 'https://yum.dockerproject.org/gpg',
    priority       => 26,
  }

}
