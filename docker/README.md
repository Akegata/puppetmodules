akegata-docker

Manage docker instances in systemd with hiera.
Installs docker 1.3.0 from binary, since CentOS 7 repos provide a very old docker version.

Contact
-------
Martin Hovmöller akegata@gmail.com

Support
-------
Tested on puppet 3.7.1, hiera 1.3.4 on CentOS 7.

Installation
------------
1) Install akegata-docker module
 
  Install the module by normal means.  You will also need to have puppet
  setup to work with hiera as a data store. 

2) Add the docker class in hiera
    classes
      - docker

3) Set up docker containers in hiera

    docker::container:
      apache:
        command: "/usr/bin/docker run -v '/var/www/httpd:/var/www/httpd/' -p 8080:80 --name httpd httpd

