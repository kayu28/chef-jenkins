#
# Cookbook Name:: jenkins
# Recipe:: configure-admin
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

require 'net/http'
require 'uri'

jenkins_url = "http://localhost:" + node['jenkins']['http_port'] + "/jenkins/"
jenkins_home = node['jenkins']['jenkins_home']

ruby_block "getVersion" do
  block do
    url = URI.parse(jenkins_url)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http| http.get(url.path)}
    node.set['jenkins']['version'] = res['x-jenkins']
  end
  only_if do !File.exists?("#{jenkins_home}/config.xml") end
end

template "config" do
  path "#{jenkins_home}/config.xml"
  source "config.xml.erb"
  owner node['jenkins']['user']
  group node['jenkins']['group']
  mode "0644"
  only_if do !File.exists?("#{jenkins_home}/config.xml") end
end

if node['jenkins']['maven_home']
  template "#{jenkins_home}/hudson.tasks.Maven.xml" do
    owner node['jenkins']['user']
    group node['jenkins']['group']
    mode "0644"
    only_if do !File.exists?("#{jenkins_home}/hudson.tasks.Maven.xml") end
  end
end
