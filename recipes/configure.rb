#
# Cookbook Name:: jenkins
# Recipe:: configure
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

template "jenkins" do
  path "/etc/sysconfig/jenkins"
  source "jenkins.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :http_port => node['jenkins']['http_port']
  })
end

template "config" do
  path "/var/lib/jenkins/config.xml"
  source "config.xml.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :java_name => node['jenkins']['java_name'],
    :java_home => node['jenkins']['java_home']
  })
end

template "/var/lib/jenkins/hudson.tasks.Maven.xml" do
  owner "root"
  group "root"
  mode "0644"
  variables({
    :maven_name => node['jenkins']['maven_name'],
    :maven_home => node['jenkins']['maven_home']
  })
end

