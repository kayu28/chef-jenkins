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
default['jenkins']['jenkins_home'] = '/var/lib/jenkins'
default['jenkins']['rpm'] = "jenkins-1.589-1.1.noarch.rpm"
default['jenkins']['rpm_url'] = "http://pkg.jenkins-ci.org/redhat/jenkins-1.589-1.1.noarch.rpm"
default['jenkins']['http_port'] = '8080'
default['jenkins']['plugins'] = [
  "git",
  "pmd",
  "checkstyle",
  "cobertura",
  "findBugs",
  "javadoc",
  "ansicolor",
  "timestamper",
  "jobConfigHistory",
  "build-flow-plugin",
  "monitoring",
  "deploy",
  "saferestart",
  "disk-usage",
  "discard-old-build",
  "redmine"
]
