#
# Cookbook Name:: jenkins
# Attributes:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# default attributes
default['jenkins']['jenkins_home']  = '/var/lib/jenkins'
default['jenkins']['log_directory'] = '/var/log/jenkins'
default['jenkins']['version']       = '1.643'
default['jenkins']['user']          = 'jenkins'
default['jenkins']['group']         = 'jenkins'
default['jenkins']['password']      = 'jenkins'
default['jenkins']['http_port']     = '8080'
default['jenkins']['java_name']     = 'java'
default['jenkins']['java_home']     = '/usr/lib/jvm/java'
default['jenkins']['maven_name']    = 'maven'
default['jenkins']['maven_home']    = '/opt/maven'
default['jenkins']['plugins']       = [
  "git"
]
