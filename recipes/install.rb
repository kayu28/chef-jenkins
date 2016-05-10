#
# Cookbook Name:: jenkins
# Recipe:: install
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

case node['platform_family']
when 'debian'
  execute "apt-get update" do
    command "apt-get update"
  end
end

case node['platform_family']
when 'debian'
  include_recipe 'apt::default'
  apt_repository 'jenkins' do
    uri node['jenkins']['repository']
    key node['jenkins']['key']
    components ["binary/"]
    action :add
  end
when 'rhel'
  include_recipe 'yum::default'
  yum_repository 'jenkins-repo' do
    description 'jenkins'
    baseurl node['jenkins']['repository']
    gpgkey node['jenkins']['key']
    action :create
  end
end

# install jenkins.
package "jenkins" do
  version node['jenkins']['version']
  action :install
end

template "jenkins" do
  path node['jenkins']['config_path']
  source 'jenkins.' + node['platform'] + '.erb'
  owner node['jenkins']['user']
  group node['jenkins']['group']
  mode "0644"
  notifies :restart, 'service[jenkins]', :immediately
end

service "jenkins" do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
