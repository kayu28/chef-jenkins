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
default['jenkins']['repository']    = case node['platform_family']
                                      when 'debian' then 'http://pkg.jenkins-ci.org/debian'
                                      when 'rhel' then 'http://pkg.jenkins-ci.org/redhat'
                                      end
default['jenkins']['key']           = node['jenkins']['repository'] + '/jenkins-ci.org.key'
default['jenkins']['config_path']   = case node['platform_family']
                                      when 'debian' then '/etc/default/jenkins'
                                      when 'rhel' then '/etc/sysconfig/jenkins'
                                      end

default['jenkins']['version']       = '1.658-1.1'
default['jenkins']['user']          = 'jenkins'
default['jenkins']['group']         = 'jenkins'
default['jenkins']['http_port']     = '8080'

default['jenkins']['jenkins_home']  = '/var/lib/jenkins'
default['jenkins']['log_directory'] = '/var/log/jenkins'

default['jenkins']['plugins']       = [
  "git",
  "pmd",
  "checkstyle",
  "cobertura",
  "findBugs",
  "javadoc",
  "github-api",
  "github",
  "tasks",
  "warnings",
  "timestamper",
  "jobConfigHistory",
  "build-flow-plugin",
  "build-pipeline-plugin",
  "saferestart",
  "discard-old-build",
  "javancss",
  "websphere-deployer",
  "jenkins-cloudformation-plugin",
  "cloudfoundry",
  "mask-passwords"
]
