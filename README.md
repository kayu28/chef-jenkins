# jenkins Cookbook for CentOS

[![Build Status](https://travis-ci.org/kayu28/chef-jenkins.svg?branch=master)](https://travis-ci.org/kayu28/chef-jenkins)

Installs and configures Jenkins

Requirements
------------

#### platforms
- `CentOS` - tested on CentOS 6.5

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
    <td><tt>['jenkins']['rpm']</tt></td>
    <td>String</td>
    <td><tt>jenkins-1.597-1.1.noarch.rpm</tt></td>
  </tr>
  <tr>
    <td><tt>['jenkins']['rpm_url']</tt></td>
    <td>String</td>
    <td><tt>http://pkg.jenkins-ci.org/redhat/jenkins-1.597-1.1.noarch.rpm</tt></td>
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
  <tr>
    <td><tt>['jenkins']['java_home']</tt></td>
    <td>String</td>
    <td><tt>/usr/lib/jvm/java</tt></td>
  </tr>
  <tr>
    <td><tt>['jenkins']['maven_home']</tt></td>
    <td>String</td>
    <td><tt>/opt/maven</tt></td>
  </tr>
</table>

Usage
------------

#### Berksfile
    source "https://api.berkshelf.com/"
    
    cookbook "jenkins"  , github: "kayu28/chef-jenkins"

