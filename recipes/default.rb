#
# Cookbook Name:: jenkins
# Recipe:: default
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

package 'wget' do
  action :install
end

remote_file '/tmp/' + node['jenkins']['rpm'] do
  source node['jenkins']['rpm_url']
  owner "root"
  group "root"
  mode "0755"
  not_if "test -e " + '/tmp/' + node['jenkins']['rpm']
end

package "jenkins" do
  action :install
  source '/tmp/' + node['jenkins']['rpm']
  provider Chef::Provider::Package::Rpm
  not_if "rpm -q jenkins"
end

template "jenkins" do
  path "/etc/sysconfig/jenkins"
  source "jenkins.erb"
  owner "root"
  group "root"
  mode "0644"
end

service "jenkins" do
  action [:enable, :start]
end

service 'iptables' do
    action [:disable, :stop]
end

JENKINS_URL = "http://localhost:8080/jenkins"

script "install-jenkins-cli" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    sleep 5
    http_response_code=503
    while [ $http_response_code -ne 200 ]
    do
      http_response_code=`curl -LI #{JENKINS_URL}/jnlpJars/jenkins-cli.jar -o /dev/null -w '%{http_code}' -s`
      echo $http_response_code
      sleep 5
    done
    wget -t 5 --waitretry 5 -O /tmp/jenkins-cli.jar #{JENKINS_URL}/jnlpJars/jenkins-cli.jar
  EOH
end

directory "/var/lib/jenkins/updates" do
  owner "jenkins"
  group "jenkins"
  mode "0755"
  action :create
end

script "update-jenkins-updatecenter" do
  interpreter "bash"
  user "jenkins"
  cwd "/tmp"
  code <<-EOH
    curl -L http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' > /var/lib/jenkins/updates/default.json
  EOH
  not_if "test -e /var/lib/jenkins/updates/default.json"
end

# Install Plugins
node['jenkins']['plugins'].each do |plugin_name|
  execute "install-jenkins-plugin-" + plugin_name do
    user "root"
    command "java -jar /tmp/jenkins-cli.jar -s #{JENKINS_URL} install-plugin " + plugin_name
    action :run
    not_if "/usr/local/bin/jenkins list-plugins | awk '{print $1}' | grep ^#{plugin_name}$"
    notifies :run, "execute[jenkins-safe-restart]"
  end
end

execute "jenkins-safe-restart" do
  command "java -jar /tmp/jenkins-cli.jar -s #{JENKINS_URL} safe-restart"
  action :nothing
end

