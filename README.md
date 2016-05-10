# jenkins Cookbook

[![Build Status](https://travis-ci.org/kayu28/chef-jenkins.svg?branch=master)](https://travis-ci.org/kayu28/chef-jenkins)

Installs and configures Jenkins

Requirements
------------

#### platforms
- `RedHat` - tested on Red Hat Enterprise Linux 7.2
- `CentOS` - tested on CentOS 6.5
- `Amazon` - tested on Amazon Linux AMI 2015.09.1
- `Ubuntu` - tested on ubuntu 14.04

Attributes
----------

#### jenkins::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['jenkins']['jenkins_home']</tt></td>
    <td>String</td>
    <td><tt>/var/lib/jenkins</tt></td>
  </tr>
  <tr>
    <td><tt>['jenkins']['log_directory']</tt></td>
    <td>String</td>
    <td><tt>/var/log/jenkins</tt></td>
  </tr>
  <tr>
    <td><tt>['jenkins']['http_port']</tt></td>
    <td>String</td>
    <td><tt>8080</tt></td>
  </tr>
  <tr>
    <td><tt>['jenkins']['plugins']</tt></td>
    <td>Array</td>
    <td><tt>%w[
  git
]</tt></td>
  </tr>
</table>

Usage
------------

#### Berksfile
    source "https://api.berkshelf.com/"
    
    cookbook "jenkins"  , github: "kayu28/chef-jenkins"

