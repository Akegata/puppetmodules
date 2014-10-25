puppet-docker

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
        repository: 'akegata/apache2'
        envs:
          - 'APACHE_USER=apache'
        ports:
          - '8080:80'
        volumes:
          - '/var/www/httpd:/var/www/httpd/'


# docker

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with docker](#setup)
    * [What docker affects](#what-docker-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with docker](#beginning-with-docker)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Manage docker instances with hiera in RHEL/CentOS 7.

## Module Description

Creates systemd services for containers specified in hiera.

## Setup

### What docker affects

This module installs docker 1.3.0 from binary, since CentOS 7 repos provide a very old docker version.

### Beginning with docker

Add the docker class in hiera:
    classes
      - docker

## Usage

Set up docker containers in hiera:
    docker::container:
      apache:
        repository: 'akegata/apache2'
        envs:
          - 'APACHE_USER=apache'
        ports:
          - '8080:80'
        volumes:
          - '/var/www/httpd:/var/www/httpd/'

The following parameters are available:
* repository - Name of the repository on docker hub to use (mandatory)
* envs - Environmental variables (optional)
* ports - Ports to publish to the host (optional)
* volumes - Volumes to bind mount (optional)
* options - Other options to pass to docker run (optional)

## Reference

Contains a single class: docker.
A define called docker::container is created, which can be called through hiera as listed in Usage.

The module copies the following folders onto the system (they are taken from the CentOS 6.5 docker RPM):
* /usr/bin/docker
* /usr/lib/systemd/system/docker.service
* /usr/lib/systemd/system/docker.socket
* /etc/bash_completion.d/docker.bash
* /usr/share/vim/vimfiles/syntax/dockerfile.vim
* /usr/share/vim/vimfiles/ftdetect/dockerfile.vim
* /usr/share/vim/vimfiles/doc/dockerfile.txt

Services files are also created in /usr/lib/systemd/system for each container specified.

## Limitations

Only compatible with RHEL/CentOS 7 at this moment.
