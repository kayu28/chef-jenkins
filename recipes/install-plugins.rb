#
# Cookbook Name:: jenkins
# Recipe:: install-plugins
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

JENKINS_URL = "http://localhost:" + node['jenkins']['http_port'] + "/jenkins"

# Install Plugins
node['jenkins']['plugins'].each do |plugin_name|
  execute "install-jenkins-plugin-" + plugin_name do
    user "root"
    command "java -jar /tmp/jenkins-cli.jar -s #{JENKINS_URL} install-plugin " + plugin_name
    action :run
    not_if "java -jar /tmp/jenkins-cli.jar -s #{JENKINS_URL} list-plugins | awk '{print $1}' | grep ^#{plugin_name}$"
    notifies :run, "execute[jenkins-safe-restart]"
  end
end

execute "jenkins-safe-restart" do
  command "java -jar /tmp/jenkins-cli.jar -s #{JENKINS_URL} safe-restart"
  action :nothing
end

